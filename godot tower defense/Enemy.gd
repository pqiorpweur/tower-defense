extends PathFollow2D
export var health = 100
export var speed = 100
export var value = 100
export var damage = 100
signal moneySignal
signal takeDamage


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var main = get_parent().get_parent()

	loop = false
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var previous = offset
	offset+=speed*delta
#	print(previous, " ", offset, " ", delta)
	if offset == previous and delta != 0:
		emit_signal("takeDamage", damage)
		queue_free()
	$Particles2D.global_rotation = 0


func damaged(amount):
	health -= amount
	$Particles2D.restart()
	if(health<=0):
		emit_signal("moneySignal", value)
		queue_free()
