extends StaticBody3D

@onready var UserEnteredPlatformTrigger = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# A signal is atttached to the Area3d Node of the PlatformGoal Sceene.
# When a 3d body touches the Area3d Predefined mask, this function is ran.
# The Sceene, using the Platform Goal, should be checking the variable in 
# this script In the Proccess function. Once the variable is changed. You 
# can then preform your next steps.
func _on_area_3d_area_shape_entered(_area_rid: RID, _area: Area3D, _area_shape_index: int, _local_shape_index: int) -> void:
	UserEnteredPlatformTrigger = true
	pass
