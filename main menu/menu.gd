extends Node2D

onready var HUD = $"Hud/CanvasLayer"


# Called when the node enters the scene tree for the first time.



func _on_StartButton_pressed():
	get_tree().change_scene("res://Final Scene/main location.tscn")
	
func _on_OptionButton_pressed():
	get_tree().change_scene("res://options scene.tscn")
	
func _on_QuitButton_pressed():
	get_tree().quit()


