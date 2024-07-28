extends RichTextLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

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
