extends CharacterBody2D

# !GLOBAL_VAR_SECTION
@onready var interact_area = $InteractRange
@onready var vin_sprite = $AnimatedSprite2D
var speed = 125

var movement_state = {
	"moving": 0, # true
	"sprinting": 1, # false
	"in_text": 0xF1FA # custom state
}

# !END_GLOBAL_VAR

func _ready() -> void:
	vin_sprite.play("idle_down")

func sprite_play(sprite: AnimatedSprite2D, animation: String) -> void:
	sprite.play(animation)

func play_idle(sprite: AnimatedSprite2D) -> String:
	match vin_sprite.animation:

		"walking_right", "sprint_right": 
			sprite_play(sprite, "idle_right")
			return "idle_right"

		"walking_left", "sprint_left": 
			sprite_play(sprite, "idle_left")
			return "idle_left"

		"walking_down", "sprint_down": 
			sprite_play(sprite, "idle_down")
			return "idle_down"

		"walking_up", "sprint_up": 
			sprite_play(sprite, "idle_up")
			return "idle_up"
	return "idle_down"

func get_movemnts_inp(usr_direction: Vector2, in_text: bool) -> int:
	if in_text:
		if Input.is_action_pressed("sprint_btn"):
			self.velocity = usr_direction * (speed * 1.5)
			return movement_state["sprinting"]
		else:
			self.velocity = usr_direction * speed
			return movement_state["moving"]
	else:
		return movement_state["in_text"]

func stop_movemnts(direction: String) -> void:
	sprite_play(vin_sprite, direction)
	self.velocity = Vector2(0, 0)

func facing_direction(usr_direction: Vector2, is_sprint: bool) -> String:
	if usr_direction != Vector2.ZERO:
		if abs(usr_direction.x) > abs(usr_direction.y):
			if is_sprint:

				if usr_direction.x > 0:
					sprite_play(vin_sprite, "sprint_right")
					return "sprint_right"
				else:
					sprite_play(vin_sprite, "sprint_left")
					return "sprint_left"
					
			else:

				if usr_direction.x > 0:
					sprite_play(vin_sprite, "walking_right")
					return "walking_right"
				else:
					sprite_play(vin_sprite,"walking_left")
					return "walking_left"

		else:
			if is_sprint:

				if usr_direction.y > 0:
					sprite_play(vin_sprite, "sprint_down")
					return "sprint_down"
				else:
					sprite_play(vin_sprite, "sprint_up")
					return "sprint_up"

			else:

				if usr_direction.y > 0:
					sprite_play(vin_sprite, "walking_down")
					return "walking_down"
				else:
					sprite_play(vin_sprite, "walking_up")
					return "walking_up"
				
	else:
		var idle_dir = play_idle(vin_sprite)
		return idle_dir

func update_interact_area(dir: Vector2, offset = 27): #make the interact_area follow the player's direction
	var direction = dir
	if direction.x != 0 and direction.y != 0: #make the interact_area not go diagonal
		direction.x = 0
		direction.y = direction.y / abs(direction.y)
	if dir != Vector2.ZERO: #moves the interact_area
		interact_area.position = direction * offset

func _physics_process(_delta) -> void:
	var is_in_text = false
	var is_sprint = false

	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	is_sprint = get_movemnts_inp(direction, is_in_text)
	var sprite_dir = facing_direction(direction, is_sprint)

	if is_sprint == movement_state["in_text"]:
		stop_movemnts(sprite_dir)
	else:
		update_interact_area(direction)
		move_and_slide()
