extends LineEdit

var field

func _ready():
	field = get_node('/root/CharacterSelectScn/testControl/JumpFrameField')
	field.set_text(str(TestCharacterStats.jump_power_hold_max))

func _on_text_submitted(new_text):
	field.set_text(new_text)
	
	TestCharacterStats.jump_power_hold_max = new_text
