extends CanvasLayer
@onready var mensagem: Label = $mensagem
@onready var tempo_mensagem: Timer = $tempo_mensagem
@onready var panel: Panel = $Panel

func _ready():
	visible= true
	mostrar_mensagem()

func mostrar_mensagem():
	mensagem.visible = true
	panel.visible= true
	tempo_mensagem.start()

func _on_tempo_mensagem_timeout():
	print("O timer terminou!")
	mensagem.visible = false
	panel.visible = false
