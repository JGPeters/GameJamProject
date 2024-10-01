extends movement_component

#var movement_node : movement_component
#var movement_attributes : Array[movement_attribute] = []

#func init(_param) -> void:
	#get_owner().set_meta("can_move", true)
	#for comp in get_children():
		#if comp is movement_component:
			#if movement_node:
				#print("Multiple movement components assigned to %s, using first one" % self)
			#else:
				#movement_node = comp
		#if comp is movement_attribute:
			#movement_attributes.append(comp)
		#if comp != movement_node:
				#comp.init(null)
	#if !movement_node:
		#print("No movement component assigned to %s" % self)
	#else:
		#if movement_attributes.size() < 1:
			#print("No movement attributes assigned")
		#else:
			#movement_node.init(movement_attributes)
