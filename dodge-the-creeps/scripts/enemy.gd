extends RigidBody2D

@export var animatedSprite: AnimatedSprite2D

func _ready():
	var mob_types = Array(animatedSprite.sprite_frames.get_animation_names())
	animatedSprite.animation = mob_types.pick_random()
	animatedSprite.play()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
