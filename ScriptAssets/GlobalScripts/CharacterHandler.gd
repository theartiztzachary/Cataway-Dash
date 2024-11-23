extends Node

## Controls Information
# Jump
var jump_key = 'W'
signal jump_key_changed

# Brake
var brake_key = 'A'
signal brake_key_changed

# Slide
var slide_key = 'S'
signal slide_key_changed

# Ability
var ability_key = 'D'
signal ability_key_changed

## Character Information
enum Character {NOCHARACTER, SELENA, ISAAC, DJ, KORRIA, ADIEN, LYVOK}
var currentCharacter = Character.NOCHARACTER
signal currentCharacterSwitched

# No Character Info
const noCharacterAbilityDescription = "Select a character."

# Selena Info
const selenaName = 'Ferrarix Selena Colard'
const selenaAbilityName = 'Bladesurge'
var selenaAbilityDescription = "Pressing " + ability_key + " has Selena dashes forward a short \n" \
		+ "distance, sacrificing momentum to destroy an obstacle."
		
# Isaac Info
const isaacName = 'Isaac Abryth'
const isaacAbilityName = 'Burn Out'
const isaacAbilityDescription = "The first time in a run that Isaac would collide with an obstacle, \n" \
		+ "he unleashes a large blast of fire to destroy the obstacle and \n" \
		+ "continue running."
		
# DJ Info
const djName = 'DJ'
const djAbilityName = 'Star Dash'
const djAbilityDescription = "If DJ is running at maximum speed, when he picks up a Star Coin, \n" \
		+ "his maximum speed is increased slightly. This effect stacks \n" \
		+ "indefinately, but if DJ brakes, his maximum speed is reduced \n" \
		+ "by the same amount. DJ cannot go below his base maximum \n" \
		+ "speed this way."
		
# Korria Info
const korriaName = 'Tatzou Korria'
const korriaAbilityName = 'Calculated Decision'
var korriaAbilityDescription = "Holding " + ability_key + " slows the world around Korra, \n" \
		+ "allowing her to more precisely decide where to go. \n" \
		+ "This does not slow down time."
		
# Adien Info
const adienName = 'Adien Forlet'
const adienAbilityName = 'Wind Step'
const adienAbilityDescription = "While in the air, Adien can preform a jump."

# Lyvok Info
const lyvokName = 'Lyvok'
const lyvokAbilityName = 'Reality Warp'
var lyvokAbilityDescription = "Pressing " + ability_key + " allows Lyvok to blink forward a set \n" \
		+ "distance. If Lyvok blinks into an obstacle or platform, \n" \
		+ "the run will end."

## Play State Information
# Start = beginning animation
# Play = actively playing
# Over = game over animation
# End = score calculation, able to return to character select/main menu/quit
enum CurrentPlayState {START, PLAY, OVER, END, NULL}
var current_play_state = CurrentPlayState.NULL
var on_ground
var is_sliding
var is_braking
var is_falling
var is_stopped
var in_ability
var is_jumping

signal safe
signal unsafe
signal star_coin
