extends Node2D

var path_tree := []
var map_canvas := {"x" = 128, "y" = 115, "w" = 1600, "h" = 850}
var node_size := {"w" = 50, "h" = 50}
var path_segs: int = 12
var branch_segs: int
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
	
	# 1. MAIN TREE PATH
	# Create 1st node (path_tree[0]) & initialize local relative variables
	var start_location := {"x" = 0, "y" = (map_canvas.h / 2) - (node_size.h / 2)}
	path_tree = [
		{
			"pos": 0,
			"x": start_location.x,
			"y": start_location.y,
			"branches": 0
		}
	]
	
	# Create and display the path line that will connect the nodes.
	# This is done before the first node shape, because I want the line behind the nodes
	var path_line = Line2D.new()
	add_child(path_line)
	path_line.width = 8.0
	path_line.default_color = Color("2f72d8")
	path_line.add_point(Vector2(start_location.x + (node_size.w/2),start_location.y + (node_size.h/2)))
	
	# Display first node
	draw_node(path_tree[0])
	var prev_node: Dictionary = path_tree[0]
	
	# Create the rest of the nodes (path_tree[1], path_tree[2], ...)
	for n in path_segs:
		if n == 0: 
			continue # Skip the 1st node because it was already made above
		
		# Set the new node's dictionary
		var new_node = {
			"pos": n,
			"x": prev_node.x + node_distance,
			"y": prev_node.y + randi_range(-200, 200),
			"branches": 0
		}
		clamp_canvas(new_node) # Make sure a node isn't above or below the map canvas
		path_tree.append(new_node) # Add the new node to the path array
		
		# Update the path line to connect to the new node
		path_line.add_point(Vector2(new_node.x + (node_size.w/2),new_node.y + (node_size.h/2)))
		draw_node(new_node) # Create and show the actual node in the scene tree and on the screen visually
		
		# Record the new node so the next one can reference it more easily !!Must be the very last call in the loop
		prev_node = new_node
	
	# 2. NODE BRANCHES
	# Iterate through the completed tree path array and make branches (everything up to now was the EASY part <_<)
	var i = 0
	for node in path_tree:
		if i == path_segs - 1:
			print("End of line")
			print(path_tree)
			continue
		
		var n = randi_range(1, 20) # Choose 0, 1, or 2 paths
		
		if n > 12: # Don't create branch, and skip to the next node
			print("node " + str(i) + ": no branch")
			#continue
			
		elif n > 4: # Create 1 branch
			print("node " + str(node.pos) + ": 1 branch")
			prev_node = node # Set previous node to the branch's parent node since it will be the first node in this branch
			node.branches = 1 # Update the node's branches key value
			node["branch_1"] = []
			branch_segs = path_segs - (node.pos + 1) - 1 # Determine how many branch_segs there should be
			
			grow_branches(i,node, prev_node)
			
		elif n > 0: # Create 2 branches
			print("node " + str(i) + ": 2 branches")
		
		i += 1
	

