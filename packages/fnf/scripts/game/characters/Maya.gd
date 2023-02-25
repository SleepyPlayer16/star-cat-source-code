extends AnimatedSprite3D

export(String) var idle_anim_name = "default"
export(int) var idle_frequency = 2
export(int) var idle_offset = 0

var anim_timer = 0
var uninterrupted_anim = false

func _ready():
	on_ready()

func on_ready():
	if !Conductor.is_connected("quarter_hit", self, "on_quarter_hit"):
		Conductor.connect("quarter_hit", self, "on_quarter_hit")
#
#func on_update(delta):
#	if anim_timer > 0:
#		anim_timer -= delta * Conductor.pitch_scale
#
#		if anim_timer <= -0.5:
#			_allow_interrupts()
#			idle()

func on_quarter_hit(quarter):
	if idle_frequency > 0 && anim_timer <= 0 && (quarter - idle_offset) % idle_frequency == 0:
		play("default")
		idle()

func idle():
	frame = 0
	play("default")
	scale.x *= -1

func _allow_interrupts():
	uninterrupted_anim = false
