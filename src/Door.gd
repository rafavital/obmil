extends Spatial

signal exited_room (door, body)


func _on_ExitTrigger_body_entered(body: Node) -> void:
	pass
	#emit_signal("exited_room", self, body)


func _on_ExitTrigger_area_entered(area: Area) -> void:
	emit_signal("exited_room", self, area)
