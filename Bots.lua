Bots = {}
Bots.saved = {}
Bots.shared = {}

Bots.call = function(name, skill, team, delay, altname)
	-- SendServerCommand('addbot ' .. name .. ' ' .. skill .. ' ' .. team .. ' ' .. delay .. ' ' .. altname)
end

-- TODO: насоздавать ботам id

KLib.user_command('addbot', 'admin_bots', function(player, args)
	Bots.call(args[1], args[2], args[3], args[4], args[5])
	KLib.player_console(player, '^2Bot ^1' .. args[1] .. '^2 successfully added')
end)
KLib.user_command('makebot', 'admin_bots', function(player, args)
	table.insert(Bots.saved, args)
	Bots.call(args[1], args[2], args[3], args[4], args[5])
	KLib.player_console(player, '^2Bot ^1' .. args[1] .. '^2 successfully added and saved')
end)
KLib.user_command('sharebot', 'share_bots', function(player, args)
	table.insert(Bots.shared, args)
	KLib.player_console(player, '^2Bot ^1' .. args[1] .. '^2 successfully shared')
end)
KLib.user_command('bots', 'call_bots', function(player, args)
	local user = Account.users[player:GetID()]
	if user['permissions']['admin_bots'] == 1 then
		KLib.player_console(player, '^8====== ^7Saved bots ^8======')
		for k, v in pairs(Bots.saved) do
			KLib.player_console(player, '^1' .. v[1] .. ' ^7(' .. v[2] .. ', ' .. v[3] .. ', ' .. v[4] .. ', ' .. v[5] .. ')')
		end
	end
	-- TODO: сделать надписи there are no shared (saved) bots при отсутствии ботов
	
	KLib.player_console(player, '^8====== ^7Shared bots ^8======')
	for k, v in pairs(Bots.shared) do
		KLib.player_console(player, '^1' .. v[1] .. ' ^7(' .. v[2] .. ', ' .. v[3] .. ', ' .. v[4] .. ', ' .. v[5] .. ')')
	end
end)
KLib.user_command('delbot', 'admin_bots', function(player, args)
	Bots.saved[args[1]] = nil -- ога, да. чтоб некорректно отображалось. чтоб шаренные боты не удалялись
	KLib.player_console(player, '^2Bot ^1' .. args[1] .. '^2 successfully deleted')
end)
KLib.user_command('callbot', 'call_bots', function(player, args)
	KLib.player_console(player, '^2Bot ^1' .. args[1] .. '^2 successfully called')
end)


--[[
	Bots system
		+ addbot <botname> <skill 1-5> <team> <delay> <altname> :: стандартная команда вызова бота (без сохранения)
		+ makebot <botname> <skill 1-5> <team> <delay> <altname> :: создаёт бота на сервере и сохраняет (бот вызывается при старте серва автоматически
		+ sharebot <botname> <skill 1-5> <team> <delay> <altname> :: создаёт расшаренного бота (пользователи могут его вызывать и отзывать)
		+ bots :: список сохранённых ботов
		+ delbot <id>
		- bots :: список расшаренных ботов
		- callbot <botname> :: вызывает расшаренного бота

		cvar klib_bot_limit :: при определённом количестве игроков на сервере боты удаляются, освободить место... или они места не занимают?))
	// TODO: добавить команды для спауна и респауна нпс)
		как вариант:
		+ addnpc <name> <x> <y> <z> <delay> :: создаёт НПС name, респаунящегося с промежутком delay в точке x,y,z
		+ addveh <name> <x> <y> <z> <delay>
		- npcs :: и для npc, и для veh :: существующие, расшаренные, сохранённые
		+ delnpc <id>
		+ killnpc <id>
		+ sharenpc <name> <x> <y> <z> <delay>
		+ shareveh <name> <x> <y> <z> <delay>
		+ allowcallnpc <name> :: позволяет игроку призвать рядом с собой npc
		+ allowcallveh <name>
		- callnpc <id> :: призыв расшаренного НПС (по его id)
		- callnpc <name> :: призыв рядом с собой

	// позволить каждому админу сохранять своих НПС? то есть, именно у себя, а не в общем доступе всех админов
	
	Permissions
		admin_bots +
		share_bots +
		call_bots  -
]]--