extends Node2D

@export var restricted: bool

@export var sprite: AnimatedSprite2D
@export var number: AnimatedSprite2D

@export var zero_box: StaticBody2D
@export var one_box: StaticBody2D
@export var two_box: StaticBody2D

@export var high_mark: Marker2D
@export var mid_mark: Marker2D
@export var low_mark: Marker2D

var end_width: int = 0
const return_width: int = 144
var screen_buffer: = 32

func _ready() -> void:
	end_width = abs(return_width - screen_buffer)
	
	$return_box/CollisionShape2D.shape.size.x = end_width
	@warning_ignore("integer_division")
	$return_box/CollisionShape2D.position.x = -end_width/2 + 216
	
	if position.x > 0:
		scale.x *= -1
		number.flip_h = true

func update_level(level:int):
	level = abs(level)
	var tier: int = 0
	
	@warning_ignore("integer_division")
	tier = (level)/3
	
	#print(tier)
	if tier > 2:
		tier = 2
		
	elif tier < 0:
		tier = 1
	
	#$Label.text = "( " + str(level) + ", " + str(tier) + " ) " + str(level/3)
	
	sprite.frame = tier
	number.frame = level % 9
	
	match(tier):
		0:
			one_box.queue_free()
			two_box.queue_free()
			number.position = low_mark.position
		1:
			zero_box.queue_free()
			two_box.queue_free()
			number.position = mid_mark.position
		2:
			one_box.queue_free()
			zero_box.queue_free()
			number.position = high_mark.position
			
		_:
			level = 8
	
