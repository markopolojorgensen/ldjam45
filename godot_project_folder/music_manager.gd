extends Node

export(bool) var random = false

var layer = 0

func add_layer():
	# print("%s is adding music layer: %s -> %s" % [str(self), str(layer), str(layer + 1)])
	
	if (layer + 1) > get_child_count():
		print("TOO MANY MUSIC LAYERS")
		return
	
	var offset = $audio_stream_player_1.get_playback_position()
	get_children()[layer].play(offset)
	# print("  music layer offset: %s" % str(offset))
	
	layer += 1
	

func remove_layer():
	# print("%s is removing a music layer: %s -> %s" % [str(self), str(layer), str(layer - 1)])
	if layer > 0 and layer <= get_child_count():
		layer -= 1
		get_children()[layer].stop()
	else:
		print("what: %s" % str(layer))

func stop():
	while layer > 0:
		remove_layer()

func play(levels_beaten):
	for i in range(levels_beaten):
		# call_deferred("add_layer")
		add_layer()


func _process(delta):
	$canvas_layer/v_box_container/label_1.text = str($audio_stream_player_1.get_playback_position())
	$canvas_layer/v_box_container/label_2.text = str($audio_stream_player_2.get_playback_position())
	$canvas_layer/v_box_container/label_3.text = str($audio_stream_player_3.get_playback_position())
	$canvas_layer/v_box_container/label_4.text = str($audio_stream_player_4.get_playback_position())
	$canvas_layer/v_box_container/label_5.text = str($audio_stream_player_5.get_playback_position())








