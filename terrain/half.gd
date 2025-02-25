extends Block
class_name Half_Brick

func destroy():
	sprite.modulate.a = 0
	bounding_box.collision_layer = 128
