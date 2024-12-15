extends Control

### LOCAL VARIABLES (variables in CharacterHanlder are defined in _ready)

## Score
var score = 0
var game_time = 0
var game_distance = 0
var star_coins_collected = 0

## Movement Variables
var current_speed = 0
var acceleration
var max_speed
var brake_power

var jump_power
var gravity_acceleration
var gravity_applied = 0
var gravity_max
var jump_power_timer_multiplier = 0

var slide_brake 
var slide_boost 
var slide_extension_active = false
var slide_extension_time 
var slide_extension_timer = 0

var coyote_time_active = false
var coyote_time
var coyote_time_timer = 0

## 'Middle of the Screen' for camera fix
var absolute_y = 475
var midpoint
var above_midpoint = false
var passing_midpoint = false
var pass_midpoint_delta = 0
var pass_midpoint_character_apply = 0
var pass_midpoint_block_apply = 0

## Individual Character Ability Variables
var ability_ready = true

# Selena - Bladesurge
var bladesurge_cooldown = 1 
var bladesurge_cooldown_timer = 0

# Isaac - Burnout

# DJ - Star Dash
var star_dash_active = false
var star_dash_speed_addition = 5
var star_dash_current_speed # will start at DJ's base max speed, and then added to

# Korria - Calculated Decision
var calculated_decision_slow = .20 # invese decimal of the slow (ie 80% slow would be .20 variable)

# Adien - Wind Step

# Lyvok - Reality Warp
var reality_warp_distance = 50 
var reality_warp_cooldown = 1 
var reality_warp_cooldown_timer = 0

## Block Management Variables
var block_count = 0

var block_array = []
var block_initialization_distance_x = 0

var instantiated_children = []

## Collision Check Variables
var collision_shape: CollisionShape2D
var next_frame_y = 0
var next_frame_delta = 0
var relative_block_anchor_position = 0

## Character Placement
var play_character: CharacterBody2D
const character_placement_x = 100
const character_placement_y = 475

# loading screen to initialize all of this?
func _ready():
	match CharacterHandler.currentCharacter:
		CharacterHandler.Character.SELENA:
			var selena_scene = ResourceLoader.load('res://SceneAssets/CharacterScenes/SelenaScn.tscn')
			play_character = selena_scene.instantiate()
			instantiated_children.append(play_character)
			
			acceleration = TestCharacterStats.selena_acceleration
			max_speed = TestCharacterStats.selena_max_speed
			brake_power = TestCharacterStats.selena_brake_power
			jump_power = TestCharacterStats.selena_jump_power
			slide_brake = TestCharacterStats.selena_slide_brake
		CharacterHandler.Character.ISAAC:
			var isaac_scene = ResourceLoader.load('res://SceneAssets/CharacterScenes/IsaacScn.tscn')
			play_character = isaac_scene.instantiate()
			instantiated_children.append(play_character)
			
			acceleration = TestCharacterStats.isaac_acceleration
			max_speed = TestCharacterStats.isaac_max_speed
			brake_power = TestCharacterStats.isaac_brake_power
			jump_power = TestCharacterStats.isaac_jump_power
			slide_brake = TestCharacterStats.isaac_slide_brake
		CharacterHandler.Character.DJ:
			var dj_scene = ResourceLoader.load('res://SceneAssets/CharacterScenes/DJScn.tscn')
			play_character = dj_scene.instantiate()
			instantiated_children.append(play_character)
			
			acceleration = TestCharacterStats.dj_acceleration
			max_speed = TestCharacterStats.dj_max_speed
			brake_power = TestCharacterStats.dj_brake_power
			jump_power = TestCharacterStats.dj_jump_power
			slide_brake = TestCharacterStats.dj_slide_brake
			
			star_dash_current_speed = TestCharacterStats.dj_max_speed
		CharacterHandler.Character.KORRIA:
			var korria_scene = ResourceLoader.load('res://SceneAssets/CharacterScenes/KorriaScn.tscn')
			play_character = korria_scene.instantiate()
			instantiated_children.append(play_character)
			
			acceleration = TestCharacterStats.korria_acceleration
			max_speed = TestCharacterStats.korria_max_speed
			brake_power = TestCharacterStats.korria_brake_power
			jump_power = TestCharacterStats.korria_jump_power
			slide_brake = TestCharacterStats.korria_slide_brake
		CharacterHandler.Character.ADIEN:
			var adien_scene = ResourceLoader.load('res://SceneAssets/CharacterScenes/AdienScn.tscn')
			play_character = adien_scene.instantiate()
			instantiated_children.append(play_character)
			
			acceleration = TestCharacterStats.adien_acceleration
			max_speed = TestCharacterStats.adien_max_speed
			brake_power = TestCharacterStats.adien_brake_power
			jump_power = TestCharacterStats.adien_jump_power
			slide_brake = TestCharacterStats.adien_slide_brake
		CharacterHandler.Character.LYVOK:
			var lyvok_scene = ResourceLoader.load('res://SceneAssets/CharacterScenes/LyvokScn.tscn')
			play_character = lyvok_scene.instantiate()
			instantiated_children.append(play_character)
			
			acceleration = TestCharacterStats.lyvok_acceleration
			max_speed = TestCharacterStats.lyvok_max_speed
			brake_power = TestCharacterStats.lyvok_brake_power
			jump_power = TestCharacterStats.lyvok_jump_power
			slide_brake = TestCharacterStats.lyvok_slide_brake
			
	play_character.position.x = character_placement_x
	play_character.position.y = character_placement_y
	play_character.z_index = 1
	get_tree().get_root().add_child(play_character)
	collision_shape = play_character.find_child('CollisionShape2D')
	
	gravity_acceleration = TestCharacterStats.gravity_acceleration * -1 #temp
	gravity_max = TestCharacterStats.gravity_max * -1 #temp
	
	midpoint = get_node('/root/PlayScreenScn/PlayControl').size.y / 2
	
	## Starting Movement States
	CharacterHandler.snap_next_frame = false
	CharacterHandler.on_ground = true
	CharacterHandler.is_sliding = false
	CharacterHandler.is_braking = false
	CharacterHandler.is_falling = false
	CharacterHandler.is_stopped = false
	CharacterHandler.in_ability = false
	CharacterHandler.is_jumping = false
	
	## Connecting to CharacterHandler signals
	CharacterHandler.connect('safe', _on_safe)
	CharacterHandler.connect('unsafe', _on_unsafe)
	CharacterHandler.connect('star_coin', _on_star_coin)
	
	block_initialization()
	
	CharacterHandler.current_play_state = CharacterHandler.CurrentPlayState.START
	
