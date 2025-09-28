extends Node2D

var player_near = false
@onready var animated_sprite = $AnimatedSprite2D

func _ready():
	$Area2D.connect("body_entered", Callable(self, "_on_body_entered"))
	$Area2D.connect("body_exited", Callable(self, "_on_body_exited"))

func _on_body_entered(body):
	if body.name == "Player":
		player_near = true

func _on_body_exited(body):
	if body.name == "Player":
		player_near = false
		animated_sprite.stop()

func _process(delta):
	if player_near and Input.is_action_pressed("dirilt"):
		if not animated_sprite.is_playing():
			animated_sprite.play("revive")
