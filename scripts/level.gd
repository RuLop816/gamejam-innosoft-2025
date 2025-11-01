extends Node2D

var collision
var challenge_scene = load("res://scenes/challenge.tscn")

func _ready():
	if NavigationManager.spawn_door_tag != null:
		_on_level_spawn(NavigationManager.spawn_door_tag)
		
func _physics_process(delta: float):
	collision = GlobalVariables.collider
	
	if(collision != null):
		if(collision.name == "Mauricio" and Input.is_action_just_pressed("Interact")):
			GlobalVariables.boss = "paloma_mauricio"
			GlobalVariables.goal = 50
			get_tree().change_scene_to_packed(challenge_scene)
		
func _on_level_spawn(destination_tag: String):
	var door_path = destination_tag
	var door = get_node(door_path) as Door
	NavigationManager.trigger_player_spawn(door.spawn.global_position, door.spawn_direction)
	$UI/Inventory.update_inventory_ui()
	
	
