extends Node2D

var goal
var rival
var player_points = 0
var rival_points = 0
var d_in_hand
var player_roll_result
var rival_roll_result
var lvl_one_scene = load("res://scenes/level_one.tscn")
var lvl_two_scene = load("res://scenes/level_two.tscn")
var lvl_three_scene = load("res://scenes/level_three.tscn")
var rival_burning_damage = 0
var rival_frozen = 0
var insta_death = false
var insta_death_result
var multiplier_result
var turn_result = 0

signal continue_pressed
signal multiplier_dice_rolled

func _ready():
	$UI/Inventory.update_inventory_ui()
	$GoalBoard/GoalScore.text = str(GlobalVariables.goal)
	start_turn()
	
func _process(delta: float):
	d_in_hand = GlobalVariables.dices_in_hand
	goal = GlobalVariables.goal
	rival = GlobalVariables.boss
	player_roll_dices()
	
func start_turn():
	$UI/Inventory.open_inventory()
	GlobalVariables.ui_blocked = true
	GlobalVariables.inventory_action = "choose dices"
	multiplier_result = 1
	turn_result = 0
	
func player_roll_dices():
	if(GlobalVariables.accepted_pressed == true):
		GlobalVariables.accepted_pressed = false
		for d in d_in_hand:
			match d:
				"dice_one":
					print("rival frozen es: ", rival_frozen)
					player_roll_result = randi_range(1, 6)
					turn_result += player_roll_result
					player_points += player_roll_result
					show_dice_result(player_roll_result, $PlayerBoard/DiceOne, "normal")
				"dice_two":
					player_roll_result = randi_range(1, 6)
					turn_result += player_roll_result
					player_points += player_roll_result
					show_dice_result(player_roll_result, $PlayerBoard/DiceTwo, "normal")
				"dice_three":
					player_roll_result = randi_range(1, 6)
					turn_result += player_roll_result
					player_points += player_roll_result
					show_dice_result(player_roll_result, $PlayerBoard/DiceThree, "normal")
				"dice_four":
					player_roll_result = randi_range(1, 6)
					turn_result += player_roll_result
					player_points += player_roll_result
					show_dice_result(player_roll_result, $PlayerBoard/DiceFour, "normal")
				"dice_five":
					player_roll_result = randi_range(1, 6)
					turn_result += player_roll_result
					player_points += player_roll_result
					show_dice_result(player_roll_result, $PlayerBoard/DiceFive, "normal")
				"dice_six":
					player_roll_result = randi_range(1, 6)
					turn_result += player_roll_result
					player_points += player_roll_result
					show_dice_result(player_roll_result, $PlayerBoard/DiceSix, "normal")
				"burnt_dice":
					GlobalVariables.rival_burning_time = randi_range(1, 4)
					rival_burning_damage = GlobalVariables.rival_burning_time
					show_dice_result(rival_burning_damage, $PlayerBoard/DiceSix, "burnt_dice")
				"insta_death_dice":
					insta_death_result = randi_range(1, 50)
					if(insta_death_result <= 49):
						insta_death = false
					elif(insta_death_result == 50):
						insta_death = true
					is_insta_death()
					show_dice_result(insta_death, $PlayerBoard/DiceSix, "insta_death_dice")
					
		print("Tu puntuación este turno es: ", player_points)
		$PlayerBoard/Scoreboard/PlayerScore.text = str(player_points)
		multiply_result(rival)
	
func rival_roll_dices(challenge_rival):
	match challenge_rival:
		"paloma_mauricio":
			rival_roll_result = randi_range(1, 6)
			rival_points += rival_roll_result
			show_dice_result(rival_roll_result, $RivalBoard/DiceOne, "normal")
			rival_roll_result = randi_range(1, 6)
			rival_points += rival_roll_result
			show_dice_result(rival_roll_result, $RivalBoard/DiceTwo, "normal")
			rival_roll_result = randi_range(1, 6)
			rival_points += rival_roll_result
			show_dice_result(rival_roll_result, $RivalBoard/DiceThree, "normal")
			rival_roll_result = randi_range(1, 6)
			rival_points += rival_roll_result
			show_dice_result(rival_roll_result, $RivalBoard/DiceFour, "normal")
			show_dice_result(null, $RivalBoard/DiceFive, "normal")
			show_dice_result(null, $RivalBoard/DiceSix, "normal")
			burn_rival()
		"crystall_ball":
			rival_points += randi_range(3, 6)
			rival_points += randi_range(3, 6)
			rival_points += randi_range(3, 6)
			rival_points += randi_range(3, 6)
			rival_points += randi_range(3, 6)
			burn_rival()
		"invisibility_cloak":
			rival_points += randi_range(1, 6)
			rival_points += randi_range(1, 6)
			rival_points += randi_range(1, 6)
			rival_points += randi_range(1, 6)
			rival_points += randi_range(1, 6)
			rival_points += randi_range(1, 6)
			burn_rival()
	print("La puntuación de tu rival este turno es: ", rival_points)
	$RivalBoard/Scoreboard/RivalScore.text = str(rival_points)
	await continue_pressed
	end_turn()
	
