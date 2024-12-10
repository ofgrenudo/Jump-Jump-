extends Node3D

@onready var PlatformGoal := $PlatformGoal
@onready var PlayerNextLevelDisplay := $player/NextLevelTimer
@onready var PlayerTimer := $player/Timer

var LevelComplete := false
var ACHIEVEMENT_TIME := 5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	LevelComplete = PlatformGoal.UserEnteredPlatformGoal
	if (LevelComplete == true):
		PlayerTimer.stop_timer()
		PlayerNextLevelDisplay.visible = true
		PlayerNextLevelDisplay.StartCountdown()
		if (PlayerNextLevelDisplay.GetTimeLeft() == 0.0):
			get_tree().change_scene_to_file("res://Scenes/Level One/level_one.tscn")
			pass
