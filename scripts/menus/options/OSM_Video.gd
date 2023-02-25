extends "res://scripts/menus/options/OptionsSubmenu.gd"

func _ready():
	for option_path in valid_options_paths:
		get_node(option_path).reload()
		
func _process(delta):
	if !(Input.is_action_pressed("ui_left") || Input.is_action_pressed("ui_right")):
		return
		
func on_input(event: InputEvent):
	if GodotX.xor(event.is_action_pressed("ui_up"), event.is_action_pressed("ui_down")):
		var increment = -1 if event.is_action_pressed("ui_up") else 1
	
		cur_option = wrapi(cur_option + increment, 0, len(options))
		on_scroll()
	
	elif GodotX.xor(event.is_action("ui_left"), event.is_action("ui_right")):
		on_select(event)
	
	elif event.is_action_released("ui_cancel"):
		on_back()

func on_select(_event):
	options[cur_option].on_input(_event)
	
	if !_event.is_pressed():
		return
		
	match options[cur_option].name:
		"FPS":
			Engine.set_target_fps(UserData.get_setting("fps", 60, "video"))
#		"InternalRes":
#			match(UserData.get_setting("internal_resolution", 1, "video")):
#				0: get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_2D,  SceneTree.STRETCH_ASPECT_KEEP, Vector2(1280,720), 1)
#				1: get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_2D,  SceneTree.STRETCH_ASPECT_KEEP, Vector2(320,180), 1)
#				2: get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_2D,  SceneTree.STRETCH_ASPECT_KEEP, Vector2(640,360), 1)
#				3: get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_2D,  SceneTree.STRETCH_ASPECT_KEEP, Vector2(1920,1080), 1)
			
			
	match GodotX.get_script_filename(options[cur_option]):
		_: # SpinOption
			scroll_sound.stop()
			scroll_sound.play()
