extends StaticBody2D
class_name Block

@export var bounding_box: StaticBody2D
@export var sprite: Sprite2D

#func _ready() -> void:
	#$Label.text = str(((int((position.y)/$bounding.shape.size.y)-1)+6)/18)
