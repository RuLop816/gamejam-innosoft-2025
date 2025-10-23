extends Node

var main_hall_scene = load("res://scenes/main_hall.tscn")
var level_one_scene = load("res://scenes/level_one.tscn")
var level_two_scene = load("res://scenes/level_two.tscn")
var level_three_scene = load("res://scenes/level_three.tscn")
var level_four_scene = load("res://scenes/level_four.tscn")
var level_five_scene = load("res://scenes/level_five.tscn")
var level_six_scene = load("res://scenes/level_six.tscn")

signal on_trigger_player_spawn

var spawn_door_tag

func go_to_level(level_tag, destination_tag):
	var scente_to_load
	
	match level_tag:
		"main_hall":
			scente_to_load = main_hall_scene
		"level_one":
			scente_to_load = level_one_scene
		"level_two":
			scente_to_load = level_two_scene
		"level_three":
			scente_to_load = level_three_scene
		"level_four":
			scente_to_load = level_four_scene
		"level_five":
			scente_to_load = level_five_scene
		"level_six":
			scente_to_load = level_six_scene
			
	if scente_to_load != null:
		spawn_door_tag = destination_tag
		get_tree().change_scene_to_packed(scente_to_load)

func trigger_player_spawn(position: Vector2, direction: String):
	on_trigger_player_spawn.emit(position, direction)
