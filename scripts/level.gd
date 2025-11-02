extends Node2D

var collision
var challenge_scene = load("res://scenes/challenge.tscn")
var b_defeated
var rew_not_obtained 
var special_dices
var special_dice_obtained

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
	
func _on_tree_entered() -> void:
	var level_num = get_node(".").name
	match level_num:
		"level_one":
			get_reward(1)
		"level_two":
			get_reward(2)
		"level_three":
			get_reward(3)

func get_reward(lvl_num):
	if (GlobalVariables.boss_defeated[lvl_num] == true and GlobalVariables.reward_not_obtained[lvl_num] == true):
		special_dice_obtained = GlobalVariables.special_dices_available.pick_random()
		$UI/Inventory.add_dice(special_dice_obtained)
		GlobalVariables.special_dices_available.erase(special_dice_obtained)
		GlobalVariables.reward_not_obtained[lvl_num] = false
