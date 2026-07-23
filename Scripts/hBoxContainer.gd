extends VBoxContainer

# Aponta para o VBoxContainer que guarda os botões
@onready var containerVertical = $HBoxContainer 

var upgradesValores = {
	"0": {"nome":"flechaDiferente", "descricao": "Seu dano passa a ser o valor de um dado de 6 lados"},
	"1": {"nome":"Arco potente", "descricao": "Dobra o dano do seu arco"},
	"2": {"nome":"Machado infectado", "descricao": "Dobra o dano do seu machado"},
	"3": {"nome":"Super Espada", "descricao": "Dobra o dano da sua espada"},
	"4": {"nome":"Dash", "descricao": "Aumenta temporariamente a sua velocidade"},
	"5": {"nome":"Buff de Vida", "descricao": "Aumenta permanentemente a sua vida"},
	"6": {"nome":"Buff de dano", "descricao": "Aumenta permanentemente o dano de todas as suas armas"},
	"7": {"nome":"Buff de salto", "descricao": "Aumenta permanentemente o tamanho do seu pulo"},
	"8": {"nome":"Que Racoon City nunca se repita", "descricao": "Agora quando você apertar <f> você entrará em fúria e seu dano dobrará por 10 segundos"},
	"9": {"nome":"Espinhos", "descricao": "Quando você levar dano o seu inimigo levará um dano equivalente a seu dano de espada"},
	"10": {"nome":"Quanto mais melhor", "descricao": "Aumenta quantas flechas você pode atirar por fase"},
	"11": {"nome":"Barra de proteina", "descricao": "Aumenta sua velocidade permanentemente"}
}

func _ready() -> void:
	randomize()
	gerar_opcoes_de_upgrade()

func gerar_opcoes_de_upgrade() -> void:
	var botoes_existentes = containerVertical.get_children()
	
	var lista_ids = upgradesValores.keys()
	lista_ids.shuffle()
	
	for i in range(botoes_existentes.size()):
		var botao = botoes_existentes[i] as Button
		
		if botao:
			var idSorteado = lista_ids[i]
			var dadosUpgrade = upgradesValores[idSorteado]
			
			#botao.nomeUpgrade.text = dadosUpgrade["nome"]
			#botao.descricao.text = dadosUpgrade["descricao"]
			var labelNome = botao.get_node("nomeUpgrade") as Label
			var labelDesc = botao.get_node("descricao") as Label
			
			if labelNome: labelNome.text = dadosUpgrade["nome"]
			if labelDesc: labelDesc.text = dadosUpgrade["descricao"]
			botao.set_meta("idUpgrade", idSorteado)

func _on_botao_upgrades_pressed(botaoClicado: Button) -> void:
	var idBotaoClicado = botaoClicado.get_meta("idUpgrade")
	aplicarEfeitoPlayer(idBotaoClicado)

func aplicarEfeitoPlayer(id:String):
	match id:
		"0":
			#player.usa_dado_d6 = true
			print("Efeito aplicado: Flecha randômica com D6!")
		"1":
			#player.dano_arco *= 2
			print("Efeito aplicado: Arco potente!")
		"2":
			#player.dano_machado *= 2
			pass
		"3":
			#player.dano_espada *= 2
			pass
		"4":
			#player.pode_dar_dash = true
			pass
		"5":
			#player.vida_maxima += 20
			#player.vida_atual += 20 # Cura o jogador com o bônus ganho
			pass
		"6":
			#player.dano_geral_bonus += 5
			pass
		"7":
			#player.forca_pulo += 50
			pass
		"8":
			#player.habilidade_furia_desbloqueada = true
			pass
		"9":
			#player.tem_espinhos = true
			pass
		"10":
			#player.max_flechas += 5
			pass
		"11":
			#player.velocidade_movimento += 40
			pass