func _process(delta):
	if CharacterHandler.current_play_state == CharacterHandler.CurrentPlayState.PLAY:
		move_blocks(delta)
		
		if block_count < 4:
			add_block()
			
		if !ability_ready:
			if CharacterHandler.currentCharacter == CharacterHandler.Character.SELENA:
				bladesurge_cooldown_timer += delta
				if bladesurge_cooldown_timer >= bladesurge_cooldown:
					bladesurge_cooldown_timer = 0
					ability_ready = true
			elif CharacterHandler.currentCharacter == CharacterHandler.Character.LYVOK:
				reality_warp_cooldown_timer += delta
				if reality_warp_cooldown_timer >= reality_warp_cooldown:
					reality_warp_cooldown_timer = 0
					ability_ready = true
	elif CharacterHandler.current_play_state == CharacterHandler.CurrentPlayState.OVER:
		ending_game(delta)
	elif CharacterHandler.current_play_state == CharacterHandler.CurrentPlayState.END:
		final_end()
		
func _input(_event):
	if Input.is_action_just_pressed('jump'):
		if CharacterHandler.on_ground:
			gravity_applied += jump_power
			CharacterHandler.on_ground = false
			CharacterHandler.is_jumping = true
		elif !(CharacterHandler.on_ground) && (CharacterHandler.currentCharacter == CharacterHandler.Character.ADIEN) && ability_ready:
			gravity_applied += jump_power
			CharacterHandler.in_ability = true
			ability_ready = false
			
	if Input.is_action_just_pressed('brake'):
		CharacterHandler.is_braking = true
		
	if Input.is_action_just_released('brake'):
		CharacterHandler.is_braking = false
		
	if Input.is_action_just_pressed('slide'):
		CharacterHandler.is_sliding = true
	
	if Input.is_action_just_released('slide'):
		if CharacterHandler.on_ground:
			#slide_extension_active = true
			CharacterHandler.is_sliding = false
		else:
			CharacterHandler.is_sliding = false
			
	if Input.is_action_just_pressed('ability'):
		# we can actively use Bladesurge (Selena), Calculated Decision (Korria), and Reality Warp (Lyvok)
		# Bladesurge and Reality Warp have their own functions
		if ability_ready:
			if CharacterHandler.currentCharacter == CharacterHandler.Character.SELENA:
				bladesurge_activated()
			elif CharacterHandler.currentCharacter == CharacterHandler.Character.KORRIA:
				CharacterHandler.in_ability = true
				ability_ready = false
			elif CharacterHandler.currentCharacter == CharacterHandler.Character.LYVOK:
				reality_warp_activated()
				
	if Input.is_action_just_released('ability'):
		# Calculated Decision is the only ability we can really "deactivate"
		if CharacterHandler.currentCharacter == CharacterHandler.Character.KORRIA && CharacterHandler.in_ability:
			CharacterHandler.in_ability = false
			ability_ready = true
				
