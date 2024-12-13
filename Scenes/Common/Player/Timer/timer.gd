extends Node

var elapsed_time = 0.0
var is_timing = false

func _ready():
	start_timer()

func _process(delta):
	if is_timing:
		elapsed_time += delta
		$TimerLabel.text = str(elapsed_time).pad_decimals(2)

func start_timer():
	elapsed_time = 0.0
	is_timing = true

func stop_timer():
	is_timing = false
	$TimerLabel.text = "Final Time: " + str(elapsed_time).pad_decimals(2)
	
func reset_timer():
	elapsed_time = 0.0
