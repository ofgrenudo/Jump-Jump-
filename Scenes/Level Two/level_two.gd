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
var ACHIEVEMENT_TIME := 20

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
	if (LevelComplete == true):
		PlayerTimer.stop_timer()
		PlayerNextLevelDisplay.visible = true
		PlayerNextLevelDisplay.StartCountdown()
		if (PlayerNextLevelDisplay.GetTimeLeft() == 0.0):
			get_tree().change_scene_to_file("res://Scenes/Level Two/level_two.tscn")
			pass
	
	if (up_and_down_trigger_status):
		if up_and_down_trigger_status:
			# Get the current Y position
			var current_y_position = up_and_down_platform.position.y

			# Check the direction and update the position accordingly
			if moving_up:
				# Move up
				var future_y_position = current_y_position + MOVEMENT_SPEED * delta
				up_and_down_platform.position.y = future_y_position

				# Check if the platform has reached the maximum height
				if up_and_down_platform.position.y >= 25:
					moving_up = false  # Switch direction to move down
			else:
				# Move down
				var future_y_position = current_y_position - MOVEMENT_SPEED * delta
				up_and_down_platform.position.y = future_y_position

				# Check if the platform has returned to the bottom
				if up_and_down_platform.position.y <= -65:
					moving_up = true  # Switch direction to move up again
			
	if (left_and_right_trigger_status):
		if left_and_right_trigger_status:
			# Get the current Y position
			var current_x_position = left_and_right_platform.position.x

			# Check the direction and update the position accordingly
			if moving_left:
				# Move up
				var future_x_position = current_x_position + MOVEMENT_SPEED * delta
				left_and_right_platform.position.x = future_x_position

				# Check if the platform has reached the maximum height
				if left_and_right_platform.position.x >= 35:
					moving_up = false  # Switch direction to move down
			else:
				# Move down
				var future_x_position = current_x_position - MOVEMENT_SPEED * delta
				left_and_right_platform.position.x = future_x_position

				# Check if the platform has returned to the bottom
				if left_and_right_platform.position.x <= -35:
					moving_up = true  # Switch direction to move up again
	
