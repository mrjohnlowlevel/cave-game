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
		"walking_right": sprite_play(sprite, "idle_right")
		"walking_left": sprite_play(sprite, "idle_left")
		"walking_down": sprite_play(sprite, "idle_down")
		"walking_up": sprite_play(sprite, "idle_up")

func get_movemnts_inp() -> void:
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down").normalized()
	if Input.is_action_pressed("sprint_btn"):
		self.velocity = direction * (speed * 2)
	else:
		self.velocity = direction * speed

func facing_direction() -> void:
	var direction := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down").normalized()

	if direction != Vector2.ZERO:
		if abs(direction.x) > abs(direction.y):
			sprite_play(vin_sprite, "walking_right" if direction.x > 0 else "walking_left")
		else:
			sprite_play(vin_sprite, "walking_down" if direction.y > 0 else "walking_up")
	else:
		play_idle(vin_sprite)

func _physics_process(_delta) -> void:
	get_movemnts_inp()
	facing_direction()
	move_and_slide()
