extends Spatial

onready var dialogue_box = $UI/DialogueBox

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()


func _on_Player_called_dialogue(id) -> void:
	dialogue_box.show_dialogue(id)
