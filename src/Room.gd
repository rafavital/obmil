extends Spatial




func _on_ExitTrigger_body_entered(body: Node) -> void:
	var dir = sign(transform.basis.z.dot(body.transform.basis.z))
	if dir > 0:
		queue_free()
