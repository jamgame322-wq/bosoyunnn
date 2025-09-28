extends AnimatedSprite2D


func _on_area_2d_body_entered(body: Node2D) -> void:
	print("deneme") # Replace with function body.
	queue_free()
