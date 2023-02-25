extends Spatial

var deathTimer = 4
onready var spr = $Sprite3D
var material : SpatialMaterial = null
var colSet = Color("#ffffff")
var colSet1 = Color("00ff58")
var colSet2 = Color("ffdd00")
var colSet3 = Color("ff73f3")

export var shouldMove = false

# Called when the node enters the scene tree for the first time.
func _ready():
	var random = RandomNumberGenerator.new()
	random.randomize()
	var num = random.randi_range(0, 3)
	match (num):
		0:
			spr.modulate = colSet
		1:
			spr.modulate = colSet1
		2:
			spr.modulate = colSet2
		3:
			spr.modulate = colSet3
	spr.opacity = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (shouldMove):
		if (spr.opacity < 1):
			spr.opacity += (0.05*60)*delta
		translation.z += (0.25*60)*delta
		deathTimer -= delta
		if (deathTimer <= 0):
			queue_free()
