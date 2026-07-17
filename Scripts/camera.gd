extends Camera2D
var alvo = Node2D
@onready var player: CharacterBody2D = $"../Player"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if player:
		global_position = player.global_position
	descobrirPosicaoPlayer()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#descobrirPosicaoPlayer()
	if player:
		global_position = global_position.lerp(player.global_position, 0.1)

func descobrirPosicaoPlayer():
	var nosPlayer = get_tree().get_nodes_in_group("Player")
	
	if nosPlayer.size() == 0:
		push_error("Não tem player na cena")
		return 
		
	alvo = nosPlayer[0]
