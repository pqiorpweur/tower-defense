extends Area2D
export var AttackRange = 999999
export var Price = 100
export var AttackDamage = 50
export var AttackCooldown = 1.0
var in_range = []
var furthestEnemy = null
var on = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$AttackTimer.wait_time = AttackCooldown
	$AttackTimer.start()
	var imgsize = $RangeIndicator.get_texture().get_size()
	print(imgsize)
	var wantedsize = AttackRange*2
	var xscale = (1/scale.x)*wantedsize/imgsize.x
	var yscale = (1/scale.y)*wantedsize/imgsize.y
	$RangeIndicator.scale = Vector2(xscale, yscale)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not on:
		return
	$RangeIndicator.visible = false
	var enemies = get_tree().get_nodes_in_group("Enemy")
	in_range = []
	var furthest = 0
	furthestEnemy = null
	for enemy in enemies:
		var xdistance = abs(enemy.position.x - position.x)
		var ydistance = abs(enemy.position.y - position.y)
		var distance = sqrt(pow(xdistance, 2) + pow(ydistance, 2))
		if distance <= AttackRange:
			in_range.append(enemy)
			if enemy.offset>furthest:
				furthest = enemy.offset
				furthestEnemy = enemy
	if furthestEnemy != null:
		var angle = position.angle_to_point(furthestEnemy.position)
		if abs(angle - rotation) < 0.05:
			rotation = angle
		else:
			var max_angle = PI*2
			var difference = fmod(angle-rotation, max_angle)
			var result = fmod(2*difference, max_angle) - difference
			rotation += result*0.05
			pass
#		elif angle > rotation:
#			rotation += 0.05
#		elif angle < rotation:
#			rotation -= 0.05


func _on_AttackTimer_timeout():
	if furthestEnemy != null:
		furthestEnemy.damaged(AttackDamage)
