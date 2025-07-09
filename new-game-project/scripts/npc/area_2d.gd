extends CharacterBody2D

# Referência para o rótulo de interação ("E")
@onready var label_interacao = $LabelInteracao

# Elementos da interface de diálogo
@onready var caixa_dialogo: Label = $CanvasLayer/CaixaDialogo
@onready var texto_dialogo: Label = $CanvasLayer/TextoDialogo
@onready var nomelabel: Label = $CanvasLayer/nomelabel
@onready var retrato: TextureRect = $CanvasLayer/Retrato

# Sprite animado do personagem
@onready var animated_sprite_2d = $AnimatedSprite2D

# --- CONFIGURAÇÕES DE MOVIMENTO ---
@export var velocidade: float = 40.0                     # Velocidade de movimento
@export var distancia_maxima: float = 120.0              # Distância máxima de movimento (reduzido para andar menos)
@export var direcao: Vector2 = Vector2.UP                # Direção inicial (para cima)

# --- VARIÁVEIS DE ESTADO ---
var posicao_inicial                                       # Posição inicial do NPC
var andando = true                                        # Define se está se movendo
var player_perto = false                                  # Se o player está na área de interação
var falando = false                                       # Se está em um diálogo
var pode_avancar = false                                  # Se pode avançar o diálogo
var fala_index = 0                                        # Índice da fala atual


var falas = [
	{"speaker": "Rodrigo", "text": "E aí, cara. Você é novo aqui, certo?"},
	{"speaker": "Rodrigo", "text": "Deve ser você. Vou logo te avisar: por algum motivo, toda a antiga direção foi trocada com exceção do coordenador."},
	{"speaker": "Rodrigo", "text": "Ele deve ser concursado. Bom, não sei exatamente o motivo, mas vou quebrar esse galho pra você e descobrir."},
	{"speaker": "Player", "text": "Mas... e a aula?"},
	{"speaker": "Rodrigo", "text": "O mistério é mais importante. Coloca presença pra mim, beleza?"},
	{"speaker": "Player", "text": "..."}
]


var retratos= {
	"Rodrigo": preload("res://assets/Personagens/Rodrigo/new_atlas_texture.tres"),
	"Player": preload("res://assets/Personagens/Player_Socram/new_atlas_texture.tres")
}

# --- AO INICIAR ---
func _ready():
	caixa_dialogo.visible = false
	texto_dialogo.visible = false
	label_interacao.visible = false
	posicao_inicial = global_position        # Salva posição inicial para limitar o movimento

# --- PROCESSO A CADA FRAME ---
func _process(delta):
	# Se estiver andando, chama a função de movimentar
	if andando:
		movimentar_npc(delta)

	# Se o player estiver perto e o diálogo ainda não começou
	if player_perto and not falando and Input.is_action_just_pressed("interact"):
		iniciar_dialogo()
	elif falando and pode_avancar and Input.is_action_just_pressed("interact"):
		proxima_fala()

# --- MOVIMENTO DO NPC ---
func movimentar_npc(delta):
	var deslocamento = global_position - posicao_inicial

	# Se ele já andou a distância máxima, inverte a direção
	if deslocamento.length() >= distancia_maxima:
		direcao *= -1

	# Aplica movimento
	velocity = direcao * velocidade
	move_and_slide()

	# Toca animação conforme a direção
	if direcao.y < 0:
		animated_sprite_2d.play("andar_cima")
	elif direcao.y > 0:
		animated_sprite_2d.play("andar_baixo")
	else:
		animated_sprite_2d.play("idle")

# --- QUANDO O PLAYER ENTRA NA ÁREA ---
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "player":
		player_perto = true
		andando = false                  # Para de andar
		velocity = Vector2.ZERO         # Zera a velocidade
		animated_sprite_2d.play("idle") # Para animação
		label_interacao.text = " E "
		label_interacao.visible = true
		label_interacao.position = Vector2(-label_interacao.size.x / 2, -40)

# --- QUANDO O PLAYER SAI DA ÁREA ---
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
	nomelabel.visible = true
	retrato.visible = true
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
	await get_tree().create_timer(0.05).timeout
	for letra in texto:
		texto_dialogo.text += letra
		await get_tree().create_timer(0.005).timeout
	pode_avancar = true


func encerrar_dialogo():
	falando = false
	pode_avancar = false
	texto_dialogo.visible = false
	caixa_dialogo.visible = false
	nomelabel.visible = false
	retrato.visible = false
	fala_index = 0
	GameState.player_pode_mover = true
	andando = true