func grow_branches(i, node, prev_node) -> void:
	# Create a new branch array
	var new_branch = []
	
	# Make the number of branches the node has
	for b in node.branches:
		# Create in set up the new branch's path line
		var branch_line = Line2D.new()
		add_child(branch_line)
		branch_line.width = 8.0
		branch_line.default_color = Color("507b41ff")
		branch_line.add_point(Vector2(prev_node.x + (node_size.w/2),prev_node.y + (node_size.h/2)))
		
		# Generate new nodes until self terminating
		var bs = 1
		var end = false
		while not end:
			var c = randi_range(1, 20)
			
			# Reconnect to tree path
			if c > 12:
				print("node " + str(i) + ": reconnected from roll")
				var new_node = {
					"pos": prev_node.pos + 1,
					"x": prev_node.x + node_distance,
					"y": prev_node.y + randi_range(-200, 200),
					"branches": 0
				}
				
				var merged = check_siblings_and_adjust(new_branch, node, new_node, branch_line, b)
				if merged:
					print("merged early")
					branch_line.add_point(Vector2(new_node.x + (node_size.w/2),new_node.y + (node_size.h/2)))
					draw_node(new_node)
					end = true  # If the check returns true, we just have to end the loop here because the check appends the node and branch and resolves the line and node for us
				elif not merged:
					new_branch.append(new_node) # Add the new node to the branch array
					
					branch_line.add_point(Vector2(new_node.x + (node_size.w/2),new_node.y + (node_size.h/2)))
					draw_node(new_node)
					
					prev_node = new_node # Record new node as the previous node now that it's completed
					
					var connector_node = {
						"pos": prev_node.pos,
						"x": prev_node.x,
						"y": prev_node.y,
						"branches": 0
					}
					print("connector_node created at " + str(connector_node.x) + ", " + str(connector_node.y))
					# Find a node to connect to
					var connect_nodes: Array = get_tree_connectors(connector_node)
					var closest_dist = 0
					var closest: Dictionary
					for cnctn in connect_nodes:
						print("connector at pos: " + str(cnctn.pos) + " y = " + str(cnctn.y))
						var dist = abs(cnctn.y - connector_node.y)
						if not closest:
							closest = cnctn                         # Record the first node to set the variables
							closest_dist = dist
						elif dist < closest_dist:
							closest = cnctn                         # Record the clossest node and it's distance
							closest_dist = dist
					
					print("closest at pos: " + str(closest.pos) + "| y: " + str(closest.y))
					
					if closest.pos == connector_node.pos:
						var v = randi_range(1, 20)
						if v > 12:
							connector_node.y = closest.y
							connector_node.x = closest.x
							connector_node.pos = closest.pos
							print("merged with closest node at pos " + str(closest.pos))
						elif v > 6:
							connector_node.y = connect_nodes[0].y
							connector_node.x = connect_nodes[0].x
							connector_node.pos = connect_nodes[0].pos
							print("chose to merge with node at pos " + str(connect_nodes[1].pos))
						elif v > 0:
							connector_node.y = connect_nodes[2].y
							connector_node.x = connect_nodes[2].x
							connector_node.pos = connect_nodes[2].pos
							print("chose to merge with node at pos " + str(connect_nodes[2].pos))
					else:
						connector_node.y = closest.y
						connector_node.x = closest.x
						print("merged with closest")
					
					new_branch.append(connector_node)
					branch_line.add_point(Vector2(connector_node.x + (node_size.w/2),connector_node.y + (node_size.h/2)))
					draw_node(connector_node)
					node["branch_" + str(b+1)] = new_branch
					end = true
			
			elif c > 0: # Create new node
				# Set the new node's dictionary
				var new_node = {
					"pos": prev_node.pos + 1,
					"x": prev_node.x + node_distance,
					"y": prev_node.y + randi_range(-200, 200),
					"branches": 0
				}
				
				# Do all the heavy lifting in a separate function for reusability
				var did_end = check_siblings_and_adjust(new_branch, node, new_node, branch_line, b)
				
				if did_end:                # If check_siblings_and_adjust returns true, that means it merged nodes along with draw the line and node, 
					prev_node = new_node   # so we only need to set end to end to true and record prev_node I know this can be more efficient, but that's for Future Dizzy. to deal with.
					end = true
				elif not did_end:
					new_branch.append(new_node)# Add the new node to the branch array
					branch_line.add_point(Vector2(new_node.x + (node_size.w/2),new_node.y + (node_size.h/2))) # Update the path line to connect to the new node
					draw_node(new_node) # Create and show the actual node in the scene tree and on the screen visually
					prev_node = new_node # Record new node as the previous node now that it's completed
			
			# Check if branch_segs has been met, if so end loop
			if bs >= branch_segs and not end:
				node["branch_" + str(b+1)] = new_branch
				end = true
			else:
				bs += 1

