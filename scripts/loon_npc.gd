extends CharacterBody2D

@onready var textbox = get_node("../TextBox")

func _input(_event: InputEvent) -> void:
	if InteractRange.is_entered:
		if textbox.current_state == textbox.state.ready:
			if Input.is_action_just_pressed("interact"):
				textbox.queue_text("RANDOM LOON: im a loon")
				textbox.queue_text("im not a duck")
				textbox.display_text()
