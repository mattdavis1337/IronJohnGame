extends 'res://addons/gut/test.gd'

var Character = load("res://Character.gd");
var _character = null;

func before_each():
	_character = Character.new();
	
func after_each():
	_character.free();

func test_direction_vector():
	var result = _character._get_movement("left");
	var speed = _character.speed;
	assert_eq(result, Vector2(-speed, 0), "wrong speed vector");