func _exit_tree():
	for instance in instantiated_children:
		instance.queue_free()
	
func block_initialization(): #loads 3 blocks on startup
	while block_count < 4:
		var block_to_load #will hold the variable that determines which block to load
		if block_count == 0:
			pass #this will bypass the RNG call so that the very first block in a run is always the same
		else:
			pass #rng call to set which block will be loaded
			
		var block_scene
		# match block_to_load setup
		block_scene = ResourceLoader.load('res://TestAssets/testScenes/TestBlock.tscn')
		var block_instance = block_scene.instantiate()
		get_tree().get_root().add_child(block_instance)
		instantiated_children.append(block_instance)
		
		if block_count == 0:
			block_instance.position.x = 0
			block_instance.position.y = 480 # bottom left of the screen
		else:
			block_instance.position.x = block_array[-1].position.x + 1000
			block_instance.position.y = block_array[-1].position.y

		
		block_array.append(block_instance)
		block_count += 1
		
func move_blocks(delta):
	for block in block_array:
		if CharacterHandler.currentCharacter == CharacterHandler.Character.KORRIA && CharacterHandler.in_ability:
			block.position.x -= (current_speed * delta * calculated_decision_slow) # subtracting becuase we are moving blocks left to right
			
			if block == block_array[0]:
				if above_midpoint:
					if CharacterHandler.snap_next_frame:
						block.position.y += next_frame_delta 
						absolute_y -= next_frame_delta
						print('Snap! Block position: ' + str(block.position.y))
						CharacterHandler.snap_next_frame = false
					elif passing_midpoint:
						block.position.y = 480
						play_character.position.y += (pass_midpoint_character_apply + (abs(block.position.y - 480)))
						passing_midpoint = false
						above_midpoint = false
					else:
						block.position.y += (gravity_applied * delta * calculated_decision_slow) # adding becuase the blocks move down
						absolute_y += (gravity_applied * delta * calculated_decision_slow) * -1 # keeps track of how "high" off the floor the character is
				elif !above_midpoint:
					if CharacterHandler.snap_next_frame:
						play_character.position.y = next_frame_y
						absolute_y = next_frame_y
						CharacterHandler.snap_next_frame = false
					elif passing_midpoint:
						play_character.position.y -= pass_midpoint_character_apply
						block.position.y -=  pass_midpoint_block_apply
						passing_midpoint = false
						above_midpoint = true
					else:
						play_character.position.y -= (gravity_applied * delta * calculated_decision_slow) # subtracting because character moves up
						absolute_y += (gravity_applied * delta * calculated_decision_slow) * -1 # keeps track of how "high" off the floor the character is
			else:
				block.position.y = block_array[0].position.y
			
			if CharacterHandler.on_ground:
				if !(CharacterHandler.is_braking) && !(CharacterHandler.is_sliding):
					CharacterHandler.is_stopped = false
					if current_speed < max_speed:
						current_speed += (acceleration * delta)
					elif current_speed >= max_speed:
						current_speed = max_speed
				elif CharacterHandler.is_sliding:
					if current_speed > 0:
						current_speed -= (slide_brake * delta)
					elif current_speed <= 0:
						current_speed = 0
						CharacterHandler.is_stopped = true
				elif CharacterHandler.is_braking:
					if current_speed > 0:
						current_speed -= (brake_power * delta)
					elif current_speed <= 0:
						current_speed = 0
						CharacterHandler.is_stopped = true
			elif !(CharacterHandler.on_ground):
				if block == block_array[0]:
					if gravity_applied > gravity_max: # gravity max is negative so we check if applied is larger
						gravity_applied += (gravity_acceleration * delta * calculated_decision_slow)
					elif gravity_applied <= gravity_max:
						gravity_applied = gravity_max
				
					if gravity_applied < 0:
						CharacterHandler.is_jumping = false
						CharacterHandler.is_falling = true
						if CharacterHandler.currentCharacter == CharacterHandler.Character.ADIEN:
							CharacterHandler.in_ability = false
							
					collision_shape.position.y = play_character.position.y + (abs(gravity_applied) * calculated_decision_slow)
					
			if !above_midpoint && !passing_midpoint:
				if (play_character.position.y - (gravity_applied * delta * calculated_decision_slow)) <= midpoint:
					passing_midpoint = true
					pass_midpoint_delta = play_character.position.y - (play_character.position.y - (gravity_applied * delta * calculated_decision_slow))
					pass_midpoint_character_apply = play_character.position.y - midpoint # character is coming up to midpoint
					pass_midpoint_block_apply = pass_midpoint_delta - pass_midpoint_character_apply # blocks will move down after midpoint
			elif above_midpoint && !passing_midpoint:
				if (absolute_y + (gravity_applied * delta * -1 * calculated_decision_slow)) >= midpoint:
					passing_midpoint = true
					pass_midpoint_delta = absolute_y - (absolute_y - (gravity_applied * delta * -1 * calculated_decision_slow))
					pass_midpoint_block_apply = absolute_y - midpoint #blocks are coming up to midpoint
					pass_midpoint_character_apply = pass_midpoint_delta - pass_midpoint_block_apply # character will move down after midpoint
		
		# end Korria ability movement block				
		else:
			block.position.x -= (current_speed * delta) # subtracting becuase we are moving blocks left to right
			
			if block == block_array[0]:
				if above_midpoint:
					if CharacterHandler.snap_next_frame:
						block.position.y += next_frame_delta 
						absolute_y -= next_frame_delta
						print('Snap! Block position: ' + str(block.position.y))
						CharacterHandler.snap_next_frame = false
					elif passing_midpoint:
						block.position.y = 480
						play_character.position.y += (pass_midpoint_character_apply + (abs(block.position.y - 480)))
						passing_midpoint = false
						above_midpoint = false
					else:
						block.position.y += (gravity_applied * delta) # adding becuase the blocks move down
						absolute_y += (gravity_applied * delta) * -1 # keeps track of how "high" off the floor the character is
				elif !above_midpoint:
					if CharacterHandler.snap_next_frame:
						play_character.position.y = next_frame_y
						absolute_y = next_frame_y
						CharacterHandler.snap_next_frame = false
					elif passing_midpoint:
						play_character.position.y -= pass_midpoint_character_apply
						block.position.y -=  pass_midpoint_block_apply
						passing_midpoint = false
						above_midpoint = true
					else:
						play_character.position.y -= (gravity_applied * delta) # subtracting because character moves up
						absolute_y += (gravity_applied * delta) * -1 # keeps track of how "high" off the floor the character is
			else:
				block.position.y = block_array[0].position.y
			
			if CharacterHandler.on_ground:
				if !(CharacterHandler.is_braking) && !(CharacterHandler.is_sliding):
					CharacterHandler.is_stopped = false
					if current_speed < max_speed:
						current_speed += (acceleration * delta)
					elif current_speed >= max_speed:
						current_speed = max_speed
				elif CharacterHandler.is_sliding:
					if current_speed > 0:
						current_speed -= (slide_brake * delta)
					elif current_speed <= 0:
						current_speed = 0
						CharacterHandler.is_stopped = true
				elif CharacterHandler.is_braking:
					if current_speed > 0:
						current_speed -= (brake_power * delta)
					elif current_speed <= 0:
						current_speed = 0
						CharacterHandler.is_stopped = true
			elif !(CharacterHandler.on_ground):
				if block == block_array[0]:
					if gravity_applied > gravity_max: # gravity max is negative so we check if applied is larger
						gravity_applied += (gravity_acceleration * delta)
					elif gravity_applied <= gravity_max:
						gravity_applied = gravity_max
				
					if gravity_applied < 0:
						CharacterHandler.is_jumping = false
						CharacterHandler.is_falling = true
						if CharacterHandler.currentCharacter == CharacterHandler.Character.ADIEN:
							CharacterHandler.in_ability = false
							
					collision_shape.position.y = play_character.position.y + abs(gravity_applied)
					
			if !above_midpoint && !passing_midpoint:
				if (play_character.position.y - (gravity_applied * delta)) <= midpoint:
					passing_midpoint = true
					pass_midpoint_delta = play_character.position.y - (play_character.position.y - (gravity_applied * delta))
					pass_midpoint_character_apply = play_character.position.y - midpoint # character is coming up to midpoint
					pass_midpoint_block_apply = pass_midpoint_delta - pass_midpoint_character_apply # blocks will move down after midpoint
			elif above_midpoint && !passing_midpoint:
				if (absolute_y + (gravity_applied * delta * -1)) >= midpoint:
					passing_midpoint = true
					pass_midpoint_delta = absolute_y - (absolute_y - (gravity_applied * delta * -1))
					pass_midpoint_block_apply = absolute_y - midpoint #blocks are coming up to midpoint
					pass_midpoint_character_apply = pass_midpoint_delta - pass_midpoint_block_apply # character will move down after midpoint
		
		# end regular movement block
				
		if block.position.x <= -1100 && block_count >= 3:
			remove_block(block)
			
