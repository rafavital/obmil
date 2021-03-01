extends Control

export (String, FILE, "*.json") var dialogue_file_path : String

onready var text = $UIElements/DialogueText
onready var show_tween = $ShowDialogueTween
onready var ui_elements = $UIElements

var dialogue_finished := false
var current_dialogue : String
var rng = RandomNumberGenerator.new()

func _ready () -> void:
	_hide()	
	dialogue_finished = true


func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("interact"):
		if dialogue_finished:
			_hide()
		else:
			show_tween.stop_all()
			text.percent_visible = 1
			_show()
			dialogue_finished = true

func show_dialogue (id : int) -> void:
	rng.randomize()
	
	var dialogue = load_dialogue()
	
	dialogue_finished = false
	var txt = dialogue[str(id)]
	text.bbcode_text = txt
	Global.dialogues[id] = txt
	
	text.percent_visible = 0
	
	show_tween.interpolate_property(
		text, 
		"percent_visible", 0, 1, 1, 
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		
	show_tween.start()
	
	
	_show()
	pass
	
func load_dialogue () -> Dictionary:
	var file = File.new()
	assert (file.file_exists (dialogue_file_path))

	file.open (dialogue_file_path, File.READ)
	var dialogue = parse_json(file.get_as_text()) as Dictionary
	assert (dialogue.size() > 0)

	return dialogue


func _hide () -> void:
	ui_elements.hide()


func _show () -> void:
	ui_elements.show()


func _on_ShowDialogueTween_tween_all_completed() -> void:
	dialogue_finished = true
