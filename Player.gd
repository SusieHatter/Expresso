extends KinematicBody2D

export (int) var gravity = 800
export (int) var speed = 200
export (int) var jump_speed = 100

var velocity = Vector2()
var dir = "Left"
var picking_up = false

func _physics_process(delta):
	if Input.is_action_just_pressed("interact"):
		$AnimationPlayer.play("Pickup" + dir)
		picking_up = true
		$PickupTimer.start()

	var grounded = is_on_floor();
	velocity.x = 0
	if not picking_up:
		if grounded and Input.is_action_just_pressed("jump"):
			velocity.y = -jump_speed
		if Input.is_action_pressed("right"):
			velocity.x += speed
			$AnimationPlayer.play("WalkRight")
			dir = "Right"
		elif Input.is_action_pressed("left"):
			velocity.x -= speed
			$AnimationPlayer.play("WalkLeft")
			dir = "Left"
		elif velocity.y != 0:
			$AnimationPlayer.stop()
		else:
			$AnimationPlayer.play("Idle" + dir)
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP, true)


func _on_PickupTimer_timeout():
	picking_up = false
