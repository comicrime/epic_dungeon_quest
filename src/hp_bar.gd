extends ProgressBar

func _init() -> void: 
	MsgBus.player_hp_change.connect(_on_hp_change)

func _on_hp_change(hp: int, max_hp: int) -> void: 
	print(hp, " ", max_hp)
	
	if hp == 0: 
		self.value = 0 
		return
	
	@warning_ignore("integer_division")
	var progress: float = hp as float / (max_hp as float / 100) 
	print("progress: ", progress)
	
	self.value = progress
