extends Node

var collider 
var level_number = 1
var dices_in_inventory = [null, null, null, null, null, null, null, null, null, null, null]
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
var master_dice_blocked = false
var dice_faces = [1]
var first_dices_taken = false
