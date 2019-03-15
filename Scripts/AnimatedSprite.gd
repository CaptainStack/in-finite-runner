extends AnimatedSprite
#signal hit #collision detection

export (int) var speed #exprt lets you set value in inspector
var screensize
var jumped = false

func _ready():
	screensize = get_viewport_rect().size
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	##Movement and animation start
		##Run animation start
	
	var velocity = Vector2()
	if Input.is_action_pressed("ui_right"):
		$AnimatedSprite.animation = "right"
		velocity.x +=1
	if Input.is_action_pressed("ui_left"):
		$AnimatedSprite.animation = "right"
		velocity.x -= 1
	if Input.is_action_just_pressed("ui_up"):
		$AnimatedSprite.animation = "jump"
		velocity.y -= 1
		$AnimatedSprite.play()
		jumped = true
		
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
		
	##else:
		#$AnimatedSprite.stop()
	position += velocity * delta
	
	if velocity.x != 0:
		$AnimatedSprite.animation = "right"
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = velocity.x < 0
			##End run animations
			
			##Jump animation start
	
		
			#End Jump Animation
	##Movement and animation end
	
	##Collision detection start
	##hide() #Player disappears when hit
	#emit_signal("hit")
	#$CollisionShape2D.disabled = true #Don't trigger hit more than once
	
	##Collision detection end
	
	
			
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Player_body_entered(body):
	pass # replace with function body


func _on_AnimatedSprite_animation_finished():
	if jumped:
		$AnimatedSprite.stop()
		jumped = false
	#jumped = true
		$AnimatedSprite.animation = "right"	
		$AnimatedSprite.play()
	
		

