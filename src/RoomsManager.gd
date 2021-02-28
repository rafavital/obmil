extends Spatial

export (Array, PackedScene) var rooms
var rng = RandomNumberGenerator.new()


func _ready() -> void:
	for	room in get_children():
		room.connect("exited_room", self, "_on_generate_new_room")


func _on_generate_new_room (room) -> void:
	var pos = room.transform.origin
	var basis = room.transform.basis
	var prev_room_id = room.room_id
	
	var id = rng.randi_range(0, rooms.size() - 1)
	if id == prev_room_id:
		print ("repeating room")
	
	print("generating room " + str(id))
	room.queue_free()
	var r = rooms[id].instance()
	
	r.transform.origin = pos
	r.transform.basis = basis
	r.connect("exited_room", self, "_on_generate_new_room")
	
	add_child(r)
