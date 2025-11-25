extends CharacterBody2D

@onready var vin_sprite = $AnimatedSprite2D

var speed = 125

func _ready() -> void:
	vin_sprite.play("idle_down")

func get_movemnts_inp() -> void:
	var direction = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	if Input.is_action_pressed("sprint_btn"):
		self.velocity = direction * (speed * 2)
	else:
		self.velocity = direction * speed

func facing_direction() -> void:
	var direction = Input.get_vector("ui_left","ui_right","ui_up","ui_down")

	if direction == Vector2(1,0):
		vin_sprite.play("walking_right")

	elif direction == Vector2(-1,0):
		vin_sprite.play("walking_left")

	elif direction == Vector2(0,1):
		vin_sprite.play("walking_down")

	elif  direction == Vector2(0,-1):
		vin_sprite.play("walking_up")

	# Diagonal check
	elif direction.y > 0:
		vin_sprite.play("walking_down")

	elif direction.y < 0:
		vin_sprite.play("walking_up")

	else:
		# Idle anim block check
		if vin_sprite.animation == "walking_right":
			vin_sprite.play("idle_right")
		elif vin_sprite.animation == "walking_left":
			vin_sprite.play("idle_left")
		elif vin_sprite.animation == "walking_up":
			vin_sprite.play("idle_up")
		elif vin_sprite.animation == "walking_down":
			vin_sprite.play("idle_down")

func _physics_process(_delta) -> void:
	get_movemnts_inp()
	facing_direction()
	move_and_slide()
