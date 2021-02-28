class_name Room
extends Spatial

signal exited_room (room)

func _ready() -> void:
	for door in get_children():
		door.connect("body_entered", self, "_on_ExitTrigger_body_entered")


func _on_ExitTrigger_body_entered(body: Node) -> void:
	var dir = sign(transform.basis.z.dot(body.transform.basis.z))
	if dir > 0:
		emit_signal("exited_room", self)


func _on_Door_exited_room(door, body) -> void:
	if body.is_in_group("Player"):
		var dir = sign(door.transform.basis.z.dot(body.transform.basis.z))
		if dir > 0:
			emit_signal("exited_room", self)	
			print ("SAIU")
	
