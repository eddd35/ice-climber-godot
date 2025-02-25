extends Player
class_name PlayerH

signal swing
signal swing_done

func _use_hammer():
	position.y -= 24
	velocity.x = 0
	swing.emit(facing_left,1)

func _stop_swing():
	position.y += 24
	swing_done.emit()
