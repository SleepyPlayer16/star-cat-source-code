extends Spatial

var timer = 1
var active = false
onready var planet = preload("res://packages/fnf/resources/other/Planet.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (active):
		timer -= delta
		if (timer <= 0):
			timer = 2
			var random = RandomNumberGenerator.new()
			random.randomize()
			var num = random.randi_range(0, 3)
			if ( num == 1 or num == 3):
				createPlanet()

func createPlanet():
	#Make instance
	var planetInstance = planet.instance()
	planetInstance.shouldMove = true
	self.add_child(planetInstance)
