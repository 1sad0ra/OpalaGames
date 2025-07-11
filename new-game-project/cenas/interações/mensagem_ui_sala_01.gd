extends CanvasLayer

@onready var mensagem: Label = $mensagem
@onready var tempo_mensagem: Timer = $tempo_mensagem
@onready var panel: Panel = $Panel

const texto_tutorial := "USE AS SETAS OU WASD PARA ANDAR
\nAPERTE [E] PARA INTERAGIR
\n USE A BARRA DE ESPAÇO PARA SAIR DE INTERAÇÕES"

func _ready():
	visible = false

func mostrar_mensagem():
	GameState.player_pode_mover = false
	visible = true
	mensagem.text = texto_tutorial
	mensagem.visible = true
	panel.visible = true
	tempo_mensagem.start()

func _on_tempo_mensagem_timeout():
	mensagem.visible = false
	panel.visible = false
	visible = false
	GameState.player_pode_mover = true
