extends Area2D
@onready var main: Node2D = $"../.."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	var ehOPlayer = body.is_in_group("Player")
	var bossMorto = false
	var zonaAtual = get_parent().name
	var grupoFaseAtual = get_parent().get_groups()
	var listaGrupo = get_tree().get_nodes_in_group(grupoFaseAtual[0])
	var posNohGrupo = 0
	
	for i in range(listaGrupo.size()):
		print(listaGrupo[i].name)
		if listaGrupo[i].name == zonaAtual:
			posNohGrupo = i
	
	if ehOPlayer:
		main.mudarDeFase(posNohGrupo,grupoFaseAtual[0])
	elif ehOPlayer and bossMorto:
		main.mudarDeZona("Cyber")

	pass
