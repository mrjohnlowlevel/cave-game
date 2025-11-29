extends CharacterBody2D

# !GLOBAL_VAR_SECTION

@onready var vin_sprite = $AnimatedSprite2D
var speed = 125

# !END_GLOBAL_VAR

func _ready() -> void:
	vin_sprite.play("idle_down")

func sprite_play(sprite: AnimatedSprite2D, animation: String) -> void:
	sprite.play(animation)

func play_idle(sprite: AnimatedSprite2D) -> void:
	match vin_sprite.animation:
		"walking_right", "sprint_right": sprite_play(sprite, "idle_right")
		"walking_left", "sprint_left": sprite_play(sprite, "idle_left")
		"walking_down", "sprint_down": sprite_play(sprite, "idle_down")
		"walking_up", "sprint_up": sprite_play(sprite, "idle_up")

func get_movemnts_inp(usr_direction: Vector2) -> bool:
	if Input.is_action_pressed("sprint_btn"):
		self.velocity = usr_direction * (speed * 1.5)
		return true
	else:
		self.velocity = usr_direction * speed
		return false

func facing_direction(usr_direction: Vector2, is_sprint: bool) -> void:
	if usr_direction != Vector2.ZERO:
		if abs(usr_direction.x) > abs(usr_direction.y):
			if is_sprint:
				sprite_play(vin_sprite, "sprint_right" if usr_direction.x > 0 else "sprint_left")
			else:
				sprite_play(vin_sprite, "walking_right" if usr_direction.x > 0 else "walking_left")
		else:
			if is_sprint:
				sprite_play(vin_sprite, "sprint_down" if usr_direction.y > 0 else "sprint_up")
			else:
				sprite_play(vin_sprite, "walking_down" if usr_direction.y > 0 else "walking_up")
	else:
		play_idle(vin_sprite)

func _physics_process(_delta) -> void:
	var is_sprint = false
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()

	is_sprint = get_movemnts_inp(direction)
	facing_direction(direction, is_sprint)
	move_and_slide()
