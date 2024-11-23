extends LineEdit

var field

func _ready():
	field = get_node('/root/CharacterSelectScn/testControl/GravityMaxField')
	field.set_text(str(TestCharacterStats.gravity_max))

func _on_text_submitted(new_text):
	field.set_text(new_text)
	TestCharacterStats.gravity_max = int(new_text)
