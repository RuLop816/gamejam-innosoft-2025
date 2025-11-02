extends Control
	
var pauseMenuOpened 
var uiBlocked
var inventoryAction
var dicesInInventory
var rival_burn_time
	
func _ready():
	self.propagate_call("set_mouse_filter", [Control.MOUSE_FILTER_IGNORE])
	
func _process(delta: float) -> void:
	testInv()
	pauseMenuOpened = GlobalVariables.pause_menu_opened
	uiBlocked = GlobalVariables.ui_blocked
	inventoryAction = GlobalVariables.inventory_action
	dicesInInventory = GlobalVariables.dices_in_inventory
	rival_burn_time = GlobalVariables.rival_burning_time
	
func close_inventory():
	self.move_to_front()
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")
	self.propagate_call("set_mouse_filter", [Control.MOUSE_FILTER_IGNORE])
	GlobalVariables.inventory_opened = false
	
func open_inventory():
	self.move_to_front()
	get_tree().paused = true
	$AnimationPlayer.play("blur")
	self.propagate_call("set_mouse_filter", [Control.MOUSE_FILTER_STOP])
	GlobalVariables.inventory_opened = true
	
func testInv():
	if Input.is_action_just_pressed("Inventory") and get_tree().paused == false:
		if pauseMenuOpened == false and uiBlocked == false:
			open_inventory()
	elif Input.is_action_just_pressed("Inventory") and get_tree().paused == true:
		if pauseMenuOpened == false and uiBlocked == false:
			close_inventory()

func choose_lost_dice():
	open_inventory()
	GlobalVariables.ui_blocked = true
	GlobalVariables.inventory_action = "erase dice"
	
func take_first_dices():
	add_dice("dice_one")
	add_dice("dice_two")
	add_dice("dice_three")
	add_dice("dice_four")
	add_dice("dice_five")
	add_dice("dice_six")
	
func add_dice(dice):
	var dice_position = 0
	for d in GlobalVariables.dices_in_inventory:
		if(d == null):
			GlobalVariables.dices_in_inventory[dice_position] = dice
			break
		dice_position += 1
	update_inventory_ui()
	
func update_inventory_ui():
	var button_number = 1
	var b
	for d in GlobalVariables.dices_in_inventory:
		match button_number:
			1:
				b = $PanelContainer/Dices/GroupOne/DiceOne
				assign_dice_ui(d, b)
			2:
				b = $PanelContainer/Dices/GroupOne/DiceTwo
				assign_dice_ui(d, b)
			3:
				b = $PanelContainer/Dices/GroupTwo/DiceThree
				assign_dice_ui(d, b)
			4:
				b = $PanelContainer/Dices/GroupTwo/DiceFour
				assign_dice_ui(d, b)
			5:
				b = $PanelContainer/Dices/GroupThree/DiceFive
				assign_dice_ui(d, b)
			6:
				b = $PanelContainer/Dices/GroupThree/DiceSix
				assign_dice_ui(d, b)
			7:
				b = $PanelContainer/Dices/GroupFour/DiceSeven
				assign_dice_ui(d, b)
			8:
				b = $PanelContainer/Dices/GroupFour/DiceEight
				assign_dice_ui(d, b)
			9:
				b = $PanelContainer/Dices/GroupFive/DiceNine
				assign_dice_ui(d, b)
			10:
				b = $PanelContainer/Dices/GroupFive/DiceTen
				assign_dice_ui(d, b)
			11:
				b = $PanelContainer/Dices/GroupSix/DiceEleven
				assign_dice_ui(d, b)
		button_number += 1

func assign_dice_ui(dice, button):
	match dice:
		"dice_one":
			button.texture_normal = load("res://images/Dados/dado normal/Dado1Centrado.png")
			button.texture_pressed = load("res://images/Dados/dado normal/Dado1CentradoPulsado.png")
			button.stretch_mode = 6
		"dice_two":
			button.texture_normal = load("res://images/Dados/dado normal/Dado2Centrado.png")
			button.texture_pressed = load("res://images/Dados/dado normal/Dado2CentradoPulsado.png")
			button.stretch_mode = 6
		"dice_three":
			button.texture_normal = load("res://images/Dados/dado normal/Dado3Centrado.png")
			button.texture_pressed = load("res://images/Dados/dado normal/Dado3CentradoPulsado.png")
			button.stretch_mode = 6
		"dice_four":
			button.texture_normal = load("res://images/Dados/dado normal/Dado4Centrado.png")
			button.texture_pressed = load("res://images/Dados/dado normal/Dado4CentradoPulsado.png")
			button.stretch_mode = 6
		"dice_five":
			button.texture_normal = load("res://images/Dados/dado normal/Dado5Centrado.png")
			button.texture_pressed = load("res://images/Dados/dado normal/Dado5CentradoPulsado.png")
			button.stretch_mode = 6
		"dice_six":
			button.texture_normal = load("res://images/Dados/dado normal/Dado6Centrado.png")
			button.texture_pressed = load("res://images/Dados/dado normal/Dado6CentradoPulsado.png")
			button.stretch_mode = 6
		"burnt_dice":
			button.texture_normal = load("res://images/Dados/dado quemaado/DadoQuemado.png")
			button.texture_pressed = load("res://images/Dados/dado quemaado/DadoQuemadoPulsado.png")
			button.stretch_mode = 6
		"chameleon_dice":
			button.texture_normal = load("res://images/Dados/dadocamaleon/DadoCamaleon.png")
			button.texture_pressed = load("res://images/Dados/dadocamaleon/DadoCamaleonPulsado.png")
			button.stretch_mode = 6
		"insta_death_dice":
			button.texture_normal = load("res://images/Dados/dadoinstadeath/DadoInstaDeath.png")
			button.texture_pressed = load("res://images/Dados/dadoinstadeath/DadoInstaDeathPulsado.png")
			button.stretch_mode = 6
		"multiplier_dice":
			button.texture_normal = load("res://images/Dados/dadomultiplicadordadosrandom/DadoMultiplicador1.png")
			button.texture_pressed = load("res://images/Dados/dadomultiplicadordadosrandom/DadoMultiplicador1Pulsado.png")
			button.stretch_mode = 6
		null: 
			button.texture_normal = null
			button.texture_pressed = null
			button.stretch_mode = 6

