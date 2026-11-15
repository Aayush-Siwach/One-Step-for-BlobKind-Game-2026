extends CharacterBody2D

var time_count = 0
const SPEED = 175.0
const JUMP_VELOCITY = -400.0
const WALL_JUMP_PUSHBACK = 50.0
const WALL_SLIDE_SPEED = 10.0
const WALL_JUMP_LOCK_TIME = 0.15
var reloaded: bool = false

# --- SLIME BOUNCE ADDITION ---
const SLIME_MIN_VELOCITY = 500.0
const SLIME_BOUNCE_RATIO = 0.8
var fall_speed_before_impact = 0.0
# -----------------------------

var wall_jump_timer = 0.0
var was_up_pressed = false

@onready var sprite = $Sprite2D

func _physics_process(delta: float) -> void:
	if wall_jump_timer > 0:
		wall_jump_timer -= delta

	# Detect a fresh press of the Up Arrow key
	var up_pressed = Input.is_physical_key_pressed(KEY_UP)
	var jump_just_pressed = up_pressed and not was_up_pressed
	was_up_pressed = up_pressed

	# 1. Add gravity and handle wall sliding
	if not is_on_floor():
		velocity += get_gravity() * delta
		if is_on_wall() and velocity.y > WALL_SLIDE_SPEED:
			velocity.y = WALL_SLIDE_SPEED

	# 2. Handle Floor Jump and Wall Jump
	if jump_just_pressed:
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
		elif is_on_wall():
			var wall_normal = get_wall_normal()
			velocity.x = wall_normal.x * WALL_JUMP_PUSHBACK
			velocity.y = JUMP_VELOCITY
			sprite.flip_h = wall_normal.x < 0
			wall_jump_timer = WALL_JUMP_LOCK_TIME

	# 3. Get Left / Right Arrow horizontal input (only if not locked in a wall jump)
	if wall_jump_timer <= 0:
		var direction := 0.0
		if Input.is_physical_key_pressed(KEY_LEFT):
			direction -= 1.0
		if Input.is_physical_key_pressed(KEY_RIGHT):
			direction += 1.0

		if direction != 0.0:
			velocity.x = move_toward(velocity.x, direction * SPEED, 40.0)
			sprite.flip_h = direction < 0
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

	# --- SLIME BOUNCE ADDITION ---
	if not is_on_floor():
		fall_speed_before_impact = velocity.y
	# -----------------------------

	move_and_slide()

	# --- SLIME BOUNCE ADDITION ---
	if is_on_floor() and fall_speed_before_impact >= SLIME_MIN_VELOCITY:
		velocity.y = -fall_speed_before_impact * SLIME_BOUNCE_RATIO
		fall_speed_before_impact = 0.0
	elif is_on_floor():
		fall_speed_before_impact = 0.0
	# -----------------------------
		move_and_slide()
	
