extends Button
export(PackedScene) var Tower
export var TowerName = ""
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var tower = Tower.instance()
	text = TowerName + ": " + str(tower.Price)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
