extends Node2D

const INTRODUCTION_DIALOGUE = preload("uid://cqgfa3jggg1fa")

func _ready():
	if NavigationManager.spawn_door_tag != null:
		_on_level_spawn(NavigationManager.spawn_door_tag)
	if GlobalVariables.introduction_dialogue_red == false:
		DialogueManager.show_dialogue_balloon(INTRODUCTION_DIALOGUE)
		GlobalVariables.introduction_dialogue_red = true
		
func _on_level_spawn(destination_tag: String):
	var door_path = destination_tag
	var door = get_node(door_path) as Door
	NavigationManager.trigger_player_spawn(door.spawn.global_position, door.spawn_direction)
	$UI/Inventory.update_inventory_ui()
