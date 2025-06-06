extends CharacterBody2D

class_name Bird

@export var gravity = 900.0
@export var jump_force: int = -300
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var max_speed = 400
var rotation_speed = 2
var is_started = false

func _ready():
	'''
	Instantiates a new velocity vector.
	'''
	velocity = Vector2.ZERO
	if !is_started:
		animation_player.play("idle")

func _physics_process(delta: float):
	'''
	Handles the jumping process of the bird.
	'''
	if Input.is_action_just_pressed("jump"):
		if !is_started:
			animation_player.play("flap_wings")
			is_started = true
		jump()
	
	if !is_started:
		return
	velocity.y += delta * gravity
	if velocity.y > max_speed:
		velocity.y = max_speed
	
	move_and_collide(velocity * delta)
	rotate_bird()

func jump():
	velocity.y = jump_force
	rotation = deg_to_rad(-30)
	print("jump")

func rotate_bird():
	if velocity.y > 0 and rad_to_deg(rotation) < 90:
		rotation += rotation_speed * deg_to_rad(1)
	elif velocity.y < 0 and rad_to_deg(rotation) > -30:
		rotation -= rotation_speed * deg_to_rad(1)
