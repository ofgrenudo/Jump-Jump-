extends CharacterBody3D

var mouse_sensitivity := 0.002
var move_speed := 10.0
var sprint_multiplier := 1.5  # Multiplier for sprinting speed
var jump_velocity := 6.5
var gravity := -9.8  # Adjust gravity strength if needed
var max_jumps := 2  # Maximum jumps (1 for single jump, 2 for double jump)

var current_jumps := 0  # Tracks how many jumps the player has performed
const DEATH_HEIGHT = -45.0  # Height below which the player dies

var twist_input := 0.0
var pitch_input := 0.0

@onready var twist_pivot := $TwistPivot
@onready var pitch_pivot := $TwistPivot/PitchPivot
@onready var camera := $TwistPivot/PitchPivot/Camera3D
@onready var DeathScreen := $DeathScreen

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta: float) -> void:
	# Handle movement input
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var local_direction = Vector3(input_dir.x, 0, input_dir.y)

	# Adjust speed if sprint key (Shift) is pressed
	var current_speed = move_speed
	if Input.is_action_pressed("move_sprint"):
		current_speed *= sprint_multiplier

	# Transform local direction to align with camera orientation
	if local_direction != Vector3.ZERO:
		var rotated_direction = (twist_pivot.basis * local_direction).normalized()
		velocity.x = rotated_direction.x * current_speed
		velocity.z = rotated_direction.z * current_speed
	else:
		# Dampen velocity when no input is provided
		velocity.x = move_toward(velocity.x, 0, move_speed * delta)
		velocity.z = move_toward(velocity.z, 0, move_speed * delta)

	# Apply gravity
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		# Reset jumps when the player is on the ground
		current_jumps = 0

	# Handle jumping
	if Input.is_action_just_pressed("move_jump") and current_jumps < max_jumps:
		velocity.y = jump_velocity
		current_jumps += 1

	# Move the character
	move_and_slide()

	# Handle camera and player rotation
	twist_pivot.rotate_y(twist_input)
	pitch_pivot.rotate_x(pitch_input)
	pitch_pivot.rotation.x = clamp(
		pitch_pivot.rotation.x,
		deg_to_rad(-30),  # Minimum pitch angle
		deg_to_rad(30)    # Maximum pitch angle
	)

	# Reset inputs after applying rotation
	twist_input = 0.0
	pitch_input = 0.0

	# Check if player has fallen below the death height
	if global_transform.origin.y < (DEATH_HEIGHT/3):
		_on_player_near_death()
	if global_transform.origin.y < DEATH_HEIGHT:
		_on_player_death()
		
	# Escape mouse capture
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			twist_input = -event.relative.x * mouse_sensitivity
			pitch_input = -event.relative.y * mouse_sensitivity

func _on_player_near_death() -> void:
	DeathScreen.visible = true

func _on_player_death() -> void:
	# Handle player death (e.g., reset position, reload scene)
	print("Player has died!")

	DeathScreen.visible = false
		
	# Reset the player to a starting position
	global_transform.origin = Vector3(0, 5, 0)  # Replace with your spawn point
	
	# Optionally reset velocity
	velocity = Vector3.ZERO