func add_block():
	var block_to_load #will hold the variable that determines which block to load
	#rng call to set which block will be loaded
			
	var block_scene
	# match block_to_load setup
	block_scene = ResourceLoader.load('res://TestAssets/testScenes/TestBlock.tscn')
	var block_instance = block_scene.instantiate()
	get_tree().get_root().add_child(block_instance)
	instantiated_children.append(block_instance)
		
	block_instance.position.x = block_array[-1].position.x + 1000
	block_instance.position.y = block_array[-1].position.y
	
	block_array.append(block_instance)
	block_count += 1
	
func remove_block(block):
	block_array.erase(block)
	instantiated_children.erase(block)
	block.queue_free()
	block_count =- 1
	
func ending_game(_delta):
	#remove play control
	#fade out blocks/background
	#add in end control
	#calculate score
	#score = (game_distance / game_time) * star_coins
	CharacterHandler.current_play_state = CharacterHandler.CurrentPlayState.END
	
func final_end():
	SceneHandler.goto_scene('res://SceneAssets/CharacterSelectScenes/CharacterSelectScn.tscn')
	#buttons come in
		
# character, collision shape
func _on_safe(collision_shape_node):
	# initial variable collection
	var collision_shape_position_y = collision_shape_node.global_position.y
	CharacterHandler.snap_next_frame = true
	
	# stuff if we are below midpoint
	if !above_midpoint:
		next_frame_y = collision_shape_position_y
	# stuff if we are above midpoint
	elif above_midpoint:
		var parent_block = collision_shape_node.get_parent().get_parent() # should return to block parent of the platform/floor
		relative_block_anchor_position = parent_block.position.y - collision_shape_position_y
		next_frame_delta = play_character.position.y - collision_shape_position_y
		next_frame_y = parent_block.position.y - next_frame_delta
	
	CharacterHandler.on_ground = true
	CharacterHandler.is_falling = false
	gravity_applied = 0
	if CharacterHandler.currentCharacter == CharacterHandler.Character.ADIEN && !ability_ready:
		ability_ready = true
	
