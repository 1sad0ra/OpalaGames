
#estende o no da área 2d
extends  Area2D

@export var papel_texture : Texture2D
@export var papel_text : String

signal paper_interacted(texture,text)

func _on_body_entered(body):
	if body.is_in_group("Player"):
		if Input.is_action_just_pressed("interagir"):
			emit_signal("paper_interacted", papel_texture, papel_text)
