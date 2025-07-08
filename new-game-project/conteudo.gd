extends CanvasLayer

@onready var imagem: TextureRect = $Imagem
@onready var texto: Label = $tutorial
@onready var boas_vindas: Label = $boas_vindas


func _ready() -> void:
	print("visivel")
	visible = false 

func show_paper():
	visible = true

func fechar():
	visible = false
