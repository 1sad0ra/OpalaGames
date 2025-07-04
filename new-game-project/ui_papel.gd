extends CanvasLayer


@onready var imagem: TextureRect = $Imagem
@onready var texto: Label = $texto

@export var ppaper_texture : Texture2D


func _ready() -> void:
	
	visible = false 


func show_paper(texture: Texture2D, text: String):
	
	var Imagem = preload("res://assets/Personagens/Paloma/new_atlas_texture.tres")

	visible = true
	imagem.texture = Imagem
	texto.text = text

func fechar():
	visible = false
