extends CharacterBody2D
class_name Player

@export var speed: int = 150
@export var jump_height: int = 600

@export var sprite: AnimatedSprite2D

@export var down_left: RayCast2D
@export var down: RayCast2D
@export var down_right: RayCast2D

@export var bounce_box: Area2D
@export var hat: Area2D
@export var hurtbox: Area2D

@export var state_machine: State_Machine

var facing_left: bool = true
var screen_width: int = 1
var gravity: int = 10
var direction: float = 0
var current_state: String = "null"

signal landed
signal falling
signal jumping
signal flip
signal die

func _ready() -> void:
	_set_facing()
	bounce_box.collision_mask = 0
	bounce_box.body_entered.connect(_bounce)
	
	hurtbox.area_entered.connect(_on_hurtbox_area_entered)
	hat.body_entered.connect(_on_hat_body_entered)
	state_machine.state_changed.connect(_get_state_name)
	
	position.x = get_viewport_rect().size.x/2
	@warning_ignore("narrowing_conversion")
	screen_width = get_viewport_rect().size.x

@warning_ignore("unused_parameter")
func _physics_process(delta: float) -> void:
	move_and_slide()
	_get_dir()
	sprite.flip_h = !(facing_left)

func _on_hat_body_entered(body: Node2D) -> void:
	body.destroy()
	velocity.y = 0
	hat.collision_mask = 0

func _is_grounded() -> bool:
	if (down_left.is_colliding() || down.is_colliding() || down_right.is_colliding()):
		return true
		
	return false
	
func _bounce(body: Node2D):
	bounce_box.collision_mask = 0
	velocity.x *= -1
	facing_left = !(facing_left)
	flip.emit()

func _update_frame(frame: int):
	sprite.frame = frame

func _on_hurtbox_area_entered(area: Area2D) -> void:
		_go_die()

func _go_die():
	die.emit()
	print("I should be dead")

func _walk():
	if abs(velocity.x) < speed:
		_step()
		
	else:
		velocity.x = direction*speed

func _step():
	velocity.x += direction*speed/5
	#print(velocity)

func _jump():
		_set_facing()
		bounce_box.collision_mask = 18
		hat.collision_mask = 2
		velocity.y -= jump_height
	
func _wrap_around():
		@warning_ignore("integer_division")
		if abs(position.x - screen_width/2) > (screen_width)/2:
			position.x = int(position.x+screen_width) % (screen_width)

func _get_dir():
	direction = Input.get_axis("left","right")
	
	$bounce/CollisionShape2D.position = Vector2(8 * sign(velocity.x),12)

func _set_facing():
	
	if (direction + velocity.x) < 0:
		facing_left = true
	
	elif (direction + velocity.x) > 0:
		facing_left = false

func _get_state_name(state_name: String):
	current_state = state_name
