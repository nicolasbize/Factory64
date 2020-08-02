extends Node2D

onready var animationPlayer = $AnimationPlayer

func reverse():
	print("not defined by parent")
	pass

func is_conveyor():
	return false

func can_accept(obj, new_pos):
	print("can't accept object, need to be defined")
	return false
