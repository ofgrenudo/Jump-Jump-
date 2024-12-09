extends Node3D

@onready var PlatformGoal := $PlatformGoal
@onready var PlayerNextLevelDisplay := $player/NextLevelTimer


var LevelComplete := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	LevelComplete = PlatformGoal.UserEnteredPlatformGoal
	if (LevelComplete == true):
		#print("Level Complete") 
		PlayerNextLevelDisplay.visible = true
		PlayerNextLevelDisplay.StartCountdown()
		#print(PlayerNextLevelDisplay.GetTimeLeft())
		#if (PlayerNextLevelDisplay.GetTimeLeft() == 0.0):
			#get_tree().change_scene_to_file("res://Scenes/Level One/level_one.tscn")
			#pass
