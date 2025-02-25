extends Half_Brick
class_name Full_Brick

@export var regenbox: Area2D
@export var adjacent: RayCast2D

var active_box: StaticBody2D

func _ready() -> void:
	regenbox.body_entered.connect(freezie_entered)

func _physics_process(delta: float) -> void:
	if adjacent.is_colliding():
		print(adjacent.get_collider())
		(adjacent.get_collider()).regrow()
		adjacent.target_position.x = 0

func destroy():
	sprite.modulate.a = 0
	bounding_box.collision_layer = 128
	regenbox.collision_layer = 64
	regenbox.set_deferred("monitoring", true)

func regrow():
	if adjacent.is_colliding():
		print(adjacent.get_collider())
		(adjacent.get_collider()).regrow()
	sprite.modulate.a = 1
	collision_layer = 2
	regenbox.collision_layer = 0
	regenbox.set_deferred("monitoring", false)

func freezie_entered(freezie: Node2D) -> void:
	adjacent.target_position.x = sign(global_position.x - freezie.global_position.x)*13
	
	freezie.destroy()
	regrow()
