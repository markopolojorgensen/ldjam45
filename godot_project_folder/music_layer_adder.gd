extends Area2D

export(NodePath) var music_manager_path
onready var music_manager = get_node(music_manager_path)

func _ready():
	connect("body_entered", self, "body_entered")

func body_entered(body):
	music_manager.add_layer()
	queue_free()


