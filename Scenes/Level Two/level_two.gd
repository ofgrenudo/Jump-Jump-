extends Node3D

@onready var PlatformGoal := $PlatformGoal
@onready var PlayerNextLevelDisplay := $player/NextLevelTimer
@onready var PlayerTimer := $player/Timer

@onready var up_and_down_trigger := $PlatformTrigger
@onready var up_and_down_platform := $platform_up_and_down
@onready var left_and_right_trigger := $platform_up_and_down/PlatformTrigger
@onready var left_and_right_platform := $platform_left_and_right


var LevelComplete := false
var up_and_down_trigger_status := false
var left_and_right_trigger_status := false
var MOVEMENT_SPEED := 10
var ACHIEVEMENT_TIME := 15

var moving_up = true
var moving_left = true



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	LevelComplete = PlatformGoal.UserEnteredPlatformGoal
	up_and_down_trigger_status = up_and_down_trigger.get_status()
	left_and_right_trigger_status = left_and_right_trigger.get_status()
	
	print("Left and Right Trigger Status -> " + str(left_and_right_trigger_status))
	
	if (LevelComplete == true):
		PlayerTimer.stop_timer()
		PlayerNextLevelDisplay.visible = true
		PlayerNextLevelDisplay.StartCountdown()
		if (PlayerNextLevelDisplay.GetTimeLeft() == 0.0):
			get_tree().change_scene_to_file("res://Scenes/Level Two/level_two.tscn")
			pass
	if left_and_right_trigger_status:
		# Get the current Y position
		var current_x_position = left_and_right_platform.position.x
		
		# Update the position based on direction
		var delta_position = (MOVEMENT_SPEED/2) * delta * (1 if moving_up else -1)
		left_and_right_platform.position.x += delta_position
		
		# Check if the platform has reached the limits and switch direction
		if (moving_up and left_and_right_platform.position.x >= 25) or (not moving_up and left_and_right_platform.position.x <= -25):
			moving_up = not moving_up  # Toggle direction

	if up_and_down_trigger_status:
		# Get the current Y position
		var current_y_position = up_and_down_platform.position.y
		
		# Update the position based on direction
		var delta_position = MOVEMENT_SPEED * delta * (1 if moving_up else -1)
		up_and_down_platform.position.y += delta_position
		
		# Check if the platform has reached the limits and switch direction
		if (moving_up and up_and_down_platform.position.y >= 25) or (not moving_up and up_and_down_platform.position.y <= -65):
			moving_up = not moving_up  # Toggle direction		
	
	
