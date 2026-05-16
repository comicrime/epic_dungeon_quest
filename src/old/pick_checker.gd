class_name PickChecker extends Checker

func check(obj: Node) -> bool:
	var item: Item = obj as Item 
	if item == null: 
		return false 
		
	return true
