extends RigidBody2D

signal took_damage(amount)

var conveyor_belts = 0

const top_speed = 300
const conveyor_top_speed = 100
const acceleration = 5000

var treads_enabled = false

func _ready():
	set_process(false)
	$kaboom.hide()

func _physics_process(delta):
	var player_wants_to_move = $user_input_direction.get_intended_direction().length() > 0.1
	var on_conveyor_belts = conveyor_belts > 0
	
	var horizontal_direction = $user_input_direction.get_intended_direction().x
	if horizontal_direction > 0:
		horizontal_direction = 1
	else:
		horizontal_direction = -1
	
	if not player_wants_to_move and not on_conveyor_belts:
		# natural horizontal slowdown
		apply_central_impulse(Vector2(linear_velocity.x * delta * -10, 0)) 
	
	if treads_enabled and player_wants_to_move:
		apply_central_impulse(Vector2(acceleration * delta * horizontal_direction, 0)) 
	
	if on_conveyor_belts:
		apply_central_impulse(Vector2(400, 0) * delta)
	
	if on_conveyor_belts and not treads_enabled:
		# conveyor top speed
		if linear_velocity.length() >= conveyor_top_speed:
			var magnitude = linear_velocity.length() - conveyor_top_speed
			var impulse = linear_velocity.normalized() * -1 * magnitude
			apply_central_impulse(impulse)
	else: # not on conveyor belt or have treads
		# regular top speed
		if linear_velocity.length() >= top_speed:
			var magnitude = linear_velocity.length() - top_speed
			var impulse = linear_velocity.normalized() * -1.1 * magnitude
			apply_central_impulse(impulse)
	
	$debug.text = str(conveyor_belts)

func _process(delta):
	var direction = (get_global_mouse_position() - global_position + Vector2(0, 40))
	var angle = rad2deg(direction.angle())
	angle += 90
	if angle > 180:
		angle = - (180 - (angle - 180))
	
	if angle < 0:
		$head_sprite.flip_h = true
	else:
		$head_sprite.flip_h = false
	
	angle = abs(angle)
	
	if angle < 20:
		$head_sprite.play("up")
	elif angle < 50:
		$head_sprite.play("up_angle")
	elif angle < 120:
		$head_sprite.play("horizontal")
	elif angle < 180:
		$head_sprite.play("down_angle")
	else:
		print("mystery head direction: %s" % str(angle))
	
	# tread sprite
	if treads_enabled and abs(linear_velocity.x) > 10:
		$animated_sprite.play("moving")
		if linear_velocity.x > 0:
			$animated_sprite.flip_h = false
		else:
			$animated_sprite.flip_h = true
	elif treads_enabled and abs(linear_velocity.x) <= 10:
		$animated_sprite.stop()

func up_moving_belts():
	conveyor_belts += 1

func down_moving_belts():
	conveyor_belts -= 1

func hit_by_spike(spike):
	var direction = global_position - spike.global_position
	apply_central_impulse(direction.normalized() * 1000)
	emit_signal("took_damage", 1)

func sprout_camera():
	$head_sprite.play("sprout_camera")
	yield(get_tree().create_timer(0.5), "timeout")
	set_process(true)

func triggers_aggro():
	return true

func die():
	$kaboom.show()
	$kaboom.play()
	$head_sprite.hide()
	$animated_sprite.hide()
	
	set_process(false)
	set_physics_process(false)
	set_physics_process_internal(false)
	
	call_deferred("set_mode", RigidBody2D.MODE_KINEMATIC)

func find_treads():
	$animated_sprite.animation = "moving"
	treads_enabled = true

