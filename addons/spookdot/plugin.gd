tool
extends EditorPlugin


var SpiderScene: PackedScene = preload("res://addons/spookdot/Spider.tscn")


var _spider_timer: SceneTreeTimer


func _enter_tree():
	create_spider_timer()
	
	
func create_spider_timer():
	_spider_timer = get_tree().create_timer(2)
	_spider_timer.connect("timeout", self, "spawn_spider")


func spawn_spider():
	var spider = SpiderScene.instance()
	get_parent().get_parent().add_child(spider)
