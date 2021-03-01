extends Control

var can_start := false


func _input(event: InputEvent) -> void:
	if Input.is_key_pressed(KEY_E):
		get_tree().change_scene("res://assets/scenes/world.tscn")



func _on_TimeToRead_timeout() -> void:
	can_start = true
	$PressToPlay.show()
