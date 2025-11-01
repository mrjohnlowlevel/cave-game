extends CharacterBody2D

func _process(_delta: float) -> void:
    if Input.is_action_pressed("move_left"):
        print("Test: left")
    
    if Input.is_action_pressed("move_right"):
        print("Test: right")
    
    if Input.is_action_pressed("move_up"):
        print("Test: Up")
    
    if Input.is_action_pressed("move_down"):
        print("Test: down")