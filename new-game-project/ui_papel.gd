extends CanvasLayer

@onready var imagem = $Imagem
@onready var texto = $Texto
@onready var fechar = $Fechar

func show_paper(texture: Texture2D, text: String):
	visible = true
	imagem.texture = texture
	texto.text = text

func _on_Fechar_pressed():
	visible = false
