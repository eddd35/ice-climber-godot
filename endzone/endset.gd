extends Node2D

@export var left: Node2D
@export var right: Node2D

signal updated

func _ready() -> void:
	updated.connect(left.update_level)
	updated.connect(right.update_level)
	
	left.position.x = (768-144)/2
	right.position.x = -1*left.position.x
	
	update_level()

func update_level():
	var level: int = abs(.5*((position.y/72)+1)-1)
	#$Label.text = str(level) + ", " + str(level/3)
	updated.emit(level)
