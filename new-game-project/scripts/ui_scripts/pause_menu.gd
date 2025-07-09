extends CanvasLayer

@onready var voltar_button_1: Button = $menu_holder/Voltar_Button1
@onready var click_player = $ClickPlayer
@onready var hover_player = $HoverPlayer

func _ready():
	visible = false
	
	for button in get_tree().get_nodes_in_group("menu_buttons"):
		button.mouse_entered.connect(_on_button_hover)
		button.pressed.connect(_on_button_pressed)

func _process(delta):
	pass

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		visible = true
		get_tree().paused = true 
		voltar_button_1.grab_focus()

func _on_button_hover():
	hover_player.play()

func _on_button_pressed():
	click_player.play()

func _on_voltar_button_1_pressed():
	click_player.play()
	await get_tree().create_timer(0.2).timeout
	get_tree().paused = false
	visible = false

func _on_menu_button_2_pressed():
	click_player.play()
	await get_tree().create_timer(0.2).timeout
	get_tree().paused = false
	get_tree().change_scene_to_file("res://cenas/ui_cenas/tela_incial.tscn")
