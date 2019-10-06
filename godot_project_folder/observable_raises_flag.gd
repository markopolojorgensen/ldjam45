extends Node

export(NodePath) var observable_path
export(NodePath) var flag_path

onready var observable = get_node(observable_path)
onready var flag = get_node(flag_path)

func _ready():
	observable.connect("looked_at", self, "looked_at")
	observable.connect("looked_away_from", self, "looked_away_from")

func looked_at():
	flag.raise()

func looked_away_from():
	pass

