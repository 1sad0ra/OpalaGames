extends Area2D

# os elemetos visuais do dialogo no canvaslayer
@onready var caixa_dialogo: Label = $CanvasLayer/CaixaDialogo
@onready var texto_dialogo: Label = $CanvasLayer/TextoDialogo
@onready var label_interacao: Label = $CanvasLayer/LabelInteracao
@onready var nomelabel: Label = $CanvasLayer/nomelabel
@onready var retrato: TextureRect = $CanvasLayer/Retrato

#controle do estado do dialogo
var player_perto = false
var falando = false
var pode_avancar = false
var fala_index = 0

# listas de falas com dicionario indicando personagem e o texto
var falas = [
	{"speaker": "Rodrigo", "text": "E aí, cara. Você é novo aqui, certo?"},
	{"speaker": "Rodrigo", "text": "Deve ser você. Vou logo te avisar: por algum motivo, toda a antiga direção foi trocada — com exceção do coordenador."},
	{"speaker": "Rodrigo", "text": "Ele deve ser concursado. Bom, não sei exatamente o motivo, mas vou quebrar esse galho pra você e descobrir."},
	{"speaker": "Player", "text": "Mas... e a aula?"},
	{"speaker": "Rodrigo", "text": "O mistério é mais importante. Coloca presença pra mim, beleza?"},
	{"speaker": "Player", "text": "..."}
]

# dicionario com os retratos dos personagens
var retratos= {
	"Rodrigo": preload("res://assets/Personagens/Rodrigo/new_atlas_texture.tres"),
	"Player": preload("res://assets/Personagens/Player_Socram/new_atlas_texture.tres")
}

# esconde todos os elementos de interface no inicio
func _ready():
	caixa_dialogo.visible = false
	texto_dialogo.visible = false
	label_interacao.visible = false

# Inicia o diálogo quando o player estiver perto e pressionar "E"
func _process(_delta):
	if player_perto and not falando and Input.is_action_just_pressed("interact"):
		iniciar_dialogo()
	elif falando and pode_avancar and Input.is_action_just_pressed("interact"):
		proxima_fala()
		
# Quando o player entra na área de interação
func _on_body_entered(body) -> void:
	if body.name == "player":
		player_perto = true
		label_interacao.text = "Pressione E para interagir"
		label_interacao.visible = true
		label_interacao.global_position = global_position + Vector2(0, -40)

# Quando o player sai da área, esconde a mensagem de interação
func _on_body_exited(body) -> void:
	if body.name == "player":
		player_perto = false
		label_interacao.text = "Pressione E para interagir"
		label_interacao.visible = false
	
func iniciar_dialogo():
	falando = true
	label_interacao.visible = false
	caixa_dialogo.visible = true
	texto_dialogo.visible = true
	fala_index = 0
	proxima_fala()

func proxima_fala():
	if fala_index < falas.size():
		pode_avancar = false
		var fala = falas[fala_index]
		fala_index += 1
		nomelabel.text = fala["speaker"]
		texto_dialogo.text = ""
		retrato.texture = retratos.get(fala["speaker"],null)
		mostrar_texto_com_efeito(fala["text"])
	else:
		encerrar_dialogo()

func mostrar_texto_com_efeito(texto):
	await get_tree().create_timer(0.1).timeout
	for letra in texto:
		texto_dialogo.text += letra
		await get_tree().create_timer(0.02).timeout
	pode_avancar = true

# Finaliza o diálogo e esconde os elementos
func encerrar_dialogo():
	falando = false
	pode_avancar = false
	texto_dialogo.visible = false
	caixa_dialogo.visible = false
	nomelabel.visible = false
	retrato.visible = false
