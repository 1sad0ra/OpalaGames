extends CharacterBody2D

@onready var label_interaçao = $LabelInteraçao

@onready var nome_label: Label = $CanvasLayer/NomeLabel
@onready var caixa_dialogo = $CanvasLayer/CaixaDialogo
@onready var texto_dialogo = $CanvasLayer/TextoDialogo
@onready var retrato: TextureRect = $CanvasLayer/Retrato

var player_perto = false
var falando = false
var pode_avancar = false
var fala_index = 0

var falas = [
	{"speaker": "Diretor", "text": "Olá, meu caro amigo"},
	{"speaker": "Diretor", "text": "Seja muito bem-vindo ao nosso instituto. Sabe qual é o nosso lema?"},
	{"speaker": "Player", "text": "Ainda não… mas imagino que estou prestes a descobrir. Qual é?"},
	{"speaker": "Diretor", "text": "Ora, jovem! Gosto do seu senso de humor. Nosso lema é:"},
	{"speaker": "Diretor", "text": "Lapidando joias, construindo sonhos."},
	{"speaker": "Diretor", "text": "Nossas joias são os alunos o maior bem que temos."},
	{"speaker": "Diretor", "text": "Eles são bons garotos, só precisam de alguém por perto... Aliás, não era pra ter aula agora?"},
	{"speaker": "Player", "text": "Estou... trabalhando nisso."},
	{"speaker": "Diretor", "text": "Haha! Boa sorte, então. Ah, e a propósito..."},
	{"speaker": "Diretor", "text": "talvez você já tenha ouvido que as coisas andam um pouco agitadas por aqui."},
	{"speaker": "Diretor", "text": "Mas não se preocupe demais com isso... Nos veremos em breve. Você ainda tem muito pela frente."},
	{"speaker": "Diretor", "text": "E, aliás, gostei dos seus sapatos! Hahaha!"}



]

var retratos= {
	"Diretor": preload("res://assets/Personagens/Diretor/new_atlas_texture.tres"),
	"Player": preload("res://assets/Personagens/Player_Socram/new_atlas_texture.tres")
}

func _ready():
	caixa_dialogo.visible = false
	texto_dialogo.visible = false
	label_interaçao.visible = false

func _process(_delta):
	if player_perto and not falando and Input.is_action_just_pressed("interact"):
		iniciar_dialogo()
	elif falando and pode_avancar and Input.is_action_just_pressed("interact"):
		proxima_fala()

func _on_area_2d_body_entered(body) -> void:
	if body.name == "player":
		player_perto = true
		label_interaçao.text = " E "
		label_interaçao.visible = true
		label_interaçao.position = Vector2(-label_interaçao.size.x/2, -40)
	
func _on_area_2d_body_exited(body) -> void:
	if body.name == "player":
		player_perto = false
		label_interaçao.text = " E "
		label_interaçao.visible = false

func iniciar_dialogo():
	falando = true
	label_interaçao.visible = false
	caixa_dialogo.visible = true
	texto_dialogo.visible = true
	retrato.visible = true
	nome_label.visible = true
	fala_index = 0
	
	GameState.player_pode_mover = false
	
	proxima_fala()

func proxima_fala():
	if fala_index < falas.size():
		pode_avancar = false
		var fala = falas[fala_index]
		fala_index += 1
		nome_label.text = fala["speaker"]
		texto_dialogo.text = ""
		retrato.texture = retratos.get(fala["speaker"],null)
		mostrar_texto_com_efeito(fala["text"])
	else:
		encerrar_dialogo()


func mostrar_texto_com_efeito(texto):
	await get_tree().create_timer(0.01).timeout
	for letra in texto:
		texto_dialogo.text += letra
		await get_tree().create_timer(0.001).timeout
	pode_avancar = true

func encerrar_dialogo():
	falando = false
	pode_avancar = false
	texto_dialogo.visible = false
	caixa_dialogo.visible = false
	nome_label.visible = false
	retrato.visible = false
	fala_index = 0
	
	GameState.player_pode_mover = true
