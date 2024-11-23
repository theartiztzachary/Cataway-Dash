extends LineEdit

var field

func _ready():
	field = get_node('/root/CharacterSelectScn/testControl/JumpField')
	
	match CharacterHandler.currentCharacter:
		CharacterHandler.Character.SELENA:
			field.set_text(str(TestCharacterStats.selena_jump_power))
		CharacterHandler.Character.ISAAC:
			field.set_text(str(TestCharacterStats.isaac_jump_power))
		CharacterHandler.Character.DJ:
			field.set_text(str(TestCharacterStats.dj_jump_power))
		CharacterHandler.Character.KORRIA:
			field.set_text(str(TestCharacterStats.korria_jump_power))
		CharacterHandler.Character.ADIEN:
			field.set_text(str(TestCharacterStats.adien_jump_power))
		CharacterHandler.Character.LYVOK:
			field.set_text(str(TestCharacterStats.lyvok_jump_power))

func _on_text_submitted(new_text):
	match CharacterHandler.currentCharacter:
		CharacterHandler.Character.SELENA:
			TestCharacterStats.selena_jump_power = int(new_text)
			field.set_text(new_text)
		CharacterHandler.Character.ISAAC:
			TestCharacterStats.isaac_jump_power = int(new_text)
			field.set_text(new_text)
		CharacterHandler.Character.DJ:
			TestCharacterStats.dj_jump_power = int(new_text)
			field.set_text(new_text)
		CharacterHandler.Character.KORRIA:
			TestCharacterStats.korria_jump_power = int(new_text)
			field.set_text(new_text)
		CharacterHandler.Character.ADIEN:
			TestCharacterStats.adien_jump_power = int(new_text)
			field.set_text(new_text)
		CharacterHandler.Character.LYVOK:
			TestCharacterStats.lyvok_jump_power = int(new_text)
			field.set_text(new_text)
