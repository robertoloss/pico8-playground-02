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
end

function _update60()
	key_checker()
	move_player()
end

function _draw()
	cls() --clear screen
	map(0,0,game_map.x,game_map.y,16,16)
	draw_player()
end

function draw_player()
	spr(player.sprite_current, player.position.x,player.position.y)
	print(player.position.x)
	-- my_debug()
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




