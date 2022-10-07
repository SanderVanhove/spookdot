tool
extends Node2D

onready var _tween: Tween = $Tween
onready var _animation_player: AnimationPlayer = $AnimationPlayer
onready var _sprite: Sprite = $Sprite


func _ready():
	position = get_viewport().size
	var rand_num: float = randf()
	if rand_num < .5:
		position = Vector2(
			0,
			get_viewport().size.y
		)
		
	var rand_scale: float = rand_range(.6, 1.4)
	scale = Vector2(rand_scale, rand_scale)
	
	var rand_pos: Vector2 = Vector2(
		rand_range(0, get_viewport().size.x),
		get_viewport().size.y
	)
	
	move_to(rand_pos)
	yield(_tween, "tween_all_completed")
	_sprite.rotation = 0
	
	
func move_to(pos: Vector2):
	_tween.remove_all()
	_tween.interpolate_property(self, "position", position, pos, 3)
	_tween.interpolate_callback(_animation_player, 3, "stop")
	_tween.start()
	
	_animation_player.play("Roll")
	
	scale.x *= sign(position.direction_to(pos).x)


func _on_Control_mouse_entered():
	move_to(Vector2(sign(-position.direction_to(get_global_mouse_position()).x) * get_viewport().size.x, get_viewport().size.y))
	
	yield(_tween, "tween_all_completed")
	
	queue_free()
