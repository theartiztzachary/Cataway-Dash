extends Node

### This code handles switching scenes. ###

# start with no pointer for the current scene, since this script loads before the scenes load
var current_scene = null

# _ready is called when the node enters the scene tree for the first time
func _ready():
	var root = get_tree().get_root() # getting the root of the scene structure
	# both the currently loaded scene and any autoloaded global things are children of root, but autoloaded
	# nodes are always first, so the last child of the root is the loaded scene, and we're counting in computer
	current_scene = root.get_child(root.get_child_count() - 1) #set the current scene as the current scene :>
	
func goto_scene(path):
	# this is called from within a current scene
	
	# stops loading a different scene while code from the previous scene is running
	# putting the job of "clean up" on the loaded scene
	call_deferred("_deferred_goto_scene", path)
	
func _deferred_goto_scene(path):
	# once here, it is considered safe to remove the current scene
	current_scene.free() # be free my scene
	var new_scene = ResourceLoader.load(path) # load the new scene
	current_scene = new_scene.instantiate() # instance the new scene and set it as the current scene
	get_tree().get_root().add_child(current_scene) # add it to the big root
	
	## if you end up using the SceneTree.change_scene_to_file() API, you can also use
	## get_tree().set_current_scene(current_scene)
	## as the last line
