extends Camera


var translat = [15.01, -4.019, 0.435]#x, y, z
var rotationDegrees = [0, -90.593, 0]
var songSection = 0
var waitItOut = 0.5
var fovQuantity = 0.01
var shadersDisabled = false
var playFinalTransition = true
var performanceModeActive = false
var updPerformancePositions = false

onready var hudStuff = get_parent().get_node("HUDPackage2D/ColorRect/AnimationPlayer")
onready var hud = get_parent().get_node("HUDPackage2D/HUD/Visible_Elements")
onready var ship = get_parent().get_node("ship")
onready var songCredits = get_parent().get_node("AuthorLayer/ColorRect2")
onready var bar1 = get_parent().get_node("CanvasLayer/BlackBar")
onready var bar2 = get_parent().get_node("CanvasLayer/BlackBar2")
onready var whiteScreen = get_parent().get_node("CanvasLayer2/whiteScreen")
onready var canvas2 = get_parent().get_node("CanvasLayer2")
onready var anita = get_parent().get_node("Anita")
onready var bf = get_parent().get_node("Boyfriend")
onready var gf = get_parent().get_node("Girlfriend")

onready var generatior1 = get_parent().get_node("Generator")
onready var generatior2 = get_parent().get_node("Generator2")
onready var generatior3 = get_parent().get_node("Generator3")
onready var generatior4 = get_parent().get_node("Generator4")
onready var generatior5 = get_parent().get_node("Generator5")
onready var generatior6 = get_parent().get_node("Generator6")
onready var blackScreen = get_parent().get_node("TransLayer/ColorRect")

onready var cylinderSpace = get_parent().get_node("spaceCylinder")

# Called when the node enters the scene tree for the first time.
func _ready():
	if (UserData.get_setting("shaders", 0, "video")) == 1:
		get_parent().get_node("CanvasLayer/ColorRect").queue_free()
		shadersDisabled = true
	else:
		songCredits.get_parent().layer = 0
	if (UserData.get_setting("background_events", 0, "video")) == 1:
		performanceModeActive = true
	else:
		pass
	songCredits.holdIt = true
	whiteScreen.modulate.a = 0
	waitItOut = 0.5
	songSection = 0
	Conductor.song_position = 0
	updateCam(-290.24, 118.702, 4.955, 0, 0, 0, false, 0)