func _on_dice_one_pressed() -> void:
	if(inventoryAction == "erase dice" and dicesInInventory[0] != null):
		dicesInInventory[0] = null
		update_inventory_ui()
		GlobalVariables.ui_blocked = false
		GlobalVariables.inventory_action = null
		close_inventory()

func _on_dice_two_pressed() -> void:
	if(inventoryAction == "erase dice" and dicesInInventory[1] != null):
		dicesInInventory[1] = null
		update_inventory_ui()
		GlobalVariables.ui_blocked = false
		GlobalVariables.inventory_action = null
		close_inventory()

func _on_dice_three_pressed() -> void:
	if(inventoryAction == "erase dice" and dicesInInventory[2] != null):
		dicesInInventory[2] = null
		update_inventory_ui()
		GlobalVariables.ui_blocked = false
		GlobalVariables.inventory_action = null
		close_inventory()

func _on_dice_four_pressed() -> void:
	if(inventoryAction == "erase dice" and dicesInInventory[3] != null):
		dicesInInventory[3] = null
		update_inventory_ui()
		GlobalVariables.ui_blocked = false
		GlobalVariables.inventory_action = null
		close_inventory()

func _on_dice_five_pressed() -> void:
	if(inventoryAction == "erase dice" and dicesInInventory[4] != null):
		dicesInInventory[4] = null
		update_inventory_ui()
		GlobalVariables.ui_blocked = false
		GlobalVariables.inventory_action = null
		close_inventory()

func _on_dice_six_pressed() -> void:
	if(inventoryAction == "erase dice" and dicesInInventory[5] != null):
		dicesInInventory[5] = null
		update_inventory_ui()
		GlobalVariables.ui_blocked = false
		GlobalVariables.inventory_action = null
		close_inventory()

func _on_dice_seven_pressed() -> void:
	if(inventoryAction == "erase dice" and dicesInInventory[6] != null):
		dicesInInventory[6] = null
		update_inventory_ui()
		GlobalVariables.ui_blocked = false
		GlobalVariables.inventory_action = null
		close_inventory()

func _on_dice_eight_pressed() -> void:
	if(inventoryAction == "erase dice" and dicesInInventory[7] != null):
		dicesInInventory[7] = null
		update_inventory_ui()
		GlobalVariables.ui_blocked = false
		GlobalVariables.inventory_action = null
		close_inventory()

func _on_dice_nine_pressed() -> void:
	if(inventoryAction == "erase dice" and dicesInInventory[8] != null):
		dicesInInventory[8] = null
		update_inventory_ui()
		GlobalVariables.ui_blocked = false
		GlobalVariables.inventory_action = null
		close_inventory()

func _on_dice_ten_pressed() -> void:
	if(inventoryAction == "erase dice" and dicesInInventory[9] != null):
		dicesInInventory[9] = null
		update_inventory_ui()
		GlobalVariables.ui_blocked = false
		GlobalVariables.inventory_action = null
		close_inventory()

func _on_dice_eleven_pressed() -> void:
	if(inventoryAction == "erase dice" and dicesInInventory[10] != null):
		dicesInInventory[10] = null
		update_inventory_ui()
		GlobalVariables.ui_blocked = false
		GlobalVariables.inventory_action = null
		close_inventory()

func _on_dice_one_toggled(toggled_on: bool) -> void:
	var dice_one = GlobalVariables.dices_in_inventory[0]
	if(inventoryAction == "choose dices" and dice_one != null):
		if toggled_on:
			GlobalVariables.dices_in_hand.append(dice_one)
		elif !toggled_on:
			GlobalVariables.dices_in_hand.erase(dice_one)