func end_turn():
	reset_inventory_in_challenge()
	if(player_points >= goal and rival_points >= goal):
		if(player_points > rival_points):
			win_boss()
		elif(player_points == rival_points):
			start_turn()
		else:
			print("Unlucky, has perdido")
	elif(player_points >= goal):
		win_boss()
	elif(rival_points >= goal):
		print("Unlucky, has perdido")
	else:
		start_turn()
		
func reset_inventory_in_challenge():
	GlobalVariables.dices_in_hand = []
	$UI/Inventory/PanelContainer/Dices/GroupOne/DiceOne.button_pressed = false
	$UI/Inventory/PanelContainer/Dices/GroupOne/DiceTwo.button_pressed = false
	$UI/Inventory/PanelContainer/Dices/GroupTwo/DiceThree.button_pressed = false
	$UI/Inventory/PanelContainer/Dices/GroupTwo/DiceFour.button_pressed = false
	$UI/Inventory/PanelContainer/Dices/GroupThree/DiceFive.button_pressed = false
	$UI/Inventory/PanelContainer/Dices/GroupThree/DiceSix.button_pressed = false
	$UI/Inventory/PanelContainer/Dices/GroupFour/DiceSeven.button_pressed = false
	$UI/Inventory/PanelContainer/Dices/GroupFour/DiceEight.button_pressed = false
	$UI/Inventory/PanelContainer/Dices/GroupFive/DiceNine.button_pressed = false
	$UI/Inventory/PanelContainer/Dices/GroupFive/DiceTen.button_pressed = false
	$UI/Inventory/PanelContainer/Dices/GroupSix/DiceEleven.button_pressed = false
		
func show_dice_result(result, sprite, dice_type):
	match dice_type:
		"normal":
			match result:
				1:
					sprite.texture = load("res://images/Dados/dado normal/Dado1Centrado.png")
				2:
					sprite.texture = load("res://images/Dados/dado normal/Dado2Centrado.png")
				3:
					sprite.texture = load("res://images/Dados/dado normal/Dado3Centrado.png")
				4:
					sprite.texture = load("res://images/Dados/dado normal/Dado4Centrado.png")
				5:
					sprite.texture = load("res://images/Dados/dado normal/Dado5Centrado.png")
				6:
					sprite.texture = load("res://images/Dados/dado normal/Dado6Centrado.png")
				null:
					sprite.texture = null
		"burnt_dice":
			match result:
				1:
					sprite.texture = load("res://images/Dados/dado quemaado/DadoQuemado.png")
				2:
					sprite.texture = load("res://images/Dados/dado quemaado/Dado quemado 2.png")
				3:
					sprite.texture = load("res://images/Dados/dado quemaado/Dado quemado 3.png")
				4:
					sprite.texture = load("res://images/Dados/dado quemaado/Dado quemado 4.png")
				null:
					sprite.texture = null
		"insta_death_dice":
			match result:
				false:
					sprite.texture = load("res://images/Dados/dadoinstadeath/Dado insta death fallido.png")
				true:
					sprite.texture = load("res://images/Dados/dadoinstadeath/DadoInstaDeath.png")
				null:
					sprite.texture = null
		"multiplier_dice":
			match result:
				1:
					sprite.texture = load("res://images/Dados/dadomultiplicadordadosrandom/DadoMultiplicador1.png")
				2:
					sprite.texture = load("res://images/Dados/dadomultiplicadordadosrandom/DadoMultiplicador2.png")
				3:
					sprite.texture = load("res://images/Dados/dadomultiplicadordadosrandom/DadoMultiplicador3.png")
				4:
					sprite.texture = load("res://images/Dados/dadomultiplicadordadosrandom/DadoMultiplicador4.png")
				5:
					sprite.texture = load("res://images/Dados/dadomultiplicadordadosrandom/DadoMultiplicador5.png")
				6:
					sprite.texture = load("res://images/Dados/dadomultiplicadordadosrandom/DadoMultiplicador6.png")
				null: 
					sprite.texture = null
			
func win_boss():
	match rival:
		"paloma_mauricio":
			get_tree().change_scene_to_packed(lvl_one_scene)
			GlobalVariables.boss_defeated[1] = true
		"crystall_ball":
			get_tree().change_scene_to_packed(lvl_two_scene)
			GlobalVariables.boss_defeated[2] = true
		"invisibility_cloak":
			get_tree().change_scene_to_packed(lvl_three_scene)
			GlobalVariables.boss_defeated[3] = true
		
func burn_rival():
	if(GlobalVariables.rival_burning_time > 0):
		rival_points -= rival_burning_damage
		GlobalVariables.rival_burning_time -= 1
	
func is_insta_death():
	if(insta_death == true):
		player_points += goal
	
func multiply_result(roll_result):
	if(GlobalVariables.dices_in_hand.has("multiplier_dice")):
		multiplier_result = randi_range(1, 6)
		show_dice_result(multiplier_result, $PlayerBoard/DiceSix, "multiplier_dice")
		player_points += turn_result*multiplier_result-turn_result
		$PlayerBoard/Scoreboard/PlayerScore.text = str(player_points)
	await continue_pressed
	rival_roll_dices(rival)
	
func _on_continue_pressed() -> void:
	continue_pressed.emit()
	
func _enter_tree() -> void:
	$UI/Inventory.update_inventory_ui()
