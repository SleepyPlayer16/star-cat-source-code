extends Camera


var translat = [15.01, -4.019, 0.435]#x, y, z
var rotationDegrees = [0, -90.593, 0]
var songSection = 0
var waitItOut = 0.5
var playFinalTransition = true
var performanceModeActive = false

onready var hudStuff = get_parent().get_node("HUDPackage2D/ColorRect/AnimationPlayer")
onready var ship = get_parent().get_node("OuterSpace/ship")
onready var ship2 = get_parent().get_node("OuterSpace/ship2")
onready var earth = get_parent().get_node("OuterSpace/earth")
onready var sun = get_parent().get_node("OuterSpace/Sun/DirectionalLight")
onready var blackScreen = get_parent().get_node("CanvasLayer/ColorRect")
onready var hud = get_parent().get_node("HUDPackage2D/HUD/Visible_Elements")
onready var bf = get_parent().get_node("Boyfriend/AnimationPlayer")
onready var gf = get_parent().get_node("Girlfriend/AnimationPlayer")
onready var anita = get_parent().get_node("Anita/AnimationPlayer")
# Called when the node enters the scene tree for the first time.
func _ready():
	if (UserData.get_setting("background_events", 0, "video")) == 1:
		performanceModeActive = true
	else:
		pass
	gf.play("Dance_Left")
	anita.play("Idle")
	bf.play("Idle")
	waitItOut = 0.5
	blackScreen.modulate.a = 0
	songSection = 0
	Conductor.song_position = 0	
	updateCam(24.5, 1.21, -9.5, 0, -90, 0, false, 0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#-= delta 
	#translation.x-=delta
	#rotation_degrees.y = lerp(rotation_degrees.y,44.457,delta)
	
func _physics_process(delta):
#	if (Input.is_action_just_pressed("skipBackward")):
#		Conductor.song_position -= 1
#		Conductor.play(Conductor.song_position)
#		Conductor.vocals.play(Conductor.song_position)
#	if (Input.is_action_just_pressed("skipForward")):
#		Conductor.song_position += 5
#		Conductor.play(Conductor.song_position)
#		Conductor.vocals.play(Conductor.song_position)
	if (!performanceModeActive):
		if (waitItOut <= 0 and Conductor.move3DCam):
			if (Conductor.song_position >= 1.899399 and songSection == 0):
				if (Conductor.counting_down == false):
					songSection = 1
				updateCam(24.256,1.217,8.386, 0, -90.593, 0, false, delta)
			if (Conductor.song_position >= 3.795244 and songSection == 1):
				songSection = 2
				updateCam(18.7, 4.82, 0.07, 0, -90, 0, false, delta)
			if (Conductor.song_position >= 7.477384 and songSection == 2):
				songSection = 3
			if (Conductor.song_position >= 21.74625 and songSection == 3):
				songSection = 4
			if (Conductor.song_position >= 22.245282 and songSection == 4):
				updateCam(
					translat[0],
					translat[1],
					translat[2],
					rotationDegrees[0],
					rotationDegrees[1],
					rotationDegrees[2],
					false,
					delta
				)
				songSection = 5
				hudStuff.play("FadeOut")
			if (Conductor.song_position >= 36.933604 and songSection == 5):
				songSection = 6
				
			if (Conductor.song_position >= 37.064906 and songSection == 6):
				songSection = 7
				updateCam(-170.588, 35.126, 258.164, 0, -26.379, 0, false, delta)
				ship.visible = true
				ship2.visible = true
				ship.translation.x = -167.071
				ship.translation.y = 32.955
				ship.translation.z = 251.116
				ship.rotation_degrees.x = -17.903
				ship.rotation_degrees.y = 10.021
				ship.rotation_degrees.z = 11.149
				hudStuff.play("FadeOut")
			if (Conductor.song_position >= 44.371875 and songSection == 7): #Back into the ship
				songSection = 8
			if (Conductor.song_position >= 51.75982 and songSection == 8):#Camera change 
				songSection = 9
				earth.visible = false
				ship.translation.x = -145.868
				ship.translation.y = 32.955
				ship.translation.z = 270.154
				ship.rotation_degrees.x = 0
				ship.rotation_degrees.y = 0
				ship.rotation_degrees.z = 0
				updateCam(-145.853, 40.162, 268.57, -90, 0, 0, false, delta)
			if (Conductor.song_position >= 55.455402 and songSection == 9):
				songSection = 10
				updateCam(-148.858, 34.332, 283.449, 0, 0, 0, false, delta)
			if (Conductor.song_position >= 66.501553 and songSection == 10):
				songSection = 11
				far = 740.7
				sun.visible = true
				updateCam(-148.858, 36.098, 267.087, 0, -169.114, 0, false, delta)
			#peak intensity: 66.501553
			match(songSection):
				0:
					translation.x-=(0.01*60)*delta
				1:
					translation.z+=(0.03*60)*delta
					rotation_degrees.y-= (0.1*60)*delta
				2:
					translation.x-=(0.01*60)*delta
				3:
					updateCam(
						translat[0],
						translat[1],
						translat[2],
						rotationDegrees[0],
						rotationDegrees[1],
						rotationDegrees[2],
						true,
						delta
					)
				4:
					hudStuff.play("FadeIn")
					updateCam(-18.654, 12.295, 0.435, -11.47, -90.605, 0.12, true, delta)
				6:
					hudStuff.play("FadeIn")
				7:
					translation.z+=(0.03*60)*delta
					ship.translation.z+=((0.3*60)/6)*delta
				8:
					updateCam(
						translat[0],
						translat[1],
						translat[2],
						rotationDegrees[0],
						rotationDegrees[1],
						rotationDegrees[2],
						false,
						delta
					)
				9:
					translation.z+=(0.01*60)*delta
				10:
					translation.z-=(0.03*60)*delta
					rotation_degrees.y-=(0.08*60)*delta
				11:
					translation.z-=(0.005*60)*delta
				12:
					translation.z-=(0.005*60)*delta
					hud.modulate.a -= (0.02*60)*delta
					blackScreen.modulate.a += (0.02*60)*delta
		else:
			songSection = 0
			waitItOut-= (0.1*60)*delta
	else:
		updateCam(
			translat[0],
			translat[1],
			translat[2],
			rotationDegrees[0],
			rotationDegrees[1],
			rotationDegrees[2],
			false,
			0
		)
	if (Conductor.song_position >= 88.605398):
		translation.z-=(0.005*60)*delta
		hud.modulate.a -= (0.02*60)*delta
		blackScreen.modulate.a += (0.02*60)*delta
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
