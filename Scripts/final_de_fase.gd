extends Area2D
@onready var main: Window = $"../.."

var jaAtivou = false
func _ready() -> void:
	await get_tree().process_frame
	pass

func _process(delta: float) -> void:
	pass



func _on_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	
	if body.is_in_group("Player"):
		await Main.avancarFase()
		print("Ja trocou de fase")
	pass 
