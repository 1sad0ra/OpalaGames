extends Node2D
func _ready():
	# Define a posição da janela (ex: 100 pixels da esquerda e 50 de cima)
	DisplayServer.window_set_position(Vector2i(250, 50))
