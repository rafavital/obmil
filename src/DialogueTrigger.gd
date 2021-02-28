extends Area

export (int) var dialogue_id := -1
var rng = RandomNumberGenerator.new()

func _ready() -> void:
	rng.randomize()
	var file = File.new()
	assert (file.file_exists (Global.en_dialogues_path))

	file.open (Global.en_dialogues_path, File.READ)
	var dialogue = parse_json(file.get_as_text()) as Dictionary
	assert (dialogue.size() > 0)
	
	dialogue_id = rng.randi_range(0, dialogue.size()-1)
	
