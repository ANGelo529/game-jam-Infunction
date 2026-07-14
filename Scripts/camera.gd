extends Camera2D
var alvo = Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	descobrirPosicaoPlayer()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	descobrirPosicaoPlayer()
	if alvo.position != null:
		position.x = alvo.position.x
		position.y = alvo.position.y

func descobrirPosicaoPlayer():
	var nosPlayer = get_tree().get_nodes_in_group("Player")
	
	if nosPlayer.size() == 0:
		push_error("Não tem player na cena")
		return 
		
	alvo = nosPlayer[0]
