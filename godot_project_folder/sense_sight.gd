extends CanvasLayer

signal sight_acquired

export(int) var visual_cue_count = 3

var visual_cue_scene = preload("res://visual_cue.tscn")

func _ready():
	$eyelid.show()
	$animation_player.play_backwards("fade_out")
	enable_visual_cues()

func fade_out():
	$animation_player.play("fade_out")

func enable_visual_cues():
	for i in range(visual_cue_count):
		var inst = visual_cue_scene.instance()
		inst.connect("looked_at", self, "visual_cue_looked_at")
		$visual_cues.add_child(inst)

func visual_cue_looked_at():
	visual_cue_count -= 1
	if visual_cue_count <= 0:
		fade_out()
		emit_signal("sight_acquired")

