extends KinematicBody2D

var velocity = Vector2.ZERO
var speed = 60.0
var jump_speed = 150.0
var gravity = 5.0
var on_floor = false
var up_direction = Vector2(0, -1)
var on_wall = false
var direction = "right"
var grip = 0.2

func _physics_process(delta):
	
	if Input.is_action_pressed("ui_right"):
		velocity.x = velocity.x + 15
		direction = "right"
		if velocity.x > speed:
			velocity.x = speed
		$Sprite/AnimationPlayer.play("walk_right")
	elif Input.is_action_pressed("ui_left"):
		velocity.x = velocity.x - 15
		direction = "left"
		if velocity.x < -speed:
			velocity.x = -speed
			$Sprite/AnimationPlayer.play("walk_left")
	else: 
		velocity.x = velocity.x / (grip + 1)
	
	if on_floor:
		velocity.y = 0
	if not on_floor:
		if direction == "right":
			$Sprite/AnimationPlayer.play("jump_right")
		else:
			$Sprite/AnimationPlayer.play("jump_left")
	
	if Input.is_action_just_pressed("ui_up"):
		if on_floor:
			velocity.y = -jump_speed
		
	velocity.y = velocity.y + gravity
	if velocity.y > 500:
		velocity.y = 300
	
	if not Input.is_action_pressed("ui_right") and not Input.is_action_pressed("ui_left") and on_floor:
		if direction == "right":
			$Sprite/AnimationPlayer.play("stand_right")
		elif direction == "left":
			$Sprite/AnimationPlayer.play("stand_left")
	
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene("res://main.tscn")
	
	move_and_slide(velocity, up_direction)
	on_floor = is_on_floor() 

func _on_finish_body_entered(body):
		get_tree().change_scene("res://level2.tscn")
func _on_finish2_body_entered(body):
	get_tree().change_scene("res://level3.tscn")

func _on_fallzone2_body_entered(body):
	get_tree().change_scene("res://level2.tscn")
func _on_fallzone_body_entered(body):
	get_tree().change_scene("res://level1.tscn")
func _on_fallzone3_body_entered(body):
	get_tree().change_scene("res://level3.tscn")
