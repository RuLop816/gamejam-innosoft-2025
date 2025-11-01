extends Control

@onready var options = $OptionsMenu
@onready var pauseMenu = $PanelContainer

var inventoryOpened
var uiBlocked
	
func _ready():
	self.propagate_call("set_mouse_filter", [Control.MOUSE_FILTER_IGNORE])
	options.visible = false
	
func resume():
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")
	self.propagate_call("set_mouse_filter", [Control.MOUSE_FILTER_IGNORE])
	GlobalVariables.pause_menu_opened = false
	
func pause():
	get_tree().paused = true
	$AnimationPlayer.play("blur")
	self.propagate_call("set_mouse_filter", [Control.MOUSE_FILTER_STOP])
	GlobalVariables.pause_menu_opened = true
	
func testEsc():
	if Input.is_action_just_pressed("Pause") and get_tree().paused == false:
		if inventoryOpened == false and uiBlocked == false:
			self.move_to_front()
			pause()
	elif Input.is_action_just_pressed("Pause") and get_tree().paused == true:
		if inventoryOpened == false and uiBlocked == false:
			self.move_to_front()
			resume()

func _on_resume_pressed() -> void:
	resume()

func _on_options_pressed() -> void:
	options.visible = true
	pauseMenu.visible = false

func _on_exit_pressed() -> void:
	get_tree().quit()
	
func _process(delta: float) -> void:
	testEsc()
	inventoryOpened = GlobalVariables.inventory_opened
	uiBlocked = GlobalVariables.ui_blocked

func go_back():
	options.visible = false
	pauseMenu.visible = true

func _on_back_pressed() -> void:
	go_back()
