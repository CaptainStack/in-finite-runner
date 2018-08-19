extends RigidBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var anim = ""
var siding_left = false
var jumping = false
var stopping_jump = false
var is_sliding
var sliding_time = 0

var WALK_MAX_VELOCITY = 200.0
var WALK_ACCEL = 800.0
var AIR_ACCEL = 200.0
var JUMP_VELOCITY = 460
var STOP_JUMP_FORCE = 900.0

var MAX_FLOOR_AIRBORNE_TIME = 0.15

var airborne_time = 1e20

var floor_h_velocity = 0.0

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _integrate_forces(s):
	var lv = s.get_linear_velocity()
	var step = s.get_step()
	
	var new_anim = anim
	var new_siding_left = siding_left
	
	var move_right = Input.is_action_pressed("ui_right")
	var move_left = Input.is_action_pressed("ui_left")
	var jump = Input.is_action_just_pressed("ui_up")
	var down = Input.is_action_just_pressed("ui_down")
	
	lv.x -= floor_h_velocity
	floor_h_velocity = 0.0
	
	var found_floor = false
	var floor_index = -1
	
	for x in range(s.get_contact_count()):
		var ci = s.get_contact_local_normal(x)
		if ci.dot(Vector2(0, -1)) > 0.6:
			found_floor = true
			floor_index = x
	
	if found_floor:
		airborne_time = 0.0
	else:
		airborne_time += step # Time it spent in the air
	
	var on_floor = airborne_time < MAX_FLOOR_AIRBORNE_TIME
	
	var is_going_left = lv.x < 0

		
	if on_floor:
		if is_sliding:
			sliding_time += step
		if sliding_time > 0.5:
			is_sliding = false
			if is_going_left:
				 lv.x = -100
			else:
				lv.x = 100
			sliding_time = 0
		if jump:
			lv.y = -200
		if move_right:
			lv.x = 100
			new_siding_left = false
		elif move_left:
			lv.x = -100
			new_siding_left = false
		elif down:
			is_sliding = true
			if is_going_left:
				lv.x = -300
			else:
				lv.x = 300
			
		if !is_sliding:
			$AnimatedSprite.animation = "right"
		else:
			$AnimatedSprite.animation = "slide"
		
	else:
		if lv.y < 1:
			$AnimatedSprite.animation = "jump"
		elif lv.y > -1:
			$AnimatedSprite.animation = "fall"


	$AnimatedSprite.flip_h = is_going_left
	
	
	
	$AnimatedSprite.play()
	lv += s.get_total_gravity() * step
	s.set_linear_velocity(lv)