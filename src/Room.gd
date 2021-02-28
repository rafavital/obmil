class_name Room
extends Spatial

signal exited_room (room)

export (int) var room_id = 0


func _ready() -> void:
	for door in get_children():
		door.connect("body_entered", self, "_on_ExitTrigger_body_entered")
	if room_id == -1:
		print (get_tree().current_scene.name)


func _on_ExitTrigger_body_entered(body: Node) -> void:
	var dir = sign(transform.basis.z.dot(body.transform.basis.z))
	if dir > 0:
		emit_signal("exited_room", self)


func _on_Door_exited_room(door, body) -> void:
	if body.is_in_group("player"):
		var dot = door.get_global_transform().basis.z.dot(body.get_global_transform().basis.z)
		if dot > 0.4:
			emit_signal("exited_room", self)	
	
