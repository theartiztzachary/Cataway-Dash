extends LineEdit

var field

func _ready():
	field = get_node('/root/CharacterSelectScn/testControl/GravityAccelField')
	field.set_text(str(TestCharacterStats.gravity_acceleration))

func _on_text_submitted(new_text):
	field.set_text(new_text)
	TestCharacterStats.gravity_acceleration = int(new_text)
