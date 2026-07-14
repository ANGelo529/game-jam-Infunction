extends StaticBody2D
@export var texto_lable: Label 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body.is_in_group("Player"):
		texto_lable.text = "No baú atrás de você tem suas armas, pegue,
		aperte a tecla x para alterar entre suas armas,
		tecla y para usar o atacar 
		base de cada arma e a tecla z para defender"
		texto_lable.visible = true
		await get_tree().create_timer(5.0).timeout
		texto_lable.text = ""
		
	pass # Replace with function body.


func _on_body_shape_exited(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	pass # Replace with function body.
