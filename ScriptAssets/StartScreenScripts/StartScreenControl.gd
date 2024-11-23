extends Control

var rng_gen = RandomNumberGenerator.new()
var character_portrait: Sprite2D

func _ready() -> void:
	var rng_call = randi_range(1, 6)
	# 1 = Selena, 2 = Isaac, 3 = DJ, 4 = Korria, 5 = Adien, 6 = Lyvok
	
	character_portrait = get_node('/root/StartScreenScn/Control/tempPortraits')
	
	match rng_call:
		1:
			character_portrait.texture = load('res://TestAssets/testVisuals/testStartScreenVisuals/test_SelenaPortrait.png')
		2:
			character_portrait.texture = load('res://TestAssets/testVisuals/testStartScreenVisuals/test_IsaacPortrait.png')
		3:
			character_portrait.texture = load('res://TestAssets/testVisuals/testStartScreenVisuals/test_DJPortrait.png')
		4:
			character_portrait.texture = load('res://TestAssets/testVisuals/testStartScreenVisuals/test_KorriaPortrait.png')
		5:
			character_portrait.texture = load('res://TestAssets/testVisuals/testStartScreenVisuals/test_AdienPortrait.png')
		6:
			character_portrait.texture = load('res://TestAssets/testVisuals/testStartScreenVisuals/test_LyvokPortrait.png')
