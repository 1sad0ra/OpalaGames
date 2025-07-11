extends Control

@onready var click_player = $ClickPlayer
@onready var hover_player = $HoverPlayer

func _ready():
	for button in get_tree().get_nodes_in_group("menu_buttons"):
		button.pressed.connect(_on_button_pressed)
		button.mouse_entered.connect(_on_button_hover)

func _on_button_pressed():
	click_player.play()

func _on_button_hover():
	hover_player.play()

func _on_jogar_button_1_pressed():
	click_player.play()
	await get_tree().create_timer(0.2).timeout
	get_tree().change_scene_to_file("res://cenas/teste/sala_01l.tscn")

func _on_sair_button_3_pressed():
	click_player.play()
	await get_tree().create_timer(0.2).timeout
	get_tree().quit()
