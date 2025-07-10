extends CanvasLayer

@onready var imagem: TextureRect = $Imagem
@onready var texto: Label = $Texto

@export var paper_texture : Texture2D

func _ready() -> void:
	visible = false 

func show_paper():
	
	visible = true
	imagem.visible = true
	texto.visible= true

func fechar():
	visible = false
	imagem.visible = false
	texto.visible= false
