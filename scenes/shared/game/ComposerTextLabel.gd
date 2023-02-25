extends ColorRect

export var composers = ''
export var songName = ''

onready var lbl = $RichTextLabel

var timer = 3
var initialPos
var startCountdown = true
var holdIt = false

func _ready():
	initialPos = rect_position.x
	modulate.a = 0
	lbl.text = songName + '\n' + composers
	
func _process(delta):
	lbl.text = songName + '\n' + composers
	if (Conductor.playing):
		if (!holdIt):
			if modulate.a < 1:
				modulate.a += (0.05*60)*delta
			if (startCountdown):
				if timer <= 0:
					rect_position.x = lerp(
						rect_position.x,
						initialPos-500,
						(0.1*60)*delta
					)
				if timer <= -1:
					queue_free()
				else:
					timer-=delta
