extends "res://scripts/game/Level.gd"

onready var gf_layer = get_node_or_null("ParallaxBackground/GF")
onready var fg_layer = get_node_or_null("ParallaxBackground/FG")
onready var cam = $HUDPackage2D/Cam_HUD
onready var clouds = get_node_or_null("ParallaxBackground/FG/Clouds")
onready var camera3D = $Camera
onready var holdAuthorOpacity = false

func _ready():
	pass
	#camera3D.songSection = 0
	#camera3D.waitItOut = 0.5

func do_level_specific_prep():
	match song_data.name:
		"Tutorial":
			switch_performer("opponent", "gf")
			
			# TODO: Figure out why the fuck the above call
			# to switch_performer persists across scene instances
			# EDIT: it's a Godot bug
#			get_character("dad").hide()
			
			set_performer("metronome") # Clear metronome
			
			gf_layer.motion_scale = Vector2.ONE
		
		"Fresh", "Dadbattle":
			get_performer("player").idle_frequency = 2
			get_performer("opponent").idle_frequency = 2

func do_pre_level_story_event():
	var new_dialogue = null
	
	match song_data.name:
		"Tutorial":
			pass
		"dysphoria":
			hud.visible = false
			new_dialogue = Dialogic.start("Dysphoria")
		"Journey":
			Conductor.move3DCam = false
			hud.visible = false
			new_dialogue = Dialogic.start("Journey")
		"escape velocity":
			hud.visible = false
			new_dialogue = Dialogic.start("hyperspeed")
	if new_dialogue:
		new_dialogue.connect("timeline_end", self, "_after_textbox", [], CONNECT_ONESHOT | CONNECT_DEFERRED)
		add_child(new_dialogue)
	else:
		start_level_part_2()

func _after_textbox(_tl_name):
	hud.visible = true
	start_level_part_2()

func _process(delta):
	#print(Conductor.song_position)
	if (self.name == "Level_Stage"):
		if !camera3D.performanceModeActive:
			if (Conductor.song_position >= 22.327245 and Conductor.song_position < 29.620461):
				fg_layer.visible = true
				cam.canmove = false
				clouds.position.y+=(1*60)*delta
			if (Conductor.song_position >= 29.620461):
				cam.canmove = true
				fg_layer.visible = false
