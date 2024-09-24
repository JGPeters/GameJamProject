extends Control

signal start_game

func _on_play_pressed() -> void:
	$StartMenu_NPR.hide()
	start_game.emit()
