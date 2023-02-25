extends Camera

var translat = [15.01, -4.019, 0.435]#x, y, z
var rotationDegrees = [0, -90.593, 0]
var songSection = 0
var waitItOut = 0.5
var fovQuantity = 0.01
var shadersDisabled = false
var playFinalDialogue = true
var performanceModeActive = false
var updPerformancePositions = false

onready var hudStuff = get_parent().get_node("HUDPackage2D/ColorRect/AnimationPlayer")
onready var hud = get_parent().get_node("HUDPackage2D/HUD/Visible_Elements")
onready var songCredits = get_parent().get_node("AuthorLayer/ColorRect2")
onready var jazz = get_parent().get_node("jazz")
onready var jazzanim = get_parent().get_node("jazz/AnimationPlayer")
onready var bf = get_parent().get_node("Boyfriend")
onready var gf = get_parent().get_node("Girlfriend")
onready var gfAnim = get_parent().get_node("Girlfriend/AnimationPlayer")
onready var bar1 = get_parent().get_node("CanvasLayer3/BlackBar")
onready var bar2 = get_parent().get_node("CanvasLayer3/BlackBar2")
onready var speedLines = get_parent().get_node("CanvasLayer3/SpeedLines")
onready var wavy = get_parent().get_node("CanvasLayer/woaa")
onready var lizSixteen = get_parent().get_node("LizAnd016")
onready var glitch = get_parent().get_node("CanvasLayer2/glitch")

#camMoveTo first = -350.022, 94.641, 94.641, -3.816, -84.328, 0

# Called when the node enters the scene tree for the first time.
func _ready():
	if (UserData.get_setting("shaders", 0, "video")) == 1:
		speedLines.queue_free()
		glitch.queue_free()
		wavy.queue_free()
		shadersDisabled = true
	else:
		pass
	if (UserData.get_setting("background_events", 0, "video")) == 1:
		performanceModeActive = true
	jazzanim.play("Idle")
	gfAnim.play("Dance_Left")
	waitItOut = 0.5
	songSection = 0
	Conductor.song_position = 0
	songCredits.startCountdown = true
	updateCam(-291.596, 111.64, 168.714, 5.977, -46.525, 9.227, false, 0)

func _physics_process(delta):
	#moodCHANGE AT: 54.653244
	#next: 74.564053
	#camera focusing on jazz's face -342.136, 95.592, 95.592, 0, -67.44, 0
