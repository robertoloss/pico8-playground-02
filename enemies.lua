mset, add, rnd
=
mset, add, rnd


Enemy = {}
Enemy.__index = Enemy

-- Constructor for creating a new enemy
function Enemy:new(tile_x, tile_y, x, y, velocity_x)
    local instance = {
        map = {
            tile_x = tile_x,
            tile_y = tile_y
        },
        position = {
            x = ((x % 15) * 8),
            y = ((y % 15) * 8)
        },
        init_pos = {
            x = ((x % 15) * 8),
            y = ((y % 15) * 8)
        },
        sprite_init_left = 82,
        sprite_init = 82,
        sprite_init_right = 98,
        sprite_current = 82,
        sprite_increment = 0,
        velocity = {
            x = velocity_x --0.05
        },
        anim_counter = 0
    }
    setmetatable(instance, Enemy)
    return instance
end



local map_width = 128
local map_height = 32

enemies_list = {}

local velocities = {(-0.06), (-0.08), (-0.02), -(0.04), -0.08, -0.1}
function check_map_tiles()
	for x = 0, map_width - 1 do
		for y = 0, map_height - 1 do
			local tile = mget(x, y)
			if fget(tile, 7) then
				local new_enemy = Enemy:new(
					flr(x/15)*15,
					flr(y/15)*15,
					x,
					y,
					rnd(velocities)
				)
				mset(x,y,1)
				add(enemies_list, new_enemy)
			end
		end
	end
end
