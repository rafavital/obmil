extends Spatial

signal exited_room (door, body)


func _on_ExitTrigger_body_entered(body: Node) -> void:
	emit_signal("exited_room", self, body)
