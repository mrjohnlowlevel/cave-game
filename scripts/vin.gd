extends CharacterBody2D

# !GLOBAL_VAR_ECTION

@onready var vin_sprite = $AnimatedSprite2D
@onready var dbg_lbl = $Label
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
	dbg_lbl.text = "Vec2(%d,%d)" % [direction.x, direction.y]

	match direction:
		Vector2(1, 0): sprite_play(vin_sprite, "walking_right")
		Vector2(-1, 0): sprite_play(vin_sprite, "walking_left")
		Vector2(0, 1): sprite_play(vin_sprite, "walking_down")
		Vector2(0, -1): sprite_play(vin_sprite, "walking_up")
		_:
			play_idle(vin_sprite)

func _physics_process(_delta) -> void:
	get_movemnts_inp()
	facing_direction()
	move_and_slide()
