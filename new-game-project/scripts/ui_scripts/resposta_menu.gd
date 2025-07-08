extends CanvasLayer

@onready var Confirmar_Button2 = $Confirmar_Button2
@onready var inputs := [
	$VBoxContainer/HBoxContainer/LineEdit1,
	$VBoxContainer/HBoxContainer/LineEdit2,
	$VBoxContainer/HBoxContainer/LineEdit3,
	$VBoxContainer/HBoxContainer/LineEdit4,
	$VBoxContainer/HBoxContainer/LineEdit5
]

func _ready():
	visible = false


func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		visible = true
		get_tree().paused = true

func _on_voltar_button_1_pressed():
	get_tree().paused = false
	visible = false

func _on_confirmar_button_2_pressed():
	var resposta = ""
	for input in inputs:
		resposta += input.text.strip_edges()
	if  resposta == "12b45":
		print("Resposta Correta")
		for input in inputs:
			input.add_theme_color_override("font_color", Color(0,1,0))
		await get_tree().create_timer(0.5).timeout
		get_tree().paused = false
		queue_free()
	else:
		print("Resposta incorreta")
		for input in inputs:
			input.add_theme_color_override("font_color", Color(1,0,0))
		await  get_tree().create_timer(0.5).timeout
		for input in inputs:
			input.text = ""
			input.add_theme_color_override("font_color", Color(0,0,0))
