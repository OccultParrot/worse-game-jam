class_name ObservableArray
extends RefCounted

signal changed

var _data: Array = []

func _on_modified() -> void:
	changed.emit()

# Expose standard array methods
func append(value) -> void:
	_data.append(value)
	_on_modified()

func remove_at(index: int) -> void:
	_data.remove_at(index)
	_on_modified()

func clear() -> void:
	_data.clear()
	_on_modified()

func get_item(index: int):
	return _data[index]

func set_item(index: int, value) -> void:
	_data[index] = value
	_on_modified()
	
func batch_set(indexs: Array[int], value) -> void:
	for idx in indexs:
		_data[idx] = value
	_on_modified()

func size() -> int:
	return _data.size()
