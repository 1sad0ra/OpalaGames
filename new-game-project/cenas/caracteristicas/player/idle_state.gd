extends NodeState

@export var player: CharacterBody2D
@export var animated_sprit2d: AnimatedSprite2D

var direction : Vector2

func _on_process(_delta : float) -> void:
	pass


func _on_physics_process(_delta : float) -> void:
	direction = GameInput.movement_input()
		
	if direction == Vector2.UP:
		animated_sprit2d.play("idle_back")
	elif  direction == Vector2.LEFT:
		animated_sprit2d.play("idle_left")
	elif  direction == Vector2.RIGHT:
		animated_sprit2d.play("idle_rigth")
	elif  direction == Vector2.DOWN:
		animated_sprit2d.play("idle_front")	
		
	else:
		animated_sprit2d.play("idle_front")	


func _on_next_transitions() -> void:
	GameInput.movement_input()
	
	if GameInput.is_movement_input():
		transition.emit("walk")


func _on_enter() -> void:
	pass


func _on_exit() -> void:
	pass
