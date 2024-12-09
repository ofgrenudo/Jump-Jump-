extends StaticBody3D

func _ready() -> void:
	# Access hidden_platforms nodes via the parent
	if get_parent().has_node("hidden_platforms_1"):
		var hidden_platforms_one = get_parent().get_node("hidden_platforms_1")
		var hidden_platforms_one_collision_shape = hidden_platforms_one.get_node("CollisionShape3D")
		hidden_platforms_one_collision_shape.set_deferred("disabled", true)
		hidden_platforms_one.set_deferred("visible", false)
	else:
		print("Error: hidden_platforms_1 not found!")
		
	if get_parent().has_node("hidden_platforms_2"):
		var hidden_platforms_two = get_parent().get_node("hidden_platforms_2")
		hidden_platforms_two.set_deferred("visible", false)
	else:
		print("Error: hidden_platforms_2 not found!")

	if get_parent().has_node("hidden_platforms_3"):
		var hidden_platforms_three = get_parent().get_node("hidden_platforms_3")
		hidden_platforms_three.set_deferred("visible", false)
	else:
		print("Error: hidden_platforms_3 not found!")

func _on_area_3d_area_shape_entered(area_rid: RID, area: Area3D, area_shape_index: int, local_shape_index: int) -> void:
	# Access hidden_platforms nodes via the parent
	if get_parent().has_node("hidden_platforms_1"):
		var hidden_platforms_one = get_parent().get_node("hidden_platforms_1")
		hidden_platforms_one.visible = true
		var hidden_platforms_one_collision_shape = hidden_platforms_one.get_node("CollisionShape3D")
		hidden_platforms_one_collision_shape.set_deferred("disabled", false)
	else:
		print("Error: hidden_platforms_1 not found!")

	if get_parent().has_node("hidden_platforms_2"):
		var hidden_platforms_two = get_parent().get_node("hidden_platforms_2")
		hidden_platforms_two.set_deferred("visible", true)
	else:
		print("Error: hidden_platforms_2 not found!")

	if get_parent().has_node("hidden_platforms_3"):
		var hidden_platforms_three = get_parent().get_node("hidden_platforms_3")
		hidden_platforms_three.set_deferred("visible", true)
	else:
		print("Error: hidden_platforms_3 not found!")
