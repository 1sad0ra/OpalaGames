extends Control

func _ready():
	pass

func _process(delta):
	pass



func _on_jogar_button_1_pressed():
	get_tree().change_scene_to_file("res://cenas/teste/world.tscn")

func _on_conf_button_2_pressed():
	pass # Replace with function body.

func _on_sair_button_3_pressed():
	get_tree().quit()
