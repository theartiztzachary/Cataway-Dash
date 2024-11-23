extends Button

func _on_pressed():
	# doing this over only calling SceneTree.quit will allow for custom actions (ie saving, confirming quit, etc)
	# after pressing the button, SceneTree.quit would not allow for these
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	
func _notification(recieved_notification):
	if recieved_notification == NOTIFICATION_WM_CLOSE_REQUEST:
		get_tree().quit()
