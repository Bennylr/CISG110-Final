extends RigidBody2D

@export var _speed: float = 50.0
@export var _move_right: bool = false
@export var _explosion_VFX: CPUParticles2D

func _ready() -> void:
	max_contacts_reported = 3
	contact_monitor = true
	
	
func _physics_process(delta: float) -> void:
	var direction = 1 if _move_right else -1
	linear_velocity = Vector2(direction * _speed, 0)
	linear_velocity.x = -_speed
	
	move_and_collide(linear_velocity * delta)
	
func _on_body_shape_entered(body_rid: RID, body: Node, body_shape_index: int, local_shape_index: int) -> void:
	if body.name == "Player":
		print("rat hit player and exploded")
	if _explosion_VFX:
		_explosion_VFX.global_position = global_position
		_explosion_VFX.reparent(get_parent())
		_explosion_VFX.emitting = true
		
		queue_free()
