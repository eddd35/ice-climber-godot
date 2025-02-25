extends Node2D
class_name Level

@export var hammer_scene: PackedScene = preload("res://items/hammer.tscn")
@export var freezie_scene: PackedScene = preload("res://enemies/freezie/freezie.tscn")
@export var player: Player

@export var camera: Icies_Camera

func _ready() -> void:
	player.swing.connect(_use_hammer)	#connect player actions to hammer usage
	player.falling.connect(_use_hammer)
	player.jumping.connect(_use_hammer)
	
	get_tree().call_group("Topis", "connect_signal", self)
	
func _use_hammer(facing_left: bool, state: int):
	var hammer: Node = hammer_scene.instantiate()	#make a hammer instance
	
	player.flip.connect(hammer._flip)	#connect the current hammer instance to relevant player stuff
	player.landed.connect(hammer._delete)
	
	hammer.player = player	#sets the hammer's owner
	hammer.state = state	#sets what position the hammer will be
	hammer.frame_changed.connect(player._update_frame)	#matches the hammer's animation progress with the player's
	
	hammer.position = player.position	#you won't believe what this does... what does it do?
	hammer.deleted.connect(player._stop_swing)	#makes it so the hammer gets deleted when the player's done swinging
	hammer.facing_left = facing_left	#makes the hammer face the right way
	add_child(hammer)	#adds a hammer

func _add_freezie(pos: Vector2, speed: int):
	var freezie: Node = freezie_scene.instantiate()	#instantiates a freezie
	freezie.position = pos	#guess
	freezie.speed = speed	#guess
	
	#add_child(freezie)
	call_deferred("add_child", freezie)	#adds a freezie, wow
