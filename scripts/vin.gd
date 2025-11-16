extends CharacterBody2D

@onready var _animated_sprite = $AnimatedSprite2D

var speed = 125

func _ready() -> void:
	_animated_sprite.play("idle_down")

func get_input() -> void:
	var direction = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	self.velocity = direction * speed

func facing_direction() -> void:
	var direction = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	if direction == Vector2(1,0):
		_animated_sprite.play("walking_right")
	elif direction == Vector2(-1,0):
		_animated_sprite.play("walking_left")
	elif direction == Vector2(0,1):
		_animated_sprite.play("walking_down")
	elif  direction == Vector2(0,-1):
		_animated_sprite.play("walking_up")
	elif direction.y > 0:
		_animated_sprite.play("walking_down")
	elif direction.y < 0:
		_animated_sprite.play("walking_up")
	else:
		if _animated_sprite.animation == "walking_right":
			_animated_sprite.play("idle_right")
		elif _animated_sprite.animation == "walking_left":
			_animated_sprite.play("idle_left")
		elif _animated_sprite.animation == "walking_up":
			_animated_sprite.play("idle_up")
		elif _animated_sprite.animation == "walking_down":
			_animated_sprite.play("idle_down")

func _physics_process(_delta) -> void:
	get_input()
	facing_direction()
	move_and_slide()
