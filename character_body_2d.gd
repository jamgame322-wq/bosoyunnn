extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -450.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var is_in_area: bool = false
var current_area: Area2D = null

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if Input.is_action_just_pressed("zıpla") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	if is_in_area and Input.is_action_just_pressed("dirilt"):
		if current_area:
			var label = current_area.get_node("Label")
			label.visible = false
		animated_sprite.play("default")
		return
	
	var direction := Input.get_axis("sol", "sağ")
	
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("koşma")
	else:
		animated_sprite.play("zıplama")
	
	if direction != 0:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == self:
		is_in_area = true
		current_area = body.get_parent()
		var label = current_area.get_node("Label")
		label.visible = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body == self:
		is_in_area = false
		if current_area:
			var label = current_area.get_node("Label")
			label.visible = false
		current_area = null
