extends CharacterBody2D
class_name Topi

@export var speed: int = 75
@export var sprite: AnimatedSprite2D
@export var down: RayCast2D
@export var infront: Marker2D
@export var hurtbox: Area2D

enum states { hit = 0, walking, returning }

var state: int = 1
var wait: int = 10
var init_pos: Vector2

var screen_width: int = 20

signal freezie_needed

func _ready() -> void:
	@warning_ignore("narrowing_conversion")
	screen_width = get_viewport_rect().size.x
	init_pos = position


func _on_area_2d_area_entered(area: Area2D) -> void:
	#print(area.collision_layer)
	match(area.collision_layer):
		8:
			state = states.hit
			_turn()
		
		128:
			
			#print(state)
			
			match(state):
				states.walking:
					_turn()
					
				states.returning:
					_turn()
					state = states.walking
					_spawn_freezie()
					
				states.hit:
					state = states.walking 
					position = init_pos

func _spawn_freezie():
	freezie_needed.emit(infront.global_position, speed)

func _connect_signal(level: Node2D):
	freezie_needed.connect(level._add_freezie)

func _turn():
	scale.x *= -1
	velocity.x = sign(infront.global_position.x - global_position.x)*speed #I hate this, but it works, fix it later
