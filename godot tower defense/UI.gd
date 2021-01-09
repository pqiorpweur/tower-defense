extends Control
signal TowerCreate1
signal TowerCreate2
signal TowerCreate3
signal TowerCreate4
signal NextWave
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func setMoney(num):
	$moneyDisplay.text = " money: " + str(num)
	
func setHealth(num):
	$healthDisplay.text = " health: " + str(num)


func _on_Tower1Button_pressed():
	emit_signal("TowerCreate1")


func _on_Tower2Button_pressed():
	emit_signal("TowerCreate2")


func _on_Tower3Button_pressed():
	emit_signal("TowerCreate3")


func _on_Tower4Button_pressed():
	emit_signal("TowerCreate4")


func _on_NextWaveButton_pressed():
	emit_signal("NextWave")
