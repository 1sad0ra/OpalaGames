extends CanvasLayer

@onready var voltar_button_1: Button = $menu_holder/Voltar_Button1

func _ready():
	visible = false

func _process(delta):
	pass

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		visible = true
		get_tree().paused = true 
		voltar_button_1.grab_focus()
		

func _on_voltar_button_1_pressed():
	get_tree().paused = false
	visible = false

func _on_menu_button_2_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://cenas/ui_cenas/tela_incial.tscn")
