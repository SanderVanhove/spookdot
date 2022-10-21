tool
extends EditorPlugin


var SpiderScene: PackedScene = preload("res://addons/spookdot/Spider.tscn")
var PumpkinScene: PackedScene = preload("res://addons/spookdot/Pumpkin.tscn")
var WebScene: PackedScene = preload("res://addons/spookdot/Web.tscn")


var _prop_timer: SceneTreeTimer


var _props: Array = []


func _enter_tree():
	create_prop_timer()


func _exit_tree():
	randomize()

	for prop in _props:
		if is_instance_valid(prop):
			prop.queue_free()


func _input(event):
	create_prop_timer(120)


func create_prop_timer(min_time: float = 0):
	if _prop_timer:
		_prop_timer.disconnect("timeout", self, "spawn_prop")

	_prop_timer = get_tree().create_timer(rand_range(min_time + 120, min_time + 180))
	_prop_timer.connect("timeout", self, "spawn_prop")


func spawn_prop():
	var prop: Node2D
	var rand_num: float = randf()

	if rand_num < .5:
		prop = SpiderScene.instance()
	elif rand_num < .8:
		prop = PumpkinScene.instance()
	else:
		prop = WebScene.instance()

	_props.append(prop)

	get_tree().root.add_child(prop)

	create_prop_timer()
