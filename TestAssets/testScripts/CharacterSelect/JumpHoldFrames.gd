extends LineEdit

var field

func _ready():
	field = get_node('/root/CharacterSelectScn/testControl/JumpFrameField')
	field.set_text(str(TestCharacterStats.test_jump_multiplier_time))

func _on_text_submitted(new_text):
	field.set_text(new_text)
	
	TestCharacterStats.test_jump_multiplier_time = int(new_text)
