extends Node2D

const EXPLODE = preload("res://assets/explode.wav")

@export var gem_scene: PackedScene
@onready var label: Label = $ScoreLabel
@onready var timer: Timer = $Timer
@onready var game_over_label: Label = $GameOverLabel
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

var _score: int = 0

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

func stop_all() -> void:
	timer.stop()
	for child in get_children():
		child.set_process(false)
	game_over_label.text = "Game Over"
	game_over_label.visible = true
	
func play_dead() -> void:	
	audio_stream_player_2d.stop()
	audio_stream_player_2d.stream = EXPLODE
	audio_stream_player_2d.play()
	audio_stream_player.stop()

func game_over() -> void:
	stop_all()
	play_dead()

func _on_timer_timeout() -> void:
	spawn_gem()


func _on_paddle_area_entered(area: Area2D) -> void:	
	_score += 1
	label.text = "%05d" % _score
	audio_stream_player_2d.position = area.position
	audio_stream_player_2d.play()
	area.queue_free()
