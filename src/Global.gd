extends Node

const en_dialogues_path := 'res://assets/dialogue/dialogue_en.json'
#const en_dialogues_path := res://assets/dialogue/dialogue_en.json
var dialogues = {}

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_select"):
		OS.window_fullscreen = !OS.window_fullscreen


