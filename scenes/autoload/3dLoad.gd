extends Spatial


var timer = 1


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if timer > 0:
		timer -= delta
	if timer <= 0:
		get_tree().change_scene("res://scenes/shared/menus/DescriptionLoader.tscn")
