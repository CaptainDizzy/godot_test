extends Node2D

var path_tree := []
var map_canvas := {"x" = 128, "y" = 115, "w" = 1600, "h" = 850}
var node_size := {"w" = 50, "h" = 50}
var path_segs: int = 12
var branch_segs: int = 6
var path_allowance: int = 200
var node_distance: float = ((map_canvas.w - (node_size.w * path_segs)) / (path_segs - 1)) + node_size.w

func _ready() -> void:
	%Map.position.x = map_canvas.x
	%Map.position.y = map_canvas.y
	generate_tree()

func _on_generate_new_btn() -> void:
	# Clear the array any previous nodes on screen
	path_tree = []
	for node in get_children():
		node.queue_free()
	
	generate_tree()

func generate_tree() -> void:
	# Create the map canvas bg
	var canvas_bg: ColorRect = ColorRect.new()
	canvas_bg.size = Vector2(map_canvas.w,map_canvas.h)
	canvas_bg.position = Vector2(0,0)
	canvas_bg.color = Color("ffffff19")
	add_child(canvas_bg)
	# Create 1st node (path_tree[0]) & initialize local relative variables
	var start_location := {"x" = 0, "y" = (map_canvas.h / 2) - (node_size.h / 2)}
	path_tree = [
		{
			"x": start_location.x,
			"y": start_location.y
		}
	]
	const FIRST_NODE_SHAPE = preload("res://path_tree/assets/node_shape.tscn")
	var first_node_shape = FIRST_NODE_SHAPE.instantiate()
	first_node_shape.position.x = start_location.x
	first_node_shape.position.y = start_location.y
	add_child(first_node_shape)
	var prev_node: Dictionary = path_tree[0]
	
	# Create 2nd+ nodes (path_tree[1], path_tree[2], ...)
	for n in path_segs:
		if n == 0: 
			continue # Skip the 1st node because it was already made above
		
		# Set the new node's dictionary
		var new_node = {
			"x": prev_node.x + node_distance,
			"y": prev_node.y + randi_range(-200, 200)
		}
		# Make sure a node isn't above or below the map canvas
		if new_node.y <= map_canvas.y:
			new_node.y = abs(new_node.y)
		elif new_node.y >= map_canvas.h - 50:
			new_node.y = map_canvas.h - 75
		
		# Add the new node to the path array
		path_tree.append(new_node)
		
		# Create and show the actual node in the scene tree and on the screen visually
		const NODE_SHAPE = preload("res://path_tree/assets/node_shape.tscn")
		var new_node_shape = NODE_SHAPE.instantiate()
		new_node_shape.position.x = new_node.x
		new_node_shape.position.y = new_node.y
		add_child(new_node_shape)
		
		# Record the new node so the next one can reference it more easily !!Must be the very last call in the loop
		prev_node = new_node
	#print(path_tree)
