extends Area2D

var coins = 0

signal coin_collected

func _body_entered(body):
	queue_free()
	coins =+ 1
	$AudioStreamPlayer.play()
	emit_signal("coin_collected")