#	if (Input.is_action_just_pressed("skipBackward")):
#		Conductor.song_position -= 1
#		Conductor.play(Conductor.song_position)
#		Conductor.vocals.play(Conductor.song_position)
#	if (Input.is_action_just_pressed("skipForward")):
#		Conductor.song_position += 5
#		Conductor.play(Conductor.song_position)
#		Conductor.vocals.play(Conductor.song_position)

	if (Conductor.song_position >= 145.81307 and playFinalDialogue) and !get_parent().lvl_manager.is_freeplay:
		playFinalDialogue = false
		songSection = 26
		if (!shadersDisabled):
			speedLines.visible = false
			glitch.visible = false
			bar1.visible = false
			bar2.visible = false
		hud.visible = false
		var new_dialogue = null
		new_dialogue = Dialogic.start("DysphoriaEnd")
		if new_dialogue:
			Conductor.stop_song()
			new_dialogue.connect("timeline_end", self, "_after_textbox", [], CONNECT_ONESHOT | CONNECT_DEFERRED)
			add_child(new_dialogue)
	if (!performanceModeActive):
		if (waitItOut <= 0 and !performanceModeActive):
			if (Conductor.song_position >= 3.401321 and songSection == 0):
				songSection = 1
			if (Conductor.song_position >= 6.669211 and songSection == 1):
				fov = 70
				updateCam(-352.497, 118.031, 185.343, -32.893, -48.485, -6.301, false, 0)
				songSection = 2
			if (Conductor.song_position >= 13.313051 and songSection == 2):
				updateCam(-343.899, 95.592, 163.518, 0, -67.44, 0, false, 0)
				songSection = 3
			if (Conductor.song_position >= 26.550568 and songSection == 3):
				updateCam(-349.668, 118.031, 173.496, -71.644, -58.869, -24.793, false, 0)
				songSection = 4
			if (Conductor.song_position >= 39.96797 and songSection == 4):
				fov = 115.6
				updateCam(-344.45, 94.68, 161.162, 0, -133.825, 0, false, 0)
				songSection = 5
			if (Conductor.song_position >= 46.561957 and songSection == 5):
				fov = 115.6
				updateCam(-339.556, 92.671, 175.495, 0, -53.765, 0, false, 0)
				songSection = 6
			if (Conductor.song_position >= 51.320082 and songSection == 6):
				fov = 70
				updateCam(-343.895, 94.436, 174.837, 0, -92.621, 0, false, 0)
				songSection = 7
			if (Conductor.song_position >= 51.755138 and songSection == 7):
				updateCam(-342.196, 94.436, 174.837, 0, -92.621, 0, false, 0)
				songSection = 8
			if (Conductor.song_position >= 52.129548 and songSection == 8):
				updateCam(-340.867, 94.436, 174.837, 0, -92.621, 0, false, 0)
				songSection = 9
			if (Conductor.song_position >= 52.579157 and songSection == 9):
				updateCam(-340.033, 94.436, 174.837, 0, -92.621, 0, false, 0)
				songSection = 10
			if (Conductor.song_position >= 52.996407 and songSection == 10):
				updateCam(-366.855, 94.436, 168.831, 0, -92.621, 0, false, 0)
				songSection = 11
			#SECOND SECTION
			if (Conductor.song_position >= 54.653244 and songSection == 11):
				updateCam(-343.846, 94.965, 161.75, 0, -92.621, 0, false, 0)
				songSection = 12
				hud.visible = false
				bar1.visible = true
				bar2.visible = true
				
			if (Conductor.song_position >= 56.332777 and songSection == 12):
				updateCam(-340.419, 94.03, 174.625, 0, -92.621, 0, false, 0)
				songSection = 13
			if (Conductor.song_position >= 57.963597 and songSection == 13):
				updateCam(-366.855, 94.436, 168.831, 0, -92.621, 0, false, 0)
				songSection = 14
				if (!shadersDisabled):
					wavy.visible = true
				lizSixteen.visible = true
			if (Conductor.song_position >= 59.689657 and songSection == 14):
				updateCam(-315.217, 98.041, 174.625, 0, -79.399, 0, false, 0)
				songSection = 15
			if (Conductor.song_position >= 61.223978 and songSection == 15):
				updateCam(-366.855, 94.436, 168.831, 0, -92.621, 0, false, 0)
				songSection = 16
				hud.visible = true
				if (!shadersDisabled):
					wavy.visible = true
				lizSixteen.visible = true
			if (Conductor.song_position >= 81.120206 and songSection == 16):
				songSection = 17
				fov = 70
				if (!shadersDisabled):
					speedLines.visible = true
					glitch.visible = true
					wavy.visible = false
				updateCam(-352.497, 118.031, 185.343, -32.893, -48.485, -6.301, false, 0)
			if (Conductor.song_position >= 94.356841 and songSection == 17):
				songSection = 18
				updateCam(-342.467, 94.075, 174.625, 0, -79.399, 0, false, 0)
			if (Conductor.song_position >= 97.665945 and songSection == 18):
				songSection = 19
				updateCam(-336.565, 98.038, 168.382, 0, -79.399, 0, false, 0)
			if (Conductor.song_position >= 101.017336 and songSection == 19):
				songSection = 20
				updateCam(-343.899, 95.592, 163.518, 0, -67.44, 0, false, 0)
			if (Conductor.song_position >= 104.307594 and songSection == 20):
				songSection = 21
				lizSixteen.play("016Smile")
				updateCam(-306.211, 97.91, 170.26, 0, -72.932, 0, false, 0)
			if (Conductor.song_position >= 107.640013 and songSection == 21):
				songSection = 22
				updateCam(-340.369, 94.137, 175.713, 0, -72.932, 0, false, 0)
			if (Conductor.song_position >= 122.599056 and songSection == 22):
				songSection = 23
				updateCam(-343.783, 95.834, 165.641, 0, -72.932, 0, false, 0)
			if (Conductor.song_position >= 125.837482 and songSection == 23):
				songSection = 24
				updateCam(-340.369, 94.137, 175.713, 0, -72.932, 0, false, 0)
			if (Conductor.song_position >= 129.177871 and songSection == 24):
				songSection = 25
				updateCam(-366.855, 94.436, 168.831, 0, -92.621, 0, false, 0)

			match(songSection):
				0:
					if (fov != 86):
						fov = 86
					updateCam(-343.899, 95.592, 163.518, 0, -67.44, 0, true, (0.01*60)*delta)
				1:
					updateCam(-341.34, 93.762, 175.374, 6.984, -83.468, 0, true, (0.025*60)*delta)
				2:
					translation.z -= (0.01*60)*delta
					translation.y -= (0.03*60)*delta
					rotation_degrees.y -= (0.01*60)*delta
				3:
					translation.x -= (0.02*60)*delta
					rotation_degrees.y -= (0.05*60)*delta
				4:
					translation.y += (0.02*60)*delta
				5:
					translation.z -= (0.01*60)*delta
				6:
					translation.z += (0.01*60)*delta
				11:
					translation.z += (0.01*60)*delta
				15:
					translation.z -= (0.04*60)*delta
					
				16:
					translation.x += (0.02*60)*delta
					fovQuantity += ((0.001*delta)/10)*60
					fov += (fovQuantity*60)*delta
					rotation_degrees.z -= (0.04*60)*delta
				17:
					translation.y -= (0.02*60)*delta
				19:
					translation.z -= (0.01*60)*delta
				20:
					translation.z += (0.01*60)*delta
				21:
					translation.z += (0.01*60)*delta
				22:
					translation.x -= (0.02*60)*delta
				23:
					translation.z -= (0.01*60)*delta
				25:
					translation.x += (0.02*60)*delta
					rotation_degrees.z -= (0.04*60)*delta
		else:
			songSection = 0 
			waitItOut-= (0.1*60)*delta
	else:
		if (Conductor.song_position >= 54.653244 and songSection == 0):
			songSection = 12
			hud.visible = false
			bar1.visible = true
			bar2.visible = true
			
		if (Conductor.song_position >= 56.332777 and songSection == 12):
			songSection = 13
		if (Conductor.song_position >= 57.963597 and songSection == 13):
			songSection = 14
			if (!shadersDisabled):
				wavy.visible = true
		if (Conductor.song_position >= 61.223978 and songSection == 14):
			songSection = 15
			hud.visible = true
		if (Conductor.song_position >= 81.120206 and songSection == 15):
			songSection = 16
			if (!shadersDisabled):
				speedLines.visible = true
				glitch.visible = true
				wavy.visible = false
		if (!updPerformancePositions):
			updPerformancePositions = true
			updateCam(-350.755, 94.436, 168.831, 0, -80.621, 0, false, 0)
		
func updateCam(xt, yt, zt, xr, yr, zr, usesLerp, delta):
	if (!usesLerp):
		translation.x = xt
		translation.y = yt
		translation.z = zt
		rotation_degrees.x = xr
		rotation_degrees.y = yr
		rotation_degrees.z = zr
	else:
		translation.x = lerp(translation.x, xt, (0.05*60)*delta)
		translation.y = lerp(translation.y, yt, (0.05*60)*delta)
		translation.z = lerp(translation.z, zt, (0.05*60)*delta)
		rotation_degrees.x = lerp(rotation_degrees.x, xr, (0.05*60)*delta)
		rotation_degrees.y = lerp(rotation_degrees.y, yr, (0.05*60)*delta)
		rotation_degrees.z = lerp(rotation_degrees.z, zr, (0.05*60)*delta)

func _after_textbox(_tl_name):
	get_parent().end_level_part_2()
