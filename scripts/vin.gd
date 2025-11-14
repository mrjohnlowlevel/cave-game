extends CharacterBody2D

@export var speed: int = 200

func get_input() -> void:
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	self.velocity = input_direction * speed

func _physics_process(_delta) -> void:
	get_input()
	move_and_slide()
