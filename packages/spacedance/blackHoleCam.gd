extends Camera


var translat = [15.01, -4.019, 0.435]#x, y, z
var rotationDegrees = [0, -90.593, 0]
var songSection = 0
var waitItOut = 0.5
var fovQuantity = 0.01
var songPosition = 0.0
var shadersDisabled = false
var playFinalTransition = true
var performanceModeActive = false
var updPerformancePositions = false

onready var hudStuff = get_parent().get_node("HUDPackage2D/ColorRect/AnimationPlayer")
onready var hud = get_parent().get_node("HUDPackage2D/HUD/Visible_Elements")
onready var songCredits = get_parent().get_node("AuthorLayer/ColorRect2")
onready var anita = get_parent().get_node("Anita")
onready var anitaAnim = get_parent().get_node("Anita/AnimationPlayer")
onready var bf = get_parent().get_node("Boyfriend")
onready var maya = get_parent().get_node("Maya")
onready var gf = get_parent().get_node("Girlfriend")
onready var gfAnim = get_parent().get_node("Girlfriend/AnimationPlayer")
onready var ship = get_parent().get_node("ship")
onready var videoPlayer = get_parent().get_node("VideoLayer/VideoPlayer")
onready var cutscene = get_parent().get_node("CutsceneCanvas")
onready var shaders = get_parent().get_node("CanvasLayer/ColorRect")
onready var blackBars = get_parent().get_node("AuthorLayer/BlackBars")
onready var blackScreen = get_parent().get_node("AuthorLayer/ColorRect3")

onready var env = get_parent().get_environment()

#camMoveTo first = -350.022, 94.641, 94.641, -3.816, -84.328, 0

# Called when the node enters the scene tree for the first time.
func _ready():
	if (UserData.get_setting("shaders", 0, "video")) == 1:
		shaders.queue_free()
		shadersDisabled = true

	if (UserData.get_setting("background_events", 0, "video")) == 1:
		performanceModeActive = true

	anitaAnim.play("Idle")
	gfAnim.play("Dance_Left")
	env.ambient_light_color = Color("#e636ff")
	waitItOut = 0.5
	songSection = 0
	Conductor.song_position = 0
	songCredits.get_parent().layer = 0
	songCredits.startCountdown = true
	updateCam(-293.614,117.165,9.718,-23.169,-138.089,0, false, 0)

