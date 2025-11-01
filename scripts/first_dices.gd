extends Node2D

var collision
var inventory_dices
var dices_taken

func _ready():
	if(GlobalVariables.first_dices_taken == true):
		self.queue_free()

func _physics_process(delta: float):
	collision = GlobalVariables.collider
	inventory_dices = GlobalVariables.dices_in_inventory
	
	if(collision != null):
		if(collision.name == "FirstDices" and Input.is_action_just_pressed("Interact")):
				get_parent().get_node("UI").get_node("Inventory").take_first_dices()
				GlobalVariables.first_dices_taken = true
				self.queue_free()
