extends Area2D

# character, collision shape

func _on_body_shape_entered(_body_rid, _body, _body_shape_index, local_shape_index):
	var collision_shape_node = shape_owner_get_owner(shape_find_owner(local_shape_index))
	CharacterHandler.safe.emit(collision_shape_node.global_position.y)

func _on_body_shape_exited(_body_rid, _body, _body_shape_index, _local_shape_index):
	CharacterHandler.on_ground = false
	CharacterHandler.is_falling = true
	#CharacterHandler.snap_next_frame = false
