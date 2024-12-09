extends CanvasLayer

@onready var MyTimer = $Timer
@onready var MyLabel = $Label

var WAIT_TIME := 5.0
var wait_time_displayed := WAIT_TIME
var run_once := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	MyTimer.set_one_shot(true)			# Once Timers done, it stops at 0.0.
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	UpdateTimeDisplayed(MyTimer.time_left)
	#DebugTimer()
	pass

func GetTimeLeft() -> float:
	return MyTimer.time_left

func UpdateTimeDisplayed(current_time: float) -> void:
	var WaitTime := str(current_time).pad_decimals(1)
	MyLabel.text = WaitTime
	pass

func StartCountdown() -> void:
	if (run_once == false):
		MyTimer.start(5.0)
		run_once = true
	pass

func DebugTimer() -> void:
	print("\nTime Left 			" + str(MyTimer.time_left))
	print("Time Left Function 	" + str(MyTimer.get_time_left()))
	print("Wait Time 			" + str(MyTimer.wait_time))
	print("Wait Time Function 	" + str(MyTimer.get_wait_time()))
	print("Timer is Stopped 	" + str(MyTimer.is_stopped()))
