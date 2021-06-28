local function build_box(pos, clicker, itemstack, size)
	local half_size = math.floor(size / 2)
	for y=pos.y,pos.y+size-1 do
		for z=pos.z-half_size,pos.z+half_size do
			for x=pos.x-half_size,pos.x+half_size do
				if x == pos.x-half_size or x == pos.x+half_size or y == pos.y or y == pos.y+size-1 or z == pos.z-half_size or z == pos.z+half_size then
					if minetest.get_node({x=x, y=y, z=z}).name == "air" then
						local name = itemstack:get_name()
						if itemstack:get_count() > 0 and minetest.registered_nodes[name] then
							minetest.set_node({x=x, y=y, z=z}, {name=name})
							if not minetest.is_creative_enabled(clicker) then
								itemstack:take_item(1)
							end
						end
					end
				end
			end
		end
	end
end

local function register_fast_build_tool(size)
	minetest.register_node("fast_build_tool:"..size.."x"..size.."x"..size, {
		description = "Fast Build Tool "..size.."x"..size.."x"..size,
		tiles = {"default_wood.png^default_tool_steelaxe.png"},
		paramtype2 = "facedir",
		place_param2 = 0,
		is_ground_content = false,
		groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, wood = 1},
		sounds = default.node_sound_wood_defaults(),
		on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
			build_box(pos, clicker, itemstack, size)
		end,
	})
end

local i = 5
while i <= 21 do
	register_fast_build_tool(i)
	i = i + 2
end

local i = 5
while i <= 21 do
	local result
	if i ~= 21 then
		result = "fast_build_tool:"..(i + 2).."x"..(i + 2).."x"..(i + 2)
	else
		result = "fast_build_tool:5x5x5"
	end
	minetest.register_craft({
		output = result,
		recipe = {
			{"fast_build_tool:"..i.."x"..i.."x"..i},
		}
	})
	i = i + 2
end

minetest.register_craft({
	output = "fast_build_tool:5x5x5",
	recipe = {
		{"", "group:wood", ""},
		{"group:wood", "default:mese_crystal", "group:wood"},
		{"", "group:wood", ""},
	}
})
