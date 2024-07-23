fget = fget
gravity = 0				--0.4
jump = -3.5
h_increase = 1
player = {
	position = {
		x = 64,
		y = 112,
	},
	velocity = {
		x = 0,
		y = 0,
	},
	sprite = 18
}

function fl(num)
	return flr(num / 8)
end

function get_tile(x,y)
	return mget(fl(x),fl(y))
end

collision = {
	top = false,
	bottom = false,
	right = false,
	left = false
}

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

	if vx > 0 then
		collision.right = fget(trd, 0) or fget(tru, 0)
	else
		collision.right = false
	end
	if vx < 0 then
		collision.left = fget(tld, 0) or fget(tlu, 0)
	else
		collision.left = false
	end
	if vy > 0 then
		collision.bottom = fget(tdl, 0) or fget(tdr, 0)
	else collision.bottom = false
	end
	if vy < 0 then collision.top = fget(tur, 0) or fget(tul, 0)
		else collision.top = false
	end
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

	if key_down(4) then player.velocity.y = jump end

	if player.go_left then
		player.velocity.x = -h_increase
	elseif player.go_right then
		player.velocity.x = h_increase
	else
		player.velocity.x = 0
	end
	if player.go_up then
		player.velocity.y = -h_increase
	elseif player.go_down then
		player.velocity.y = h_increase
	else
		player.velocity.y = 0
	end

	if player.velocity.y < 3 then
		player.velocity.y = player.velocity.y + gravity
	end

	check_collision()
	manage_collision(player.position.x, player.position.y)

	player.position.x = player.position.x + player.velocity.x
	player.position.y = player.position.y + player.velocity.y
end
