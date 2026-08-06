extends Button

@export var hover_scale: Vector2 = Vector2(1.1, 1.1)
@export var normal_scale: Vector2 = Vector2(1.0, 1.0)
@export var duration: float = 0.15

var tween: Tween

func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	pivot_offset = size / 2.0

func _on_mouse_entered() -> void:
	_create_scale_tween(hover_scale)

func _on_mouse_exited() -> void:
	_create_scale_tween(normal_scale)

func _create_scale_tween(target_scale: Vector2) -> void:
	if tween:
		tween.kill()
	tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
	tween.tween_property(self, "scale", target_scale, duration)
