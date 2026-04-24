extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

#add an exposed float variable for max time kick is enabled. (0.5)

#add another float variable for kick timer

@export var _kickRight: Node2D
@export var _kickLeft: Node2D


var _facingRight: bool = true

func _enter_tree() -> void:
	_disablekick()

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if direction > 0:
		_facingRight = true
	elif direction < 0:
		_facingRight = false
		
		#check if timer is running (If the kick timer > 0)
		#subtract delta from the timer
		#if timer has ran out (if the timer < 0) 
		#call disable kick
		
		if Input.is_action_just_pressed("ui_accept"):
			_kick()
			
	move_and_slide()
	
	
func _kick() -> void:
	if _facingRight:
		print("right kick")
		_kickRight.process_mode = Node.PROCESS_MODE_INHERIT
	else:
		print("left kick")
		_kickLeft.process_mode = Node.PROCESS_MODE_INHERIT
	#set kick timer to max
	
	
func _disablekick() -> void:
	_kickRight.process_mode = Node.PROCESS_MODE_DISABLED
	_kickLeft.process_mode = Node.PROCESS_MODE_DISABLED


func _on_kick_right_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	print(body.name)


func _on_kick_left_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	print(body.name)
