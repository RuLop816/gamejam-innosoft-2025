extends Node

var main_hall_scene = load("res://scenes/main_hall.tscn")
var level_one_scene = load("res://scenes/level_one.tscn")

signal on_trigger_player_spawn

var spawn_door_tag

func go_to_level(level_tag, destination_tag):
	var scente_to_load
	
	match level_tag:
		"main_hall":
			scente_to_load = main_hall_scene
		"level_one":
			scente_to_load = level_one_scene
			
	if scente_to_load != null:
		spawn_door_tag = destination_tag
		get_tree().change_scene_to_packed(scente_to_load)

func trigger_player_spawn(position: Vector2, direction: String):
	on_trigger_player_spawn.emit(position, direction)
