extends Node2D

@onready var pause_menu = $"vin/Pause Menu"
var paused = false

func _process(_delta):
	if Input.is_action_just_pressed("openclose_pausemenu"):
		pauseMenu()

func pauseMenu():
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		Engine.time_scale = 0
	
	paused = !paused