func _on_unsafe():
	if CharacterHandler.currentCharacter == CharacterHandler.Character.ISAAC && ability_ready:
		burnout_activated()
	else:
		gravity_applied = 0
		#CharacterHandler.current_play_state = CharacterHandler.CurrentPlayState.OVER
	
func _on_star_coin():
	star_coins_collected += 1
	if (CharacterHandler.currentCharacter == CharacterHandler.Character.DJ) && (current_speed == max_speed) && !star_dash_active:
		star_dash_active = true
		star_dash_current_speed += star_dash_speed_addition
	elif star_dash_active:
		star_dash_current_speed += star_dash_speed_addition
		
## Character Ability Functions
# Selena - Bladesurge
func bladesurge_activated():
	CharacterHandler.in_ability = true
	# dash forward and destroy an obstacle
	ability_ready = false
	
# Isaac - Burnout
func burnout_activated():
	CharacterHandler.in_ability = true
	# destroy the obstacle
	ability_ready = false
	
# DJ - Star Dash
# functionality found in the _on_star_coin function

# Korria - Calculated Desicsion
# functionality found in the move_blocks functions

# Adien - Wind Step
# functionality found in the move_block function

# Lyvok - Reality Warp
func reality_warp_activated():
	CharacterHandler.in_ability = true
	for block in block_array:
		block.position.x -= reality_warp_distance
	#might need to two-part animation - fade in and fade out
	ability_ready = false
	
