extends StaticBody3D

@onready var UserEnteredCollectable = false
@onready var ParentNode = get_parent()
var ROTATION_SPEED := 5.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Check if ParentNode is a Node3D (or a compatible type)
	if not ParentNode or not ParentNode is Node3D:
		print("ParentNode is not a Node3D. Cannot access rotation.")
		ParentNode = null
	
func _process(delta: float) -> void:
	var coin = get_parent().get_node("Collectable")
	
	# Get the current Y rotation
	var current_y_rotation = coin.rotation.y
		
	# Calculate the future rotation
	var future_y_rotation = current_y_rotation + ROTATION_SPEED * delta
		
	# Apply the rotation to the parent
	coin.rotation.y = future_y_rotation

	# Wrap around to keep rotation within 0-360 degrees
	if coin.rotation.y >= deg_to_rad(360.0):
		coin.rotation.y -= deg_to_rad(360.0)
	

# A signal is atttached to the Area3d Node of the PlatformGoal Sceene.
# When a 3d body touches the Area3d Predefined mask, this function is ran.
# The Sceene, using the Platform Goal, should be checking the variable in 
# this script In the Proccess function. Once the variable is changed. You 
# can then preform your next steps.
func _on_area_3d_area_shape_entered(_area_rid: RID, _area: Area3D, _area_shape_index: int, _local_shape_index: int) -> void:
	UserEnteredCollectable = true
	pass


func _on_area_3d_body_entered(_body: Node3D) -> void:
	UserEnteredCollectable = true
	pass # Replace with function body.
