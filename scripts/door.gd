extends Area2D

class_name Door

@export var destination_level_tag: String
@export var destination_door_tag: String
@export var spawn_direction = "up"

@onready var spawn = $Spawn

var lvl_one_blocked
var lvl_two_blocked
var lvl_three_blocked
var lvl_four_blocked
var lvl_five_blocked
var lvl_six_blocked
var current_level 
var lvl_is_blocked

func _process(delta: float):
	lvl_one_blocked = GlobalVariables.level_one_blocked
	lvl_two_blocked = GlobalVariables.level_two_blocked
	lvl_three_blocked = GlobalVariables.level_three_blocked
	lvl_four_blocked = GlobalVariables.level_four_blocked
	lvl_five_blocked = GlobalVariables.level_five_blocked
	lvl_six_blocked = GlobalVariables.level_six_blocked
	current_level = GlobalVariables.level_number
	
func change_level():
	match destination_level_tag:
		"level_one":
			lvl_is_blocked = lvl_one_blocked
		"level_two":
			lvl_is_blocked = lvl_two_blocked
		"level_three":
			lvl_is_blocked = lvl_three_blocked
		"level_four":
			lvl_is_blocked = lvl_four_blocked
		"level_five":
			lvl_is_blocked = lvl_five_blocked
		"level_six":
			lvl_is_blocked = lvl_six_blocked

func _on_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	change_level()
	if body is Player and (lvl_is_blocked == false or destination_level_tag == "main_hall"):
		NavigationManager.go_to_level(destination_level_tag, destination_door_tag)
