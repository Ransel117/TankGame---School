extends Control

onready var Main = $Main
onready var Settings = $Settings
onready var Audio = $Audio
onready var Controls = $Controls
onready var Video = $Video
onready var Misc = $Misc
onready var Win = $Win
onready var turntimer = get_parent().get_parent().get_child(7)
onready var inventory = get_parent().get_child(1)

func _on_StartButton_button_down():
	hide()
	inventory.show()
	turntimer.start()

func _on_SettingsButton_button_down():
	Main.hide()
	Settings.show()

func _on_QuitButton_button_down():
	get_tree().quit()

func _on_AudioButton_button_down():
	Settings.hide()
	Audio.show()

func _on_VideoButton_button_down():
	Settings.hide()
	Video.show()

func _on_ControlsButton_button_down():
	Settings.hide()
	Controls.show()

func _on_MiscButton_button_down():
	Settings.hide()
	Misc.show()

func _on_BackButton_button_down():
	if Audio.visible or Video.visible or Controls.visible or Misc.visible:
		Audio.hide()
		Video.hide()
		Controls.hide()
		Misc.hide()
		Settings.show()
	elif Settings.visible:
		Settings.hide()
		Main.show()

func _on_MainMenuButton_button_down():
	Win.hide()
	Main.show()
	get_tree().reload_current_scene()

func on_win():
	Main.hide()
	inventory.hide()
	show()
	Win.show()
	$Win/Label2.text = "Player " + str(get_parent().get_parent().WWCD) + " Won!"
