extends Camera2D
class_name Icies_Camera

#keep the box at -264.5 (y)
#for debug, move to 167

@export var killbox: Area2D
@export var advance_box: Area2D

var advancing: bool = false

var max_travel: int = 144

func _ready() -> void:
	killbox.body_entered.connect(_on_diezone_body_entered)

func _on_diezone_body_entered(body: Node2D) -> void:
	if (body is Player):
		body.go_die()
