extends Button

## TEMP
var acceleration_field
var max_speed_field
var jump_field
var brake_field

func _ready():
	## TEMP
	acceleration_field = get_node('/root/CharacterSelectScn/testControl/AccelField')
	max_speed_field = get_node('/root/CharacterSelectScn/testControl/MaxSpeedField')
	jump_field = get_node('/root/CharacterSelectScn/testControl/JumpField')
	brake_field = get_node('/root/CharacterSelectScn/testControl/BrakeField')

func _on_pressed():
	CharacterHandler.currentCharacter = CharacterHandler.Character.KORRIA
	CharacterHandler.currentCharacterSwitched.emit()
	
	## TEMP
	acceleration_field.set_text(str(TestCharacterStats.korria_acceleration))
	max_speed_field.set_text(str(TestCharacterStats.korria_max_speed))
	jump_field.set_text(str(TestCharacterStats.korria_jump_power))
	brake_field.set_text(str(TestCharacterStats.korria_brake_power))
