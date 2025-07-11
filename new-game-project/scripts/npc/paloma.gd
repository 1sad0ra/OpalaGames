extends CharacterBody2D

@onready var label_interacao = $LabelInteracao
@onready var nomelabel: Label = $CanvasLayer/nomelabel
@onready var caixa_dialogo = $CanvasLayer/CaixaDialogo
@onready var texto_dialogo = $CanvasLayer/TextoDialogo
@onready var retrato: TextureRect = $CanvasLayer/Retrato
@onready var som_fala = $SomFala
@onready var animated_sprite_2d = $AnimatedSprite2D

# Configurações de movimento
@export var velocidade: float = 40.0
@export var distancia_maxima: float = 200.0
@export var direcao: Vector2 = Vector2.UP  # Vertical (sobe e desce)

# Estado
var posicao_inicial
var andando = true
var player_perto = false
var falando = false
var pode_avancar = false
var fala_index = 0

# Falas
var falas = [
	{"speaker": "Paloma", "text": "Ei, oi! Então é você o novo professor? Já tava sabendo que alguém novo ia chegar."},
	{"speaker": "Player", "text": "Sou eu, sim. Impressionante… todo mundo já sabe antes mesmo de eu me apresentar."},
	{"speaker": "Paloma", "text": "Ah, aqui a fofoca corre mais rápido que a internet do campus."},
	{"speaker": "Paloma", "text": "Mas já que estamos no clima de fofoca,"},
	{"speaker": "Paloma", "text": "deixa eu te contar uma coisa… acabei de sair do laboratório novo."},
	{"speaker": "Paloma", "text": "Colocaram uns PCs novinhos, tudo brilhando. Até que ficou bonito, mas sinceramente?"},
	{"speaker": "Paloma", "text": "Achei um desperdício jogarem fora todos os equipamentos antigos. Ainda davam pro gasto..."},
	{"speaker": "Paloma", "text": "Reformaram quase tudo… quase. Tem um lugar que continua fechado: o Laboratório 19. Trancado há meses."},
	{"speaker": "Paloma", "text": "Ninguém entra. Tá lá… jogado, esquecido."},
	{"speaker": "Player", "text": "Sério? Mas por quê?"},
	{"speaker": "Paloma", "text": "Ninguém fala. Só sei que virou assunto proibido. E, olha… às vezes, quando eu passo perto, dá pra ouvir uns barulhos vindo lá de dentro."},
	{"speaker": "Paloma", "text": "Tipo... coisa se mexendo."},
	{"speaker": "Player", "text":"Nossa, que estranho…"},
	{"speaker": "Paloma", "text":"Pois é. Meio sinistro. Mas dizem que ainda tem muita coisa guardada lá."},
	{"speaker": "Paloma", "text":"Equipamento, arquivos, sei lá… Se você tiver coragem, talvez valha a pena dar uma olhada."}

]

# Retratos
var retratos = {
	"Paloma": preload("res://assets/Personagens/Paloma/new_atlas_texture.tres"),
	"Player": preload("res://assets/Personagens/Player_Socram/new_atlas_texture.tres")
}

func _ready():
	caixa_dialogo.visible = false
	texto_dialogo.visible = false
	label_interacao.visible = false
	posicao_inicial = global_position

func _process(delta):
	if andando:
		movimentar_npc(delta)

	if player_perto and not falando and Input.is_action_just_pressed("interact"):
		iniciar_dialogo()
	elif falando and pode_avancar and Input.is_action_just_pressed("interact"):
		proxima_fala()

func movimentar_npc(delta):
	var deslocamento = global_position - posicao_inicial
	if deslocamento.length() >= distancia_maxima:
		direcao *= -1  # Inverte a direção

	velocity = direcao * velocidade
	move_and_slide()

	# Animações verticais
	if direcao.y < 0:
		animated_sprite_2d.play("andar_cima")
	elif direcao.y > 0:
		animated_sprite_2d.play("andar_baixo")
	else:
		animated_sprite_2d.play("idle")

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "player":
		player_perto = true
		andando = false
		velocity = Vector2.ZERO
		animated_sprite_2d.play("idle")
		label_interacao.text = " E "
		label_interacao.visible = true
		label_interacao.position = Vector2(-label_interacao.size.x / 2, -40)

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "player":
		player_perto = false
		andando = true
		label_interacao.visible = false

func iniciar_dialogo():
	falando = true
	andando = false
	velocity = Vector2.ZERO
	animated_sprite_2d.play("idle")
	label_interacao.visible = false
	caixa_dialogo.visible = true
	texto_dialogo.visible = true
	retrato.visible = true
	nomelabel.visible = true
	fala_index = 0

	GameState.player_pode_mover = false
	proxima_fala()

func proxima_fala():
	if fala_index < falas.size():
		pode_avancar = false
		var fala = falas[fala_index]
		fala_index += 1
		nomelabel.text = fala["speaker"]
		texto_dialogo.text = ""
		retrato.texture = retratos.get(fala["speaker"], null)
		mostrar_texto_com_efeito(fala["text"])
	else:
		encerrar_dialogo()

func mostrar_texto_com_efeito(texto):
	som_fala.play()
	await get_tree().create_timer(0.01).timeout
	for letra in texto:
		texto_dialogo.text += letra
		await get_tree().create_timer(0.001).timeout
	som_fala.stop()
	pode_avancar = true

func encerrar_dialogo():
	som_fala.stop()
	falando = false
	pode_avancar = false
	texto_dialogo.visible = false
	caixa_dialogo.visible = false
	nomelabel.visible = false
	retrato.visible = false
	fala_index = 0
	GameState.player_pode_mover = true
	andando = true
