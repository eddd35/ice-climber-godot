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
	state = states.walking
	
	print(init_pos)
	
	@warning_ignore("integer_division")
	if position.x < screen_width/2:
		turn()
		sprite.modulate.b8 = 23
		
	else:
		velocity.x = -speed

@warning_ignore("unused_parameter")
func _physics_process(delta: float) -> void:
	move_and_slide()
	
	if !(wait):
		_change_state()
		_animate()
	else:
		wait -= 1
		
	@warning_ignore("integer_division")
	if abs(position.x - screen_width/2) > (screen_width)/2:
		position.x = int(position.x+screen_width) % (screen_width)
		
	#print("SCALE")
	#print(scale.x)
	#print("VELOCITY")
	#print(velocity.x)
	
	#$Label.text = "STATE " + str(state) + " COLL " + str(!(down.is_colliding()))

func _change_state():
	if !(down.is_colliding()) && state == states.walking:
		
		state = states.returning
		turn()
		velocity.x *= 2
		wait = 10
		
	elif !(down.is_colliding()) && state == states.returning:
		state = states.hit
		
	elif !(down.is_colliding()) && state == states.hit:
		velocity.y = 100
		velocity.x = 0
		
	elif (down.is_colliding()) && state == states.hit:
		velocity.y = 0
		velocity.x = (sign(scale.x))*speed
		
func _animate():
	match(state):
		states.walking:
			sprite.animation = "walk"
			
		states.hit:
			sprite.animation = "hurt"
			
		states.returning:
			sprite.animation = "walk"

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
