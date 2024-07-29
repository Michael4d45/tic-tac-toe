extends RichTextLabel

const GameState = Enums.GameState
const texts = {
	GameState.O_WON: "O Won",
	GameState.X_WON: "X Won",
	GameState.O_TURN: "O's Turn",
	GameState.X_TURN: "X's Turn",
	GameState.TIE: "It's a Tie!",
}

func _on_gameboard_game_state_updated(_old_game_state: Enums.GameState, new_game_state: Enums.GameState) -> void:
	text = texts[new_game_state]
