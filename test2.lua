-- test game
-- by me
cls, btn, spr, time, cocreate, coresume, map, mget, flr, stat
=
cls, btn, spr, time, cocreate, coresume, map, mget, flr, stat
game_map = {
	x = 0,
	y = 0,
}
function _init()
	make_keymap()
	check_map_tiles()
end

function _update60()
	key_checker()
	move_player()
	animate_player()
end

function _draw()
	cls() --clear screen
	map(game_map.x,game_map.y,0,0,16,16)
	draw_player()
	draw_enemies()
	print(game_map.x, 0, 0, 10)
	--print(game_map.y, 0, 8, 10)
end

function draw_enemies()
	for i,e in ipairs(enemies_list) do
		if game_map.x == e.map.tile_x and game_map.y == e.map.tile_y then
			e.position.x = e.position.x + e.velocity.x
			if e.position.x <= (e.init_pos.x - 24) or e.position.x >= e.init_pos.x then
				e.velocity.x = -e.velocity.x
			end
			if e.velocity.x > 0 then
				e.sprite_current = e.sprite_init_right
			else
				e.sprite_current = e.sprite_init_left
			end
			e.anim_counter = e.anim_counter + 1
			if e.anim_counter > 16 then
				e.sprite_increment = 1
			end
			if e.anim_counter > 32 then
				e.sprite_increment = 0
				e.anim_counter = 0
			end
			spr(e.sprite_current + e.sprite_increment, e.position.x, e.position.y)
		end
	end
end

function draw_player()
	if player.fire then
		if player.fire_count < 16 then
			if player.facing == 'right' then
				spr(3, player.position.x,player.position.y)
				spr(4, player.position.x + 8,player.position.y)
			else
				spr(51, player.position.x,player.position.y)
				spr(50, player.position.x - 8,player.position.y)
			end
			player.fire_count = player.fire_count + 1
		else
			player.fire_count = 0
			player.fire = false
		end
	else
		spr(player.sprite_current, player.position.x,player.position.y)
	end
	if hit then
		local x = (player.position.x + player.velocity.x + 14)
		local y = (player.position.y + player.velocity.y)
		local xx,yy = get_tile_coord(x,y)[1],get_tile_coord(x,y)[2]
		mset(xx,yy,1)
	end
end

function my_debug()
	print(player.position.x, 40, 5, 7)
	print(player.position.y, 40, 10, 7)
	print(collision.right, 1,0,7)
	print(collision.left, 1,6,7)
	print(collision.top, 1,12, 7)
	print(collision.bottom, 1, 18, 7)
	print("vx: ", 1, 24, 10)
	print(vx, 15, 24, 10)
	print("vy: ", 1, 30, 10)
	print(vy, 15, 30, 10)
	print(stat(1))
	print(new_x_position)
	print(flr_new_x_position)
	-- print(tru)
	-- print(trd)
	-- print(tlu)
	-- print(tld)
	-- print(tur)
	-- print(tul)
end

function make_keymap()
	keys = {}
	for i = 0,5 do
		keys[i] = false
	end
	keys_previous = {}
	for i = 0,5 do
		keys_previous[i] = false
	end
end

function key_down(key)
	return keys[key] and not keys_previous[key]
end

function key_up(key)
	return not keys[key] and keys_previous[key]
end

function key_checker()
	for i=0,5 do
		keys_previous[i] = keys[i]
		keys[i] = btn(i)
	end
end