func check_siblings_and_adjust(new_branch, crnt_node, new_node, branch_line, i = 0) -> bool:
	
	# Make sure a node isn't above or below the map canvas
	clamp_canvas(new_node)
	
	# Make sure the node doesn't overlap existing nodes at the same x pos
	var siblings = get_pos_siblings(new_node)
	
	print("checking pos: " + str(new_node.pos) + " | siblings found: " + str(siblings["all"].size()) + " | close siblings: " + str(siblings["close"].size()))
	for s in siblings["all"]:
		print("  sib y: " + str(s.y) + " new_node y: " + str(new_node.y) + " diff: " + str(abs(s.y - new_node.y)))
	
	var closest_dist = 0
	var closest: Dictionary
	if siblings["close"].size() > 1:                       # If there are more than 1 nodes close to new_node...
		for s in siblings["close"]:                        # look through them and find the closest node
			var sib_dist = abs(s.y - new_node.y)
			if not closest:
				closest = s                         # Record the first node to set the variables
				closest_dist = sib_dist
			elif sib_dist < closest_dist:
				closest = s                         # Record the clossest node and it's distance
				closest_dist = sib_dist
		if closest_dist <= 80:      
			print("merged from " + str(new_node.y) + " to " + str(closest.y))                # If the closest of these nodes is less than or equal to 80...
			new_node.y = closest.y                  # just merge them, connect the line, and end the loop
			
			branch_line.add_point(Vector2(new_node.x + (node_size.w/2),new_node.y + (node_size.h/2)))
			draw_node(new_node)
			
			new_branch.append(new_node)
			crnt_node["branch_" + str(i+1)] = new_branch
			var end = true
			return end
	elif siblings["close"].size() == 1:                    # If there's only 1 node close to new_node...
		closest = siblings["close"][0]
		
		if abs(closest.y - new_node.y) <= 50:
			print("merged node from " + str(new_node.y))
			new_node.y = closest.y
			print("              to " + str(new_node.y))
			
			branch_line.add_point(Vector2(new_node.x + (node_size.w/2),new_node.y + (node_size.h/2)))
			draw_node(new_node)
			
			new_branch.append(new_node)
			crnt_node["branch_" + str(i+1)] = new_branch
			var end = true
			return end
		else:
			print("adjusted node from " + str(new_node.y))
			if closest.y - new_node.y < 0:              # find the direction it's in and set new_node.y 100px away from the close node
				new_node.y = closest.y + 100
			else:
				new_node.y = closest.y - 100
			print("                to " + str(new_node.y))
	clamp_canvas(new_node)
	return false

func clamp_canvas(new_node) -> void:
	if new_node.y < map_canvas.y + 50:
		new_node.y = map_canvas.y + 50
	elif new_node.y > map_canvas.h - 50:
		new_node.y = map_canvas.h - 50

func get_pos_siblings(node) -> Dictionary:
	var all: Array = []
	for node_sib in path_tree:                      # Go through all of the main path tree nodes
		if node_sib.pos == node.pos:                # If a node is in the same position as new_node, add it to the siblings array
			all.append(node_sib)
		if node_sib.branches > 0:                   # If a node has any branches...
			for b_num in node_sib.branches:         # go through all of the nodes in each branch, b_num 
				var b_sib = "branch_" + str(b_num+1)
				for b_node in node_sib[b_sib]:
					if b_node.pos == node.pos:      # If any of those branch nodes are in the same pos, add them to the list as well
						all.append(b_node)
	var close = []
	for s in all:                              # Now go through the list of nodes that share a pos with new_node
		if abs(s.y - node.y) < 100:             # If they're within 100px of new node...
			close.append(s)                    # add them to the close_sibs array to keep track of them
	var sibs_and_close: Dictionary = {"all" = all, "close" = close}
	return sibs_and_close

func get_tree_connectors(node) -> Array:
	var nodes: Array = []
	for s in path_tree:
		if abs(s.pos - node.pos) <= 1:
			nodes.append(s)
	return nodes

func draw_node(node) -> void:
	const NODE_SHAPE = preload("res://path_tree/assets/node_shape.tscn")
	var new_node_shape = NODE_SHAPE.instantiate()
	new_node_shape.position.x = node.x
	new_node_shape.position.y = node.y
	add_child(new_node_shape)
