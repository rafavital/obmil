extends Spatial

export (Array, PackedScene) var rooms
var room_nodes = []
var rng = RandomNumberGenerator.new()

func _ready() -> void:
	for	room in get_children():
		room.connect("exited_room", self, "_on_generate_new_room")
		


func _on_generate_new_room (room) -> void:
	var pos = room.transform.origin
	room.queue_free()
	
	var id = rng.randi_range(0, rooms.size() - 1)
	
	var r = rooms[id].instance()
	
	r.transform.origin = pos
	r.connect("exited_room", self, "_on_generate_new_room")
	
	add_child(r)
