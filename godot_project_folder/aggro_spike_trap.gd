extends Node2D

func _ready():
	$Aggro.connect("aggro", self, "aggro")

func aggro(target):
	$spike_trap_vertical.stab()

