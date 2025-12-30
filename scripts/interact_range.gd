extends Area2D

var is_entered: bool = false


func _on_area_entered(_area: Area2D) -> void:
	InteractRange.is_entered = true
	print("is entered: true")

func _on_area_exited(_area: Area2D) -> void:
	InteractRange.is_entered = false
	print("is entered: false")
