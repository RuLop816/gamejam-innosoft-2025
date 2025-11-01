extends Node2D

var goal
var rival
var player_points = 0
var rival_points = 0
var d_in_hand
var player_roll_result
var rival_roll_result
var lvl_one_scene = load("res://scenes/level_one.tscn")

signal continue_pressed

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
	
func player_roll_dices():
	if(GlobalVariables.accepted_pressed == true):
		GlobalVariables.accepted_pressed = false
		for d in d_in_hand:
			match d:
				"dice_one":
					player_roll_result = randi_range(1, 6)
					player_points += player_roll_result
					show_dice_result(player_roll_result, $PlayerBoard/DiceOne)
				"dice_two":
					player_roll_result = randi_range(1, 6)
					player_points += player_roll_result
					show_dice_result(player_roll_result, $PlayerBoard/DiceTwo)
				"dice_three":
					player_roll_result = randi_range(1, 6)
					player_points += player_roll_result
					show_dice_result(player_roll_result, $PlayerBoard/DiceThree)
				"dice_four":
					player_roll_result = randi_range(1, 6)
					player_points += player_roll_result
					show_dice_result(player_roll_result, $PlayerBoard/DiceFour)
				"dice_five":
					player_roll_result = randi_range(1, 6)
					player_points += player_roll_result
					show_dice_result(player_roll_result, $PlayerBoard/DiceFive)
				"dice_six":
					player_roll_result = randi_range(1, 6)
					player_points += player_roll_result
					show_dice_result(player_roll_result, $PlayerBoard/DiceSix)
	##			"burnt_dice":
	##				button.texture_normal = load("res://images/Dados/dado quemaado/DadoQuemado.png")
	##				button.texture_pressed = load("res://images/Dados/dado quemaado/DadoQuemadoPulsado.png")
	##				button.stretch_mode = 6
	##			"chameleon_dice":
	##				button.texture_normal = load("res://images/Dados/dadocamaleon/DadoCamaleon.png")
	##				button.texture_pressed = load("res://images/Dados/dadocamaleon/DadoCamaleonPulsado.png")
	##				button.stretch_mode = 6
	##			"ice_dice":
	##				button.texture_normal = load("res://images/Dados/dadocongelador/DadoCongelador.png")
	##				button.texture_pressed = load("res://images/Dados/dadocongelador/DadoCongeladoPulsado.png")
	##				button.stretch_mode = 6
	##			"insta_death_dice":
	##				button.texture_normal = load("res://images/Dados/dadoinstadeath/DadoInstaDeath.png")
	##				button.texture_pressed = load("res://images/Dados/dadoinstadeath/DadoInstaDeathPulsado.png")
	##				button.stretch_mode = 6
	##			"multiplier_dice":
	##				button.texture_normal = load("res://images/Dados/dadomultiplicadordadosrandom/DadoMultiplicador1.png")
	##				button.texture_pressed = load("res://images/Dados/dadomultiplicadordadosrandom/DadoMultiplicador1Pulsado.png")
	##				button.stretch_mode = 6
		print("Tu puntuación este turno es: ", player_points)
		$PlayerBoard/Scoreboard/PlayerScore.text = str(player_points)
		await continue_pressed
		rival_roll_dices(rival)
	
func rival_roll_dices(challenge_rival):
	match challenge_rival:
		"paloma_mauricio":
			rival_roll_result = randi_range(1, 6)
			rival_points += rival_roll_result
			show_dice_result(rival_roll_result, $RivalBoard/DiceOne)
			rival_roll_result = randi_range(1, 6)
			rival_points += rival_roll_result
			show_dice_result(rival_roll_result, $RivalBoard/DiceTwo)
			rival_roll_result = randi_range(1, 6)
			rival_points += rival_roll_result
			show_dice_result(rival_roll_result, $RivalBoard/DiceThree)
			rival_roll_result = randi_range(1, 6)
			rival_points += rival_roll_result
			show_dice_result(rival_roll_result, $RivalBoard/DiceFour)
			show_dice_result(null, $RivalBoard/DiceFive)
			show_dice_result(null, $RivalBoard/DiceSix)
		"crystall_ball":
			rival_points += randi_range(3, 6)
			rival_points += randi_range(3, 6)
			rival_points += randi_range(3, 6)
			rival_points += randi_range(3, 6)
			rival_points += randi_range(3, 6)
		"invisibility_cloak":
			rival_points += randi_range(1, 6)
			rival_points += randi_range(1, 6)
			rival_points += randi_range(1, 6)
			rival_points += randi_range(1, 6)
			rival_points += randi_range(1, 6)
			rival_points += randi_range(1, 6)
	print("La puntuación de tu rival este turno es: ", rival_points)
	$RivalBoard/Scoreboard/RivalScore.text = str(rival_points)
	await continue_pressed
	end_turn()
	
func end_turn():
	if(player_points >= goal and rival_points >= goal):
		if(player_points > rival_points):
			get_tree().change_scene_to_packed(lvl_one_scene)
		elif(player_points == rival_points):
			start_turn()
		else:
			print("Unlucky, has perdido")
	elif(player_points >= goal):
		get_tree().change_scene_to_packed(lvl_one_scene)
	elif(rival_points >= goal):
		print("Unlucky, has perdido")
	else:
		start_turn()
		
func show_dice_result(result, sprite):
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
			
func _on_continue_pressed() -> void:
	continue_pressed.emit()