func _on_dice_two_toggled(toggled_on: bool) -> void:
	var dice_two = GlobalVariables.dices_in_inventory[1]
	if(inventoryAction == "choose dices" and dice_two != null):
		if toggled_on:
			GlobalVariables.dices_in_hand.append(dice_two)
		elif !toggled_on:
			GlobalVariables.dices_in_hand.erase(dice_two)

func _on_dice_three_toggled(toggled_on: bool) -> void:
	var dice_three = GlobalVariables.dices_in_inventory[2]
	if(inventoryAction == "choose dices" and dice_three != null):
		if toggled_on:
			GlobalVariables.dices_in_hand.append(dice_three)
		elif !toggled_on:
			GlobalVariables.dices_in_hand.erase(dice_three)

func _on_dice_four_toggled(toggled_on: bool) -> void:
	var dice_four = GlobalVariables.dices_in_inventory[3]
	if(inventoryAction == "choose dices" and dice_four != null):
		if toggled_on:
			GlobalVariables.dices_in_hand.append(dice_four)
		elif !toggled_on:
			GlobalVariables.dices_in_hand.erase(dice_four)

func _on_dice_five_toggled(toggled_on: bool) -> void:
	var dice_five = GlobalVariables.dices_in_inventory[4]
	if(inventoryAction == "choose dices" and dice_five != null):
		if toggled_on:
			GlobalVariables.dices_in_hand.append(dice_five)
		elif !toggled_on:
			GlobalVariables.dices_in_hand.erase(dice_five)

func _on_dice_six_toggled(toggled_on: bool) -> void:
	var dice_six = GlobalVariables.dices_in_inventory[5]
	if(inventoryAction == "choose dices" and dice_six != null):
		if toggled_on:
			GlobalVariables.dices_in_hand.append(dice_six)
		elif !toggled_on:
			GlobalVariables.dices_in_hand.erase(dice_six)

func _on_dice_seven_toggled(toggled_on: bool) -> void:
	var dice_seven = GlobalVariables.dices_in_inventory[6]
	if(inventoryAction == "choose dices" and dice_seven != null):
		if toggled_on:
			GlobalVariables.dices_in_hand.append(dice_seven)
		elif !toggled_on:
			GlobalVariables.dices_in_hand.erase(dice_seven)

func _on_dice_eight_toggled(toggled_on: bool) -> void:
	var dice_eight = GlobalVariables.dices_in_inventory[7]
	if(inventoryAction == "choose dices" and dice_eight != null):
		if toggled_on:
			GlobalVariables.dices_in_hand.append(dice_eight)
		elif !toggled_on:
			GlobalVariables.dices_in_hand.erase(dice_eight)

func _on_dice_nine_toggled(toggled_on: bool) -> void:
	var dice_nine = GlobalVariables.dices_in_inventory[8]
	if(inventoryAction == "choose dices" and dice_nine != null):
		if toggled_on:
			GlobalVariables.dices_in_hand.append(dice_nine)
		elif !toggled_on:
			GlobalVariables.dices_in_hand.erase(dice_nine)

func _on_dice_ten_toggled(toggled_on: bool) -> void:
	var dice_ten = GlobalVariables.dices_in_inventory[9]
	if(inventoryAction == "choose dices" and dice_ten != null):
		if toggled_on:
			GlobalVariables.dices_in_hand.append(dice_ten)
		elif !toggled_on:
			GlobalVariables.dices_in_hand.erase(dice_ten)

func _on_dice_eleven_toggled(toggled_on: bool) -> void:
	var dice_eleven = GlobalVariables.dices_in_inventory[10]
	if(inventoryAction == "choose dices" and dice_eleven != null):
		if toggled_on:
			GlobalVariables.dices_in_hand.append(dice_eleven)
		elif !toggled_on:
			GlobalVariables.dices_in_hand.erase(dice_eleven)

func _on_accept_button_pressed() -> void:
	print(inventoryAction)
	print(GlobalVariables.dices_in_hand)
	if(inventoryAction == "choose dices" and GlobalVariables.dices_in_hand.size() <= 6):
		print("Se mete en la condición principal")
		if(GlobalVariables.dices_in_hand.has("insta_death_dice") and GlobalVariables.dices_in_hand.size()>1):
			print("Pasa la primera condición")
			pass
		elif(GlobalVariables.dices_in_hand.has("multiplier_dice") and GlobalVariables.dices_in_hand.size()>4):
			print("Pasa la segunda condición")
			pass
		elif(two_special_dices_in_hand()):
			print("Pasa la tercera condición")
			pass
		elif(GlobalVariables.dices_in_hand.has("burnt_dice") and rival_burn_time > 0):
			pass
		else:
			GlobalVariables.ui_blocked = false
			GlobalVariables.inventory_action = null
			close_inventory()
			GlobalVariables.accepted_pressed = true
		
func two_special_dices_in_hand() -> bool:
	var num_special_dices = 0
	var res = false
	for dice in GlobalVariables.dices_in_hand:
		print(dice)
		for special_dice in GlobalVariables.special_dices_in_game:
			if dice == special_dice:
				num_special_dices += 1
			if num_special_dices > 1:
				res = true
				break
	return res
