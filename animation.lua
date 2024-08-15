


function animate_player()
	player.sprite_count = player.sprite_count + 1;
	if player.sprite_count == sprite_count_limit then
		player.sprite_current = player.sprite_current + 1;
		if player.sprite_current == player.sprite_init + spritesheet_length then
			player.sprite_current = player.sprite_init;
		end
		player.sprite_count = 0
	end
	if player.velocity.x > 0 or
		(player.velocity.x == 0 and player.old_velocity.x >= 0) then
		player.facing = 'right'
	else
		player.facing = 'left'
	end
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
end
