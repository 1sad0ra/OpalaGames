extends Node2D

@onready var player = $player
@onready var posicoes_entrada = $posicoes_entrada
@onready var mensagem_ui = $mensagemUI

func _ready():
	await get_tree().process_frame

	if GameState.porta_saida != "":
		var nome = GameState.porta_saida
		var marker = posicoes_entrada.get_node_or_null(nome)
		if marker:
			player.global_position = marker.global_position

			var camera = player.get_node_or_null("Camera2D")
			if camera:
				camera.reset_smoothing()
				camera.force_update_scroll()
		GameState.porta_saida = ""
