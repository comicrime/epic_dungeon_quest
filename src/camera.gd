extends Camera2D

func _ready():
	MsgBus.zoom.connect(self._on_zoom)

func _on_zoom(dir: int) -> void:
	print("zoom event")
	if dir == 1: 
		self.zoom.x = self.zoom.x + 1
		self.zoom.y = self.zoom.y + 1
	else:
		self.zoom.x = self.zoom.x - 1
		self.zoom.y = self.zoom.y - 1
