extends Node

var collider 
var level_number = 2
var dices_in_inventory = [null, null, null, null, null, null, null, null, null, null, null]
var dices_in_hand = []
var special_dices_available = ["burnt_dice", "insta_death_dice", "multiplier_dice"]
var special_dices_in_game = ["burnt_dice", "insta_death_dice", "multiplier_dice"]
var pause_menu_opened = false
var inventory_opened = false
var ui_blocked = false
var inventory_action
var level_one_blocked = false
var level_two_blocked = true
var level_three_blocked = true
var level_four_blocked = true
var level_five_blocked = true
var level_six_blocked = true
var master_dice_blocked = true
var dice_faces = [1, 2]
var first_dices_taken = false
var boss
var goal 
var accepted_pressed = false
var boss_defeated := {1:false, 2:false, 3:false}
var reward_not_obtained = {1:true, 2:true, 3:true}
var rival_burning_time = 0
var tutorial_dialogue_red = false
var introduction_dialogue_red = false
