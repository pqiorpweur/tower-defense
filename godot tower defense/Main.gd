# To do list
# Bug spawn with -100 health
#feature more waves
#feature wave start button
#feature sell tower
#upgrade tower
extends Node
export(PackedScene) var Tower
export(PackedScene) var Tower2
export(PackedScene) var Tower3
export(PackedScene) var Tower4
export(PackedScene) var Wave1
export(PackedScene) var Wave2
export var minDistanceTower = 0
export var minDistancePath = 0
export var money = 0
export var health = 100
var rng = RandomNumberGenerator.new()
var tower
var tower2
var tower3
var tower4

var towerList = []
var placing = false
var toPlace = null
var pathList = []
var waveList = []

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$UI/moneyDisplay.text = str(money)
	tower = Tower.instance()
	tower2 = Tower2.instance()
	tower3 = Tower3.instance()
	tower4 = Tower4.instance()
	var pathFollower = PathFollow2D.new()
	$enemyPath.add_child(pathFollower)
	var oldProg = 0
	while pathFollower.offset >= oldProg:
		oldProg = pathFollower.offset
		pathFollower.offset += 20
		var marker = Node2D.new()
		add_child(marker)
		marker.global_transform.origin = pathFollower.global_transform.origin
		pathList.append(marker)
	$enemyPath.remove_child(pathFollower)
	pathFollower.queue_free()
	waveList = [Wave1, Wave2]
	loadWave(waveList.pop_front())
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$UI.setMoney(money)
	$UI.setHealth(health)
	if toPlace != null:
		toPlace.position = get_viewport().get_mouse_position()
	

func _input(event):
	if event is InputEventMouseButton:
		if placing:
			for oldTower in towerList:
				var distance = sqrt(pow(oldTower.position.x-event.position.x, 2)+pow(oldTower.position.y-event.position.y, 2))
				if distance < minDistanceTower:
					return
			for marker in pathList:
				var distance = sqrt(pow(marker.position.x-event.position.x, 2)+pow(marker.position.y-event.position.y, 2))
				if distance < minDistancePath:
					return
			var newTower = toPlace
			towerList.append(newTower)
			toPlace = null
			newTower.position = event.position
			money -= newTower.Price
			placing = false
			newTower.on = true


	
func enemyDied(value):
	money+=value

func enemyDamage(value):
	health-=value
	
func _on_UI_TowerCreate1():
	if money >= tower.Price and toPlace == null:
		placing = true
		toPlace = Tower.instance()
		add_child(toPlace)


func _on_UI_TowerCreate2():
	if money >= tower2.Price and toPlace == null:
		placing = true
		toPlace = Tower2.instance()
		add_child(toPlace)


func _on_UI_TowerCreate3():
	if money >= tower3.Price and toPlace == null:
		placing = true
		toPlace = Tower3.instance()
		add_child(toPlace)

func _on_UI_TowerCreate4():
	if money >= tower4.Price and toPlace == null:
		placing = true
		toPlace = Tower4.instance()
		add_child(toPlace)

func loadWave(WaveScene):
	var ws = WaveScene.instance()
	for enemy in ws.get_children():
		ws.remove_child(enemy)
		$enemyPath.add_child(enemy)
		enemy.connect("moneySignal", self, "enemyDied")
		enemy.connect("takeDamage", self, "enemyDamage")
	ws.queue_free()


func _on_UI_NextWave():
	if waveList.size()>0 and $enemyPath.get_children().size()==0:
		loadWave(waveList.pop_front())
