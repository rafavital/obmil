extends Spatial

export (String) var animation = "NONE"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play(animation)

