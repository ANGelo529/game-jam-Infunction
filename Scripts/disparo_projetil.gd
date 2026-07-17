extends Area2D



var speed = 100
var direcao = 1


func _process(delta: float) -> void:
	self.position.x += speed * delta * direcao
	pass

func definirDirecao(direction):
	self.direcao = direction


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
	pass # Replace with function body.


func _on_body_entered(body: Node2D) -> void:
	if body is TileMapLayer:
		queue_free()
		return
	
	if body.is_in_group("inimigos"):
		var a =0
		# if body.has_method("levarDano"):
		# 		body.levarDano(10)
		queue_free()
		return
	pass # Replace with function body.
