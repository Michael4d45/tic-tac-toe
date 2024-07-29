extends Node2D


signal player_type_updated(player: Enums.Player, player_type: Enums.PlayerType)


func _on_human_x_button_toggled(toggled_on):
	if toggled_on:
		player_type_updated.emit(Enums.Player.X, Enums.PlayerType.HUMAN)


func _on_aix_button_toggled(toggled_on):
	if toggled_on:
		player_type_updated.emit(Enums.Player.X, Enums.PlayerType.AI)


func _on_human_o_button_toggled(toggled_on):
	if toggled_on:
		player_type_updated.emit(Enums.Player.O, Enums.PlayerType.HUMAN)


func _on_aio_button_toggled(toggled_on):
	if toggled_on:
		player_type_updated.emit(Enums.Player.O, Enums.PlayerType.AI)
