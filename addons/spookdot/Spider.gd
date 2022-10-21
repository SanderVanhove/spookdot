tool
extends Node2D

onready var _tween: Tween = $Tween
onready var _animation_player: AnimationPlayer = $AnimationPlayer


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

	var rand_pos: Vector2 = Vector2(
		rand_range(0, get_viewport().size.x),
		rand_range(0, get_viewport().size.y)
	)

	move_to(rand_pos)


func move_to(pos: Vector2):
	_tween.remove_all()
	_tween.interpolate_property(self, "position", position, pos, 3)
	_tween.interpolate_callback(_animation_player, 3, "stop")
	_tween.start()

	_animation_player.play("Walk")

	scale.x = sign(position.direction_to(pos).x)


func _on_Control_mouse_entered():
	move_to(-position.direction_to(get_global_mouse_position()) * get_viewport().size.x + position)

	yield(_tween, "tween_all_completed")

	queue_free()
