extends Node

export(NodePath) var progress_bar_path

onready var altLoad = preload("res://assets/graphics/menus/loading_screens/loadingBG2.png")
var rng = RandomNumberGenerator.new()

onready var progress_bar = get_node_or_null(progress_bar_path)

func _ready():
	rng.randomize()
	var my_random_number = rng.randi_range(0, 1)
	if (my_random_number == 0):
		pass
	else:
		$Funkay.texture = altLoad

func update_progress(progress_val):
	if progress_bar:
		progress_bar.value = progress_val
