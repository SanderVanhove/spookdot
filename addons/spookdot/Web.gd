tool
extends Node2D

onready var _animation_player: AnimationPlayer = $AnimationPlayer
onready var _sprite: Sprite = $Sprite


func _ready():
	position = Vector2.ZERO
	var rand_num: float = randf()
	if rand_num < .25:
		position = get_viewport().size
	elif rand_num < .5:
		position = Vector2(
			get_viewport().size.x,
			0
		)
	elif rand_num < .75:
		position = Vector2(
			0,
			get_viewport().size.y
		)
		
	var rand_scale: float = rand_range(.6, 1.4)
	scale = Vector2(rand_scale, rand_scale)
	
	_animation_player.play("Appear")


func _on_Control_mouse_entered():
	_animation_player.play("Appear", -1, -1, true)
	
	yield(_animation_player, "animation_finished")
	
	queue_free()
