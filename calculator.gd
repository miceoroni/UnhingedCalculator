extends Control

@onready var display:Label = $MarginContainer/VBoxContainer/Label

var text_ref: Array[String] = ["idk gng :sob:", "ask google", "like 6..7?", "ask god bru"]
var text_too_big: Array[String] = ["not solving allat", "holy yap", "SONION 😭", "sum big num idk", "solve it yourself gng"]
var stored_value: float = 0.0
var curr_op: String = ""
var should_reset: bool = false
var too_large: bool
var is_leet: bool
var is_six_seven: bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	display.text = "0"

func _on_num_pressed(number:int) -> void:
	if display.text == "0" or should_reset:
		display.text = str(number)
		should_reset = false
	else:
		display.text += str(number)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_sym_pressed(extra_arg_0: String) -> void:
	match extra_arg_0:
		"+", "-", "*", "÷":
			_set_op(extra_arg_0)
		"=":
			_calc()
		"AC":
			_clear()
		"CE":
			display.text = "0"
			should_reset = false
		"<-":
			_backspace()
		"+/-":
			_toggle_sign()
		".":
			_add_decimal()

func _set_op(op: String) -> void:
	if curr_op != "" and not should_reset:
		_calc()
	stored_value = display.text.to_float()
	curr_op = op
	should_reset = true

func _calc() -> void:
	too_large = false
	is_leet = false
	is_six_seven = false
	if curr_op == "":
		return
	var cur_val := display.text.to_float()
	var result := 0.0
	match curr_op:
		"+": result = stored_value + cur_val
		"-": result = stored_value - cur_val
		"*": result = stored_value * cur_val
		"/":
			if cur_val == 0:
				display.text = "nah gng"
				curr_op = ""
				should_reset = true
				return
			result = stored_value / cur_val
	if result > 9999:
		too_large = true
	if result == 1337:
		is_leet = true
	if result == 67:
		is_six_seven = true
	curr_op = ""
	should_reset = true
	_show_res(result)

func _clear() -> void:
	display.text = "0"
	stored_value = 0.0
	curr_op = ""
	should_reset = false

func _backspace() -> void:
	if display.text.length() > 1:
		display.text = display.text.substr(0, display.text.length() - 1)
	else:
		display.text = "0"
		
func _toggle_sign() -> void:
	if display.text.begins_with("-"):
		display.text = display.text.substr(1)
	elif display.text != "0":
		display.text = "-" + display.text

func _add_decimal() -> void:
	if should_reset:
		display.text = "0."
		should_reset = false
	elif not display.text.contains("."):
		display.text += "."
		
func _show_res(value: float) -> void:
	var result_str := _form_res(value)
	display.text = _trans(result_str)
	
func _form_res(value: float) -> String:
	if value == int(value):
		return str(int(value))
	return str(value)

func _trans(text: String) -> String:
	var rand_word: String
	if is_leet:
		rand_word = "El33t ball knowledge"
	elif is_six_seven:
		$AudioStreamPlayer.play()
		rand_word = "SIX SEVEN BOIIIIIIII"
	elif too_large:
		rand_word = text_too_big.pick_random()
	elif not text_ref.is_empty():
		rand_word = text_ref.pick_random()
	return rand_word
