extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	get_tree().paused = false

func _process(delta):
	if (Input.is_action_just_released("ui_cancel")):
		if ($player/Camera2D2/CenterContainer/GameMenu.visible == false):
			get_tree().paused = true
			$player/Camera2D2/CenterContainer/GameMenu.visible = true
			$player/Camera2D2/CenterContainer/GameMenu/VBoxContainer/main_menu_button.grab_focus()
		else:
			get_tree().paused = false
			$player/Camera2D2/CenterContainer/GameMenu.visible = false

func _on_win_pressed():
	get_tree().change_scene("res://Scenes/success.tscn")

func _on_die_pressed():
	get_tree().change_scene("res://Scenes/failure.tscn")
