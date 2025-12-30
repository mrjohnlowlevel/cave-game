extends CanvasLayer

const read_rate = 0.05
var tween: Tween = null

enum state {ready, reading, finished}
var current_state = state.ready
var text_queue = []

@onready var textbox_container = $TextBoxContainer
@onready var start = $TextBoxContainer/MarginContainer/HBoxContainer/Start
@onready var end = $TextBoxContainer/MarginContainer/HBoxContainer/End
@onready var label = $TextBoxContainer/MarginContainer/HBoxContainer/Label

func _ready() -> void: #starting dialogue
	print("starting state is ready")
	hide_textbox()
	queue_text("hi hello")
	queue_text("hello hi")
	queue_text("testing testing")

func _process(_delta: float) -> void:
	match current_state:
		state.ready:
			if !text_queue.is_empty():
				display_text()
		state.reading:
			if Input.is_action_just_pressed("ui_accept"):
				label.visible_ratio = 1.0
				tween.kill()
				end.text = "V"
				change_state(state.finished)
		state.finished:
			if Input.is_action_just_pressed("ui_accept"):
				change_state(state.ready)
				hide_textbox()

func hide_textbox():
	start.text = ""
	end.text = ""
	label.text = ""
	textbox_container.hide()

func show_textbox():
	textbox_container.show()

func queue_text(next_text):
	text_queue.push_back(next_text)

func display_text():
	var next_text = text_queue.pop_front()
	label.visible_ratio = 0
	label.text = next_text
	change_state(state.reading)
	show_textbox()
	tween = create_tween()
	tween.tween_property(label,"visible_ratio", 1, len(next_text) * read_rate)
	await tween.finished
	end.text = "V"
	change_state(state.finished)

func change_state(next_state):
	current_state = next_state
	match current_state:
		state.ready:
			print("changing state to ready")
		state.reading:
			print("changing state to reading")
		state.finished:
			print("changing state to finished")
