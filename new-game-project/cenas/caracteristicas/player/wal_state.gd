extends NodeState
#cria uma variavel para o player
@export var player : CharacterBody2D
#cria uma variavel para o sprit
@export var animated_sprit2d :AnimatedSprite2D
#variavel para a velocoade 
@export var speed : int = 50

func _on_process(_delta : float) -> void:
	pass

#função para os movimentos
func _on_physics_process(_delta : float) -> void:
	#cria a variavel direção e diz que ela corresponde a vector2, que também iguala seu valor ao GameInput que é uma variavel do script
	# game_script, essa variavel corresponde a uma função
	var direction : Vector2 = GameInput.movement_Input()
	#se a direção for igual a UP(cima), ele vira de costas
	if direction == Vector2.UP:
		animated_sprit2d.play("walk_back")
	elif direction == Vector2.DOWN:
		animated_sprit2d.play("walk_front")
	elif  direction == Vector2.RIGHT:
		animated_sprit2d.play("walk_right")
	elif direction == Vector2.LEFT:
		animated_sprit2d.play("walk_left")
		
	player.velocity=direction * speed
	player.move_and_slide()

func _on_next_transitions() -> void:
	if !GameInput.is_movement_input():
		transition.emit("idle")


func _on_enter() -> void:
	pass


func _on_exit() -> void:
	pass
