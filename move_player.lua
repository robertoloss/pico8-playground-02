fget, sfx, ceil = fget, sfx, ceil
gravity = 0.15
jump = -2.2
--h_increase = 1
h_increase = 0.5
sprite_count_limit = 5
spritesheet_length = 3
player = {
	sprite_count = 0,
	position = {
		x = 64,
		y = 112,
	},
	velocity = {
		x = 0,
		y = 0,
	},
	old_velocity = {
		x = 0,
		y = 0
	},
	rem = {
		x = 0,
		y = 0,
	},
	sprite_current = 25,
	sprite_init = 25,
}

function fl(num)
	return flr(num / 8)
end

function get_tile(x,y)
	return mget(fl(x + (game_map.x * 8)),fl(y + (game_map.y * 8)))
end

function check_collision()
	vx = player.velocity.x
	vy = player.velocity.y
	x = player.position.x
	y = player.position.y
	-- up
	tul = get_tile(x, y+vy)
	tur = get_tile(x+7, y+vy)
	-- down
	tdl = get_tile(x, y+7+vy)
	tdr = get_tile(x+7, y+7+vy)
	-- left
	tlu = get_tile(x+vx, y)
	tld = get_tile(x+vx, y+7)
  -- right
	tru = get_tile(x+vx+7, y)
	trd = get_tile(x+vx+7, y+7)
	-- collisions
	collision = {
		top = false,
		bottom = false,
		right = false,
		left = false
	}
	if vx > 0 then collision.right = fget(trd, 0) or fget(tru, 0) end
	if vx < 0 then collision.left = fget(tld, 0) or fget(tlu, 0) end
	if vy > 0 then collision.bottom = fget(tdl, 0) or fget(tdr, 0) end
	if vy < 0 then collision.top = fget(tur, 0) or fget(tul, 0) end
end

function manage_collision(x,y)
	if collision.bottom then
		player.position.y = fl(y+8+vy)*8 - 8
		player.velocity.y = 0
	end
	if collision.top then
		player.position.y = fl(y+vy)*8 + 8
		player.velocity.y = 0
	end
	if collision.right then
		player.position.x = fl(x+8+vx)*8 - 8
		player.velocity.x = 0
	end
	if collision.left then
		player.position.x = fl(x+vx)*8 + 8
		player.velocity.x = 0
	end
end

function move_player()
	player.sprite_count = player.sprite_count + 1;
	if player.sprite_count == sprite_count_limit then
		player.sprite_current = player.sprite_current + 1;
		if player.sprite_current == player.sprite_init + spritesheet_length then
			player.sprite_current = player.sprite_init;
		end
		player.sprite_count = 0
	end



	if btn(0) then
		player.go_left = true
	end
	if btn(1) then
		player.go_right = true
	end
	if btn(2) then
		player.go_up = true
	end
	if btn(3) then
		player.go_down = true
	end
	if key_up(0) then player.go_left = false end
	if key_up(1) then player.go_right = false end
	if key_up(2) then player.go_up = false end
	if key_up(3) then player.go_down = false end

	if key_down(4) then
		player.old_velocity.y = player.velocity.y
		player.velocity.y = jump
		sfx(0)
	end

	if player.go_left then
		player.old_velocity.x = player.velocity.x
		player.velocity.x = -h_increase
	elseif player.go_right then
		player.old_velocity.x = player.velocity.x
		player.velocity.x = h_increase
	else
		player.old_velocity.x = player.velocity.x
		player.velocity.x = 0
	end

	if player.velocity.y < 3 then
		player.old_velocity.y = player.velocity.y
		player.velocity.y = player.velocity.y + gravity
	end

	check_collision()
	manage_collision(player.position.x, player.position.y)

	new_x_position = player.position.x + player.velocity.x
	flr_new_x_position = flr(new_x_position + 0.5)

	player.position.x = new_x_position
	player.position.y = player.position.y  + player.velocity.y
	if player.velocity.x > 0 and not (player.old_velocity.x > 0) then
		player.sprite_init = 19
		player.sprite_current = 19
	end
	if player.velocity.x < 0 and not (player.old_velocity.x < 0) then
		player.sprite_init = 35
		player.sprite_current = 35
	end
	if player.velocity.x == 0 and (player.old_velocity.x < 0) then
		player.sprite_init = 41
		player.sprite_current = 41
	end
	if player.velocity.x == 0 and (player.old_velocity.x > 0) then
		player.sprite_init = 25
		player.sprite_current = 25
	end

	if (player.position.x > 124) then
		player.position.x = 0
		game_map.x = 15
	end
	if (player.position.x < 0) then
		player.position.x = 124
		game_map.x = 0
	end
end