func _physics_process(delta):
#	if (Input.is_action_just_pressed("skipBackward")):
#		Conductor.song_position -= 1
#		Conductor.play(Conductor.song_position)
#		Conductor.vocals.play(Conductor.song_position)
#	if (Input.is_action_just_pressed("skipForward")):
#		Conductor.song_position += 5
#		Conductor.play(Conductor.song_position)
#		Conductor.vocals.play(Conductor.song_position)
	#blackBars disappear at : 9.004514
	if (Conductor.song_position <= 7.926173):
		hud.modulate.a = 0
		if songCredits != null:
			songCredits.modulate.a = 0
			songCredits.startCountdown = false
	else:
		if (hud.modulate.a < 1):
			if (bar1.modulate.a > 0 or bar2.modulate.a > 0):
				bar1.modulate.a -= (0.02*60)*delta
				bar2.modulate.a -= (0.02*60)*delta
			else:
				bar1.queue_free()
				bar2.queue_free()
			hud.modulate.a += (0.02*60)*delta
			songCredits.modulate.a = hud.modulate.a
			songCredits.holdIt = false
			songCredits.startCountdown = true
	#NextCamChange = 61.893301
	#NextAfter = 81.048612
	if (!performanceModeActive):
		if (waitItOut <= 0):
			if (Conductor.song_position >= 18.046573 and songSection == 0):
				if (Conductor.counting_down == false):
					updateCam(-293.182, 117.219, 7.902, 0,160.393, 0, false, 0)
					songSection = 1
			#caqmera looks at bf
			if (Conductor.song_position >= 22.332113 and songSection == 1):
				updateCam(-293.286, 117.194, 7.737, 0, 106.837, 0, false, 0)
				songSection = 2
			#tururu, turururururu tuuu ru ruru tuuu ru ruru
			if (Conductor.song_position >= 27.066258 and songSection == 2):
				updateCam(-290.107, 119.808, 5.651, -39, 104.614, 0, false, 0)
				songSection = 3
			if (Conductor.song_position >= 45.038842 and songSection == 3):
				songSection = 4
				updateCam(-292.817, 117.095, 8.275, 3.357, 100.814, -5.317, false, 0)
				anita.translation.x = -293.366
				anita.translation.y = 117.125
				anita.translation.z = 8.453
				anita.rotation_degrees.y = 95.114
			if (Conductor.song_position >= 53.997779 and songSection == 4):
				songSection = 5
				updateCam(-293.364, 117.272, 2.294, 0, -180, 0, false, 0)
			if (Conductor.song_position >= 63.016436 and songSection == 5):
				songSection = 6
				generatior1.active = true
				generatior2.active = true
				generatior3.active = true
				generatior4.active = true
				generatior5.active = true
				generatior6.active = true
				fov = 70
				updateCam(-290.24, 118.702, 6.955, 0, 0, 0, false, 0)
			#Inside ship
			if (Conductor.song_position >= 81.048612 and songSection == 6):
				songSection = 7
				
				updateCam(-293.364, 117.272, 8.916, 0, 0, 0, false, 0)
				anita.translation.x = -293.618
				anita.translation.y = 117.118
				anita.translation.z = 8.218
				anita.rotation_degrees.y = 180
				anita.render_priority = 1
				anita.flip_h = true
				
				bf.translation.x = -293.239
				bf.translation.y = 116.836
				bf.translation.z = 8.193
				bf.rotation_degrees.y = -4.742
				bf.render_priority = 1
				
				gf.translation.x = -294.198
				gf.translation.y = 116.864
				gf.translation.z = 8.729
				gf.rotation_degrees.y = 90
				gf.render_priority = 1
				
			if (Conductor.song_position >= 97.935879 and Conductor.song_position < 99.01792):
				if (whiteScreen.modulate.a < 1):
					canvas2.layer = -4
					whiteScreen.modulate.a += (0.05*60)*delta
			if (Conductor.song_position >= 99.01792 and songSection == 7):
				cylinderSpace.visible = false
				far = 1352.6
				updateCam(-290.24, 118.702, 19.478, 0, 0, 0, false, 0)
				songSection = 8
			if (Conductor.song_position >= 117.13854 and songSection == 8):
				songSection = 9
			match(songSection):
				0:
					if blackScreen.modulate.a > 0:
						blackScreen.modulate.a -= (0.02*60)*delta
					#song begins
					translation.z+=(0.01*60)*delta
				1:
					rotation_degrees.y -= (0.08*60)*delta
					translation.x+=(0.001*60)*delta
				2: 
					#camera looks at bf
					rotation_degrees.y += (0.2*60)*delta
					translation.z -= (0.003*60)*delta
					
				3:
					translation.z+=(0.01*60)*delta
				4:
					#camera changes to anita
					translation.z -= (0.003*60)*delta
				5:
					#camera in front of ship
					fovQuantity += ((0.005*delta)/8)*60
					fov += (fovQuantity*60)*delta
				6:
					translation.z+=(0.01*60)*delta
				7: #inside Ship
					translation.z-=(0.0005*60)*delta
				8: 
					translation.z+=(0.01*60)*delta
					if (whiteScreen.modulate.a > 0):
						whiteScreen.modulate.a -= (0.05*60)*delta
				9:
					blackScreen.modulate.a += (0.02*60)*delta
		else:
			songSection = 0 
			waitItOut-= (0.1*60)*delta
	else:
		if (Conductor.song_position >= 117.13854):
			if blackScreen.modulate.a < 1:
				blackScreen.modulate.a += (0.02*60)*delta
		else:
			if blackScreen.modulate.a > 0:
				blackScreen.modulate.a -= (0.02*60)*delta
		if (!updPerformancePositions):
			updPerformancePositions = true
			updateCam(-293.364, 117.272, 8.916, 0, 0, 0, false, 0)
			anita.translation.x = -293.618
			anita.translation.y = 117.118
			anita.translation.z = 8.218
			anita.rotation_degrees.y = 180
			anita.render_priority = 1
			anita.flip_h = true
			
			bf.translation.x = -293.239
			bf.translation.y = 116.836
			bf.translation.z = 8.193
			bf.rotation_degrees.y = -4.742
			bf.render_priority = 1
			
			gf.translation.x = -294.198
			gf.translation.y = 116.864
			gf.translation.z = 8.729
			gf.rotation_degrees.y = 90
			gf.render_priority = 1
		
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
