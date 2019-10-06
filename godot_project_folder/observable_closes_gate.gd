extends Node

export(NodePath) var observable_path
export(NodePath) var gate_path

onready var observable = get_node(observable_path)
onready var gate = get_node(gate_path)

func _ready():
	observable.connect("looked_at", self, "looked_at")
	observable.connect("looked_away_from", self, "looked_away_from")
	
	gate.open()

func looked_at():
	gate.close()

func looked_away_from():
	gate.open()