func _physics_process(delta):
#	if (Input.is_action_just_pressed("skipBackward")):
#		Conductor.song_position -= 1
#		Conductor.play(Conductor.song_position)
#		Conductor.vocals.play(Conductor.song_position)
#	if (Input.is_action_just_pressed("skipForward")):
#		Conductor.song_position += 5
#		Conductor.play(Conductor.song_position)
#		Conductor.vocals.play(Conductor.song_position)
	songPosition = Conductor.song_position
	if (!performanceModeActive):
		if (waitItOut <= 0):
			if ((songPosition > 0 and songSection == 0) or Conductor.counting_down):
				if songSection == 0:
					songSection = 1
					updateCam(-295,140,-300,0,0,0, false, 0)
			if (songPosition >= 11.536892 and songSection == 1):
				songSection = 2
				updateCam(-293.747,117.142,10.672,-4.652,-25.997,0, false, 0)
			if (songPosition >= 17.347647 and songSection == 2):
				songSection = 3
				updateCam(-293.38,117.326,10.481,-26.802,0,0,false,0)
			if (songPosition >= 23.048313 and songSection == 3):
				songSection = 4
				updateCam(-294.908,117.373,12.725,-4.652,-25.101,0,false,0)
			if (songPosition >= 28.805636 and songSection == 4):
				songSection = 5
				updateCam(-293.996,117.097,10.403,0,0,0,false,0)
			if (songPosition >= 30.170551 and songSection == 5):
				songSection = 6
			if (songPosition >= 31.652244 and songSection == 6):
				songSection = 7
				updateCam(-286.747,117.7090,13.351,0,54.645,0,false,0)
			if (songPosition >= 34.546144 and songSection == 7):
				updateCam(-293.921,117.173,10.24,0,-90,0,false,0)
				songSection = 8
				anita.translation.x = -293.7
				anita.translation.y = 117.106
				anita.translation.z = 10.079
				anita.rotation_degrees.y = -97.268
				bf.translation.x = -293.929
				bf.translation.y = 116.829
				bf.translation.z = 10.213
				bf.rotation_degrees.y = 93.54
				if !shadersDisabled:
					shaders.visible = true
				blackBars.visible = true
			if (songPosition >= 46.019487 and songSection == 8):
				songSection = 9
				cutscene.visible = true
				cutscene.get_node("AnimationPlayer").play("1")
			if (songPosition >= 48.889055 and songSection == 9):
				songSection = 10
				cutscene.get_node("AnimationPlayer").play("2")
			if (songPosition >= 51.767289 and songSection == 10):
				songSection = 11
				cutscene.visible = false
				updateCam(-292.525,117.226,9.591,0,-47.451,0,false,0)
			if (songPosition >= 57.54797 and songSection == 11):
				songSection = 12
				updateCam(-293.352,117.249,10.252,-31.87,0,0,false,0)
			if (songPosition >= 63.304601 and songSection == 12):
				songSection = 13
				updateCam(-293.352,118.571,12.571,-31.87,0,0,false,0)
			if (songPosition >= 68.443048 and songSection == 13):
				songSection = 14
			if (songPosition >= 74.80734 and songSection == 14):
				songSection = 15
				blackScreen.modulate.a = 0
				fov = 70
				updateCam(-293.959,117.142,10.265,0,0,0,false,0)
				anita.translation.x = -293.912
				anita.translation.y = 117.106
				anita.translation.z = 10.079
				anita.rotation_degrees.y = 17.864
				bf.translation.x = -293.106
				bf.translation.y = 116.829
				bf.translation.z = 10.031
				bf.rotation_degrees.y = -11.215
			if (songPosition >= 77.64973 and songSection == 15):
				songSection = 16
				updateCam(-292.942,117.051,10.265,0,0,0,false,0)
			if (songPosition >= 83.023024 and songSection == 16):
				songSection = 17
				updateCam(-293.36,117.095,10.024,0,0,0,false,0)
			if (songPosition >= 86.282469 and songSection == 17):
				songSection = 18
				updateCam(-293.959,117.142,10.265,0,0,0,false,0)
			if (songPosition >= 87.755226 and songSection == 18):
				songSection = 19
				updateCam(-292.942,117.051,10.265,0,0,0,false,0)
			if (songPosition >= 89.164926 and songSection == 19):
				songSection = 20
				updateCam(-293.351,117.618,10.848,-14.577,0,0,false,0)
			if (songPosition >= 92.04518 and songSection == 20):
				gf.visible = false
				bf.visible = false
				anita.visible = false
				maya.visible = false
				songSection = 21
				ship.noPower = true
				env.ambient_light_color = Color("#A375BA")
				updateCam(-288.149,128.544,32.081,-14.577,0,0,false,0)
		else:
			songSection = 0 
			waitItOut-= (0.1*60)*delta
	else:
		if (songPosition >= 92.04518):
			if (blackScreen.modulate.a < 1):
				blackScreen.modulate.a += (0.05*60)*delta
		if (blackScreen.modulate.a > 0 and (songPosition > 0 and songPosition < 92.04518)):
			blackScreen.modulate.a -= (0.01*60)*delta
		if (!updPerformancePositions):
			updPerformancePositions = true
			updateCam(-293.351,117.618,10.848,-14.577,0,0,false,0)
			anita.translation.x = -293.912
			anita.translation.y = 117.150
			anita.translation.z = 9.777
			anita.rotation_degrees.y = 17.864
			bf.translation.x = -293.106
			bf.translation.y = 116.869
			bf.translation.z = 9.777
			bf.rotation_degrees.y = -11.215
			maya.translation.z = 9.777
	match(songSection):
		1:
			if (blackScreen.modulate.a > 0):
				blackScreen.modulate.a -= (0.01*60)*delta
			translation.z += (0.2*60)*delta
			rotation_degrees.z -= (0.05*60)*delta
		2:
			rotation_degrees.y -= (0.05*60)*delta
			translation.x += (0.001*60)*delta
		3:
			translation.z -= (0.001*60)*delta
		4:
			translation.x += (0.01*60)*delta
			translation.z += (0.05*60)*delta
		6:
			updateCam(-292.931,117.097,10.403,0,0,0,true,delta*2)
		7: 
			translation.z += (0.05*60)*delta
		8:
			translation.x -= (0.001*60)*delta
		11:
			translation.x -= (0.001*60)*delta
			translation.z += (0.001*60)*delta
		12:
			translation.z -= (0.001*60)*delta
		13: 
			translation.y += (0.01*60)*delta
			rotation_degrees.x += (0.1*60)*delta
		14:
			translation.z -= (0.8*60)*delta
			if (blackScreen.modulate.a < 1):
				blackScreen.modulate.a += (0.01*60)*delta
			if fov >= 2:
				fov -= (0.8*60)*delta
		15:
			translation.x -= (0.001*60)*delta
		16:
			translation.z += (0.001*60)*delta
		20:
			translation.z += (0.001*60)*delta
		21:
			ship.translation.z -= (0.5*60)*delta
			ship.rotation_degrees.x -= (0.8*60)*delta
			ship.rotation_degrees.y -= (1*60)*delta
			if (blackScreen.modulate.a < 1):
				blackScreen.modulate.a += (0.0035*60)*delta
				

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
