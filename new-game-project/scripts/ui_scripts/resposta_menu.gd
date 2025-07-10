extends CanvasLayer

@onready var Confirmar_Button2 = $Confirmar_Button2
@onready var click_player = $ClickPlayer
@onready var hover_player = $HoverPlayer
@onready var type_player = $TypePlayer
@onready var error_player = $ErrorPlayer
@onready var correct_player = $CorrectPlayer

@onready var inputs := [
	$VBoxContainer/HBoxContainer/LineEdit1,
	$VBoxContainer/HBoxContainer/LineEdit2,
	$VBoxContainer/HBoxContainer/LineEdit3,
	$VBoxContainer/HBoxContainer/LineEdit4,
	$VBoxContainer/HBoxContainer/LineEdit5
]

var last_type_time := 0.0
const TYPE_DELAY := 0.05

func _ready():
	visible = false

	for button in get_tree().get_nodes_in_group("menu_buttons"):
		button.pressed.connect(_on_button_pressed)
		button.mouse_entered.connect(_on_button_hover)

	for i in inputs.size():
		inputs[i].text_changed.connect(_on_text_input.bind(i))

func _unhandled_input(event):
	if event.is_action_pressed("cofre"):
		visible = true
		get_tree().paused = true

func _on_voltar_button_1_pressed():
	get_tree().paused = false
	visible = false

func _on_confirmar_button_2_pressed():
	var resposta = ""
	for input in inputs:
		resposta += input.text.strip_edges()

	if resposta == "12b45":
		print("Resposta Correta")
		correct_player.play()  
		for input in inputs:
			input.add_theme_color_override("font_color", Color(0, 1, 0))
		await get_tree().create_timer(0.5).timeout
		get_tree().paused = false
		queue_free()
	else:
		print("Resposta incorreta")
		error_player.play()
		for input in inputs:
			input.add_theme_color_override("font_color", Color(1, 0, 0))
		await get_tree().create_timer(0.5).timeout
		for input in inputs:
			input.text = ""
			input.add_theme_color_override("font_color", Color(0, 0, 0))
		inputs[0].grab_focus()

func _on_button_pressed():
	click_player.play()

func _on_button_hover():
	hover_player.play()

func _on_text_input(new_text: String, index: int):
	var now = Time.get_ticks_msec() / 1000.0
	if now - last_type_time > TYPE_DELAY:
		type_player.play()
		last_type_time = now

	if new_text.length() == 1 and index < inputs.size() - 1:
		inputs[index + 1].grab_focus()
