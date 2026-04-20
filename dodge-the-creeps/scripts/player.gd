extends Area2D

signal hit

@export var speed = 400 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.
@export var animatedSprite: AnimatedSprite2D
@export var collisionShape: CollisionShape2D

func _ready():
	hide()
	screen_size = get_viewport_rect().size

func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		animatedSprite.play()
	else:
		animatedSprite.stop()
	
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
	if velocity.y != 0:
		animatedSprite.animation = "up"
		animatedSprite.flip_v = velocity.y > 0 
	elif velocity.x != 0:
		animatedSprite.animation = "walk"
		animatedSprite.flip_v = false
		animatedSprite.flip_h = velocity.x < 0


func _on_body_entered(body: Node2D) -> void:
	hide() # Player disappears after being hit.
	hit.emit()
	# Must be deferred as we can't change physics properties on a physics callback.
	collisionShape.set_deferred("disabled", true)

func start(pos):
	position = pos
	show()
	collisionShape.disabled = false
