extends Node2D

var game_scene = load("res://scenes/main_hall.tscn")
@onready var options = $OptionsMenu
@onready var buttons = $Buttons

func _ready() -> void:
	options.visible = false
	buttons.visible = true

func _on_start_game_pressed() -> void:
	get_tree().change_scene_to_packed(game_scene)

func _on_options_pressed() -> void:
	options.visible = true
	buttons.visible = false

func _on_exit_pressed() -> void:
	get_tree().quit()

func _on_back_pressed() -> void:
	_ready()
