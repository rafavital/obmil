class_name Room
extends Spatial

signal exited_room (room)

func _on_ExitTrigger_body_entered(body: Node) -> void:
	var dir = sign(transform.basis.z.dot(body.transform.basis.z))
	if dir > 0:
		emit_signal("exited_room", self)
