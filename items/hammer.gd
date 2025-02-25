extends Area2D
class_name Hammer

@export var sprite: AnimatedSprite2D

@export var low: Marker2D
@export var up: Marker2D
@export var top_front: Marker2D
@export var back: Marker2D

@export var hitbox: CollisionShape2D 

enum states { fall = 0, swing, jump } 
var state = 0
var facing_left: bool

var player: Node2D

signal deleted
signal frame_changed

func _ready() -> void:
	deleted.connect(_delete)
	position = player.position
	if (!(facing_left)):
		_flip()
	
func _process(delta: float) -> void:
	match(state):
		states.swing:
			
			match(sprite.frame):
				0:
					sprite.position = up.position
					hitbox.position = up.position
					frame_changed.emit(sprite.frame)
					
				1:
					hitbox.position = top_front.position
					sprite.position = top_front.position
					frame_changed.emit(sprite.frame)
					
				2:
					hitbox.position = low.position
					sprite.position = low.position
					frame_changed.emit(sprite.frame)
					
				3:
					deleted.emit()
					
				_:
					sprite.play("swing")
		
		states.fall:
			_fall()
			position = player.position
			
		states.jump:
			_jump()
			position = player.position

func _fall():
	sprite.play("fall")
	hitbox.position = up.position
	sprite.position = up.position
	
func _jump():
	sprite.play("jump")
	
	hitbox.position = back.position
	sprite.position = back.position
	
func _flip():
	low.position.x *= -1
	up.position.x *= -1
	top_front.position.x *= -1
	back.position.x *= -1
	sprite.flip_h = true
	#position.x *= -1
	facing_left = !(facing_left)

func _delete():
	queue_free()
