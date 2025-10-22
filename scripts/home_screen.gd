extends Node2D

var game_scene = load("res://scenes/main_hall.tscn")

func _on_play_pressed() -> void:
	get_tree().change_scene_to_packed(game_scene)

func _on_quit_pressed() -> void:
	get_tree().quit()
