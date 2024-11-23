extends Area2D

func _on_body_shape_entered(_body_rid, _body, _body_shape_index, local_shape_index):
	var collision_body = str(shape_owner_get_owner(shape_find_owner(local_shape_index))).get_slice("_",0)
	if collision_body == 'safe':
		CharacterHandler.safe.emit()
	elif collision_body == 'unsafe':
		CharacterHandler.unsafe.emit()


func _on_body_shape_exited(_body_rid, _body, _body_shape_index, _local_shape_index):
	CharacterHandler.on_ground = false
	CharacterHandler.is_falling = true
