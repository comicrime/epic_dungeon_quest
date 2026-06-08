class_name MessageLog extends ScrollContainer 

var last_message: Message = null 

@onready var message_list: VBoxContainer = %MessageList

func add_message(text: String, color: Color) -> void: 
	print_debug("MessageLog.add_message")
	if (
		last_message != null && 
		last_message.plain_text == text 
	):
		last_message.count += 1 
	else: 
		var message := Message.new(text, color)
		last_message = message 
		self.message_list.add_child(message)
		await get_tree().process_frame 
		ensure_control_visible(message)

func _ready() -> void:
	MsgBus.message_sent.connect(add_message)

static func send_message(text: String, color: Color) -> void:
	print_debug("MessageLog.send_message (text, color): ", text, " ", color)
	MsgBus.message_sent.emit(text, color)
