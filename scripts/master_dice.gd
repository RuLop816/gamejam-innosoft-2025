extends Node2D

var collision
var inventory_dices
var faces
var m_dice_blocked

const MASTER_DICE = preload("uid://3p8n55blgko8")
const MASTER_DICE_RIGHT_NUMBER = preload("uid://u26uecg08k2p")


func _physics_process(delta: float):
	collision = GlobalVariables.collider
	inventory_dices = GlobalVariables.dices_in_inventory
	m_dice_blocked = GlobalVariables.master_dice_blocked
	faces = GlobalVariables.dice_faces
	
	if(collision != null):
		if(collision.name == "MasterDice" and Input.is_action_just_pressed("Interact") and m_dice_blocked == false):
			roll_dice()
			
func roll_dice():
	var dice_result
	
	dice_result = faces.pick_random()
			
	result(dice_result)
			
	
func result(result):
	print(faces)
	print("Has sacado un ", result)
	if(result != GlobalVariables.level_number):
		choose_lost_dice()
		GlobalVariables.dice_faces.erase(result)
	elif(result == GlobalVariables.level_number):
		DialogueManager.show_dialogue_balloon(MASTER_DICE_RIGHT_NUMBER)
		GlobalVariables.master_dice_blocked = true
		match GlobalVariables.level_number:
			1: 
				GlobalVariables.level_one_blocked = false
			2: 
				GlobalVariables.level_two_blocked = false
			3:
				GlobalVariables.level_three_blocked = false
			4:
				GlobalVariables.level_four_blocked = false
			5:
				GlobalVariables.level_five_blocked = false
			6: 
				GlobalVariables.level_six_blocked = false
		next_level(GlobalVariables.level_number)
	
func next_level(level):
	GlobalVariables.dice_faces = []
	if(level != 6):
		GlobalVariables.level_number = GlobalVariables.level_number + 1
		for x in level+1:
			GlobalVariables.dice_faces.append(x+1)
	print(GlobalVariables.dice_faces)
		
func choose_lost_dice():
	get_parent().get_node("UI").get_node("Inventory").choose_lost_dice()
	
	
