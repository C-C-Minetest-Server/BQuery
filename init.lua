local BQbase = {}
function BQbase:new(pos)
	obj = {}
	setmetatable(obj, self)
	self.__index = self
	if type(pos) == "string" then
		pos = minetest.string_to_pos(pos)
		if not pos then
			error("Invalid position!")
		end
	end
	if not (pos.x and pos.y and pos.z) then
		error("Invalid position!")
	end
	self.pos = pos
	return obj
end
function BQbase:name()
	node = minetest.get_node_or_nil(self.pos)
	if not node then
		return nil
	end
	return node.name
end
function BQbase:param1(val)
	node = minetest.get_node_or_nil(self.pos)
	if not node then
		return false
	end
	if not val then
		return node.param1
	end
	node.param1 = val
	minetest.swap_node(self.pos, node)
	return self
end
function BQbase:param2(val)
	node = minetest.get_node_or_nil(self.pos)
	if not node then
		return false
	end
	if not val then
		return node.param2
	end
	node.param2 = val
	minetest.swap_node(self.pos, node)
	return self
end
function BQbase:meta(key,val)
	meta = minetest.get_meta(self.pos)
	if not key then
		return meta
	end
	if not val then
		return meta:get(key)
	end
	if type(val) == "string" then
		meta:set_string(key,val)
	elseif type(val) == "table" then
		error("meta val cannot be table")
	elseif type(val) == "number" then
		x,y = math.modf(val)
		if y ~= 0 then
			meta:set_float(key,val)
		else
			meta:set_int(key,val)
		end
	end
	return self
end
function BQbase:swap(node)
	if type(node) == "string" then
		node = {name=node}
	end
	minetest.swap_node(self.pos,node)
	return self
end
function BQbase:set(node)
	if type(node) == "string" then
		node = {name=node}
	end
	minetest.set_node(self.pos,node)
	return self
end
function BQbase:remove()
	minetest.remove_node(self.pos)
	return self
end
function BQbase:place(node)
	if type(node) == "string" then
		node = {name=node}
	end
	minetest.place_node(self.pos,node)
	return self
end
function BQbase:dig()
	return minetest.dig_node(self.pos)
end
function BQbase:punch()
	minetest.punch_node(self.pos)
	return self
end
function BQ(pos)
	return BQbase:new(pos)
end
