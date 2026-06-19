@tool
extends RichTextEffect
class_name CustomShake

var bbcode = "customshake"

func _process_custom_fx(fx: CharFXTransform) -> bool:
	var angle = deg_to_rad(fx.env.get("rot", 0.0))
	var char_count = fx.env.get("char_count", 1)
	var offset: float = fx.relative_index / char_count
	var desired_angle: float = lerp_angle(-angle, angle, offset)
	fx.transform = fx.transform.rotated_local(desired_angle)
	return true
