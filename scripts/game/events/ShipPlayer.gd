extends Spatial

export var hyperspeed_mode = false

onready var light1 = $OmniLight
onready var light2 = $OmniLight2
onready var fireNormal1 = $Particles
onready var fireNormal2 = $Particles2
onready var warningLight = $WarningLight
onready var hyperspeedLight = $HyperSpeedLight
onready var fireHyper = $ParticlesHyperSpeed
onready var fireHyper2 = $ParticlesHyperSpeed2

var noPower = false

func _ready():
	if (!hyperspeed_mode):
		warningLight.queue_free()
		hyperspeedLight.queue_free()
		fireHyper.queue_free()
		fireHyper2.queue_free()
	else:
		light1.queue_free()
		light2.queue_free()
		fireNormal1.queue_free()
		fireNormal2.queue_free()
		warningLight.visible = true
		hyperspeedLight.visible = true
		fireHyper.visible = true
		fireHyper2.visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (noPower and hyperspeed_mode):
		warningLight.visible = false
		hyperspeedLight.visible = false
		fireHyper.visible = false
		fireHyper2.visible = false
