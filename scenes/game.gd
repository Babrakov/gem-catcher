extends Node2D

@export var gem_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_gem()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func spawn_gem() -> void:
	var new_scene: Gem = gem_scene.instantiate()
	var gem_size = 70
	var xpos: float = randf_range(gem_size,get_viewport_rect().size.x-gem_size)
	new_scene.on_gem_off_screen.connect(game_over)
	new_scene.position = Vector2(xpos,-50)	
	add_child(new_scene)

func game_over() -> void:
	print("Game Over")

func _on_timer_timeout() -> void:
	spawn_gem()
