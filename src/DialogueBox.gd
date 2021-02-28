extends Control

export (String, FILE, "*.json") var dialogue_file_path : String

onready var text = $DialogueText
onready var bg = $Background
onready var show_tween = $ShowDialogueTween

var dialogue_finished := false
var current_dialogue : String

func _ready () -> void:
	_hide()	
	dialogue_finished = false


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
	var dialogue = load_dialogue()
	
	dialogue_finished = false
	print (dialogue)
	text.bbcode_text = dialogue[str(id)]
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
	bg.hide()
	text.hide()

func _show () -> void:
	bg.show()
	text.show()


func _on_ShowDialogueTween_tween_all_completed() -> void:
	dialogue_finished = true
