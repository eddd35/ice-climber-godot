extends CharacterBody2D

@export var hurtbox: Area2D

var speed: int = 75

func _ready() -> void:
	hurtbox.area_entered.connect(get_hit)
	
	if position.x > get_viewport_rect().size.x/2:
		velocity.x = -speed
			
	else:
		scale.x *= -1
		velocity.x = speed
	
func _physics_process(delta: float) -> void:
	move_and_slide()

func destroy():
	queue_free()

func get_hit(area: Area2D):
	destroy()
