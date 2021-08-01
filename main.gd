extends Node2D

func _physics_process(delta):
	if $Button.pressed:
		get_tree().change_scene("res://level1.tscn")
