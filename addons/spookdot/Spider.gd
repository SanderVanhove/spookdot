extends Node2D

onready var _tween: Tween = $Tween
onready var _animation_player: AnimationPlayer = $AnimationPlayer


func _ready():
	set_as_toplevel(true)
	var rand_pos: Vector2 = Vector2(
		rand_range(0, 1920),
		rand_range(0, 1080)
	)
	
	move_to(rand_pos)
	
	
func move_to(pos: Vector2):
#	create_tween().tween_property(self, "position", pos, 3)
	_tween.remove_all()
	_tween.interpolate_property(self, "position", position, pos, 3)
	_tween.interpolate_callback(_animation_player, 3, "stop")
	_tween.start()
	
	_animation_player.play("Walk")
	
	scale.x *= -sign(position.direction_to(pos).x)


func _on_MouseArea_mouse_entered():
	move_to(-position.direction_to(get_global_mouse_position()) * 2000)
	
	yield(_tween, "tween_all_completed")
	
	queue_free()
