extends CharacterBody2D

# !GLOBAL_VAR_ECTION

@onready var vin_sprite = $AnimatedSprite2D
var speed = 125

var direction_animation = {
	Vector2(0,0): "idle_down",
	Vector2(1,0): "walking_right",
	Vector2(-1,0): "walking_left",
	Vector2(0,1): "walking_down",
	Vector2(0,-1): "walking_Up",
}

# !END_GLOBAL_VAR

func _ready() -> void:
	vin_sprite.play("idle_down")

func sprite_play(sprite: AnimatedSprite2D, animation: String) -> void:
	sprite.play(animation)

func get_movemnts_inp() -> void:
	var direction = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	if Input.is_action_pressed("sprint_btn"):
		self.velocity = direction * (speed * 2)
	else:
		self.velocity = direction * speed

func facing_direction() -> void:
	var direction = Input.get_vector("ui_left","ui_right","ui_up","ui_down")

	match direction:
		Vector2(1,0): sprite_play(vin_sprite, "walking_right")
		Vector2(-1,0): sprite_play(vin_sprite, "walking_left")
		Vector2(0,1): sprite_play(vin_sprite, "walking_down")
		Vector2(0,-1): sprite_play(vin_sprite, "walking_up")
		_:
			match vin_sprite.animation:
				"walking_right": sprite_play(vin_sprite, "idle_right")
				"walking_left": sprite_play(vin_sprite, "idle_left")
				"walking_down": sprite_play(vin_sprite, "idle_down")
				"walking_up": sprite_play(vin_sprite, "idle_up")

	if direction.y < 0: sprite_play(vin_sprite, "walking_up")
	if direction.y > 0: sprite_play(vin_sprite, "walking_down")

func _physics_process(_delta) -> void:
	get_movemnts_inp()
	facing_direction()
	move_and_slide()
