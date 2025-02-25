extends State
class_name TopiWander

@export var parent: Topi

func _enter():
	parent.hurtbox.area_entered.connect(_hurtbox_entered)
	parent.sprite.speed_scale = 1
	parent.sprite.animation = "walk"
	
	if previous_state == "TopiRetreat":
		parent._turn()
		parent._spawn_freezie()
		
	parent.velocity.x = parent.speed
	
func _exit():
	parent.hurtbox.area_entered.disconnect(_hurtbox_entered)

func _update(delta: float):
	pass

func _physics_update(delta: float):
	if !(parent.down.is_colliding()):
		transitioned.emit(self,"TopiRetreat")
		
	@warning_ignore("integer_division")
	if abs(parent.position.x - parent.screen_width/2) > (parent.screen_width)/2:
		parent.position.x = int(parent.position.x+parent.screen_width) % (parent.screen_width)

func _hurtbox_entered(area: Area2D):
	match(area.collision_layer):
		8:
			transitioned.emit(self,"TopiHit")
		
		128:
			parent._turn()
