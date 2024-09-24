extends TileMapLayer

func _ready():
	var pos = $StartPos.position
	pos.x -= $UI.size.x/2
	pos.y -= $UI.size.y/2
	
	$UI.position = pos

func _on_ui_start_game() -> void:
	$Player.position = $StartPos.position
	$Player.show()
	$Player._set_can_move(true)
