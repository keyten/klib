Account = {}
Account.reg_users = {} -- имя: таблица юзера
Account.users = {} -- id: таблица
Account.groups = { registered={
	-- Accounts
		admin_user=0,
		permissions=0,
		ranks=0,
		show_users=0,
	-- Economic
		see_money=1,
		grant_money=1,
		admin_money=0,
	-- Entity
		-- nothing
	-- Teleports
		-- nothing
	-- Messages
		send_message=1,
		see_message=1,
	-- Shop
		-- nothing
	-- Statistic
		see_stats=1,
		see_stats_other=0,
	-- Bans
		-- nothing
	-- Adminsay
		-- nothing
	-- Remap
		remap=0,
		remap_saved=0,
		remap_shared=1,
		remap_save=0,
		remap_share=0,
		remap_block=0,
	-- Cheat
		-- nothing
}, unregistered={
	-- Accounts
		admin_user=0,
		permissions=0,
		ranks=0,
		show_users=0,
	-- Economic
		see_money=0,
		grant_money=0,
		admin_money=0,
	-- Entity
		-- nothing
	-- Teleports
		-- nothing
	-- Messages
		send_message=0,
		see_message=0,
	-- Shop
		-- nothing
	-- Statistic
		see_stats=0,
		see_stats_other=0,
	-- Bans
		-- nothing
	-- Adminsay
		-- nothing
	-- Remap
		remap=0,
		remap_saved=0,
		remap_shared=1,
		remap_save=0,
		remap_share=0,
		remap_block=0,
	-- Cheat
		-- nothing
} }


-- Player class
--[[ local playerclass = GetPlayerTable()
playerclass.console = function(ply, msg)
	SendReliableCommand(ply:GetID(), string.format('print "%s\n"', tostring(msg)))
end ]]--

-- register <nick> <pass> <pass>
AddClientCommand('register', function(player, args)
	
	-- уже авторизован?
	if Account.users[player:GetID()] ~= nil then
		KLib.player_console(player, Locale.loggedin)
		return
	end
	
	-- неправильное использование
	if #args < 3 then
		KLib.player_console(player, Locale.register_using)
		return
	end

	local name = args[1]
	local pass1 = args[2]
	local pass2 = args[3]
	
	-- пароли не совпадают
	if pass1 ~= pass2 then
		KLib.player_console(player, Locale.register_pdnm)
		return
	end

	-- пользователь существует
	if Account.reg_users[name] then
		KLib.player_console(player, Locale.register_exist)
		return
	end
	
	-- проверка имени на соответствие
	if string.match(name, '^[a-zA-Z_][a-zA-Z0-9-_]+$') == nil then
		KLib.player_console(player, Locale.register_badname)
		return
	end
	
	local len = string.len(name)
	if len < 3 then
		KLib.player_console(player, Locale.register_shortname)
		return
	end
	if len > 36 then
		KLib.player_console(player, Locale.register_longname)
		return
	end
	if string.len(pass1) < 6 then
		KLib.player_console(player, Locale.register_shortpass)
		return
	end


	-- регистрируем
	local user = {}
	user['name'] = name
	user['pass'] = pass1
	user['group'] = 'registered'
	user['permissions'] = Account.groups['registered'] -- необходимо сделать копирование
	-- иначе пишется ссылка на объект, и при любом изменении прав юзера будут меняться права его группы

	Account.reg_users[name] = user
	Account.users[player:GetID()] = user
	KLib.player_console(player, Locale.registered)
end)

AddListener('JPLUA_EVENT_CLIENTDISCONNECT', function(player)
	if Account.users[player:GetID()] ~= nil then
		Account.users[player:GetID()] = nil
	end
end)

-- login <nick> <pass>
AddClientCommand('login', function(player, args)

	-- уже авторизован?
	if Account.users[player:GetID()] ~= nil then
		KLib.player_console(player, Locale.loggedin)
		return
	end
	
	local login = args[1]
	local pass = args[2]
	-- неправильное использование
	if #args < 2 then
		KLib.player_console(player, Locale.login_using)
		return
	end

	local user = Account.reg_users[login]
	if user == nil then
		KLib.player_console(player, Locale.login_userwrong)
		return
	end

	if user['pass'] ~= pass then
		KLib.player_console(player, Locale.login_passwrong)
		return
	end

	KLib.player_console(player, Locale.login_success)
	Account.users[player:GetID()] = user
end)

-- logout
AddClientCommand('logout', function(player, args)

	-- не авторизован?
	if Account.users[player:GetID()] == nil then
		KLib.player_console(player, Locale.out_loggedin)
		return
	end
	
	Account.users[player:GetID()] = nil
	KLib.player_console(player, Locale.logged_out)
end)


KLib.user_command('createuser', 'admin_user', function(player, args)
	-- неправильное использование
	if #args < 3 then
		KLib.player_console(player, Locale.createuser_using)
		return
	end

	local name = args[1]
	local pass1 = args[2]
	local pass2 = args[3]
	local group = args[4]
	if group == nil then
		group = 'registered'
	end

	-- группы не существует
	if Account.groups[group] == nil then
		KLib.player_console(player, Locale.group_isnotexist)
		return
	end

	-- пароли не совпадают
	if pass1 ~= pass2 then
		KLib.player_console(player, Locale.register_pdnm)
		return
	end

	-- пользователь существует
	if Account.reg_users[name] then
		KLib.player_console(player, Locale.register_exist)
		return
	end
	
	-- проверка имени на соответствие
	if string.match(name, '^[a-zA-Z_][a-zA-Z0-9-_]+$') == nil then
		KLib.player_console(player, Locale.register_badname)
		return
	end
	
	local len = string.len(name)
	if len < 3 then
		KLib.player_console(player, Locale.register_shortname)
		return
	end
	if len > 36 then
		KLib.player_console(player, Locale.register_longname)
		return
	end
	if string.len(pass1) < 6 then
		KLib.player_console(player, Locale.register_shortpass)
		return
	end


	-- регистрируем
	local user = {}
	user['name'] = name
	user['pass'] = pass1
	user['group'] = group
	user['permissions'] = Account.groups[group]

	Account.reg_users[name] = user
	KLib.player_console(player, Locale.created_user)
end)

KLib.user_command('user', 'show_users', function(player, args)
	-- неправильное использование
	if args[1] == nil then
		KLib.player_console(player, Locale.user_using)
		return
	end

	local name = args[1]

	-- пользователь не существует
	if Account.reg_users[name] == nil then
		KLib.player_console(player, Locale.user_isnotexist)
		return
	end

	-- находим
	local user = Account.reg_users[name]
	KLib.player_console(player, '^3=========== ^8' .. user['name'] .. ' ^3===========')
	local group = user['group']
	if user['permissions'] ~= Account.groups[group] then
		group = group .. Locale.user_group_changed
	end
	KLib.player_console(player, Locale.user_group .. user['group'])
	KLib.player_console(player, Locale.user_last_visit .. 'unknown')
	KLib.player_console(player, Locale.user_last_ip .. 'unknown')
end)

KLib.user_command('rank', 'ranks', function(player, args)
	local len = #args
	local name = args[1]
	local group
	local k
	if not Account.groups[name] then
		Account.groups[name] = KLib.copy(Account.groups['registered'])
	end
	group = Account.groups[name]
	for k = 2, len do
		group[args[k]] = 1
		KLib.player_console(player, name .. Locale.rank_has .. args[k])
	end
end)

KLib.user_command('rankuser', 'admin_user', function(player, args)
	local name = args[1]
	local group = args[2]

	-- пользователь не существует
	if Account.reg_users[name] == nil then
		KLib.player_console(player, Locale.user_isnotexist)
		return
	end

	-- группы не существует
	if Account.groups[group] == nil then
		KLib.player_console(player, Locale.group_isnotexist)
		return
	end

	local user = Account.reg_users[name]
	user['group'] = group
	user['permissions'] = Account.groups[group]
	KLib.player_console(player, Locale.user_ranked)
end)

KLib.user_command('givepermission', 'permissions', function(player, args) end)
KLib.user_command('removepermission', 'permissions', function(player, args) end)

KLib.user_command('logoutuser', 'admin_user', function(player, args) end)
KLib.user_command('deluser', 'admin_user', function(player, args) end)
KLib.user_command('tempuser', 'admin_user', function(player, args) end)
KLib.user_command('users', 'show_users', function(player, args) end)
KLib.user_command('lastusers', 'show_users', function(player, args) end)
KLib.user_command('lastregister', 'show_users', function(player, args) end)

--[[
	Account system
		- login <nick> <pass>
		- logout
		- register <nick> <pass> <pass>
		+ createuser <nick> <pass> <pass> :: создаёт юзера без релогина (можно из-под админа регить)
		+ user <user> :: показывает информацию о пользователе (время регистрации, IP, группа, права)
		+ givepermission <user> <perm1>, <perm2>, ...
		+ removepermission <user> <perm1>, <perm2>, ...
		+ rank <groupname> <permission1>, ... :: создаёт новую группу прав / изменяет права
		+ rankuser <user> <groupname> :: применяет к пользователю группу прав (после применения можно изменять права, тогда группа будет <ИМЯГРУППЫ (changed)>
		+ logoutuser <user> :: разлогинивает юзера
		+ deluser <user>
		+ tempuser <name|null> <player> <group|permissions> :: делает игрока с id/ником player админом с именем name (временно, после перезахода сбрасывается)
-- не нужно: будет $id / $nick		+ markplayer <player> <name> :: помечает игрока player как юзера user (многие команды, такие как mark <user> и tele <user> требуют юзера) :: видно только админам; игрок не уведомляется, доп.прав не даётся -- в отличие от tempuser
		+ users :: показывает залогиненных юзеров
		+ users <groupname> <groupname2> ... :: пользователей групп (учитывая юзеров с изменёнными правами группы, но отображаются другим цветом). 
		+ lastusers :: последние логины
		+ lastregister
	// стандартная группа незалогиненных пользователей -- unregistered, им можно давать права и т.д.
	// стандартная группа залогиненных пользователей -- registered
	// также игрока вместо юзера можно использовать, указывая $1, $2, $*id* -- по его id, а также $nickname
]]--

--[[
	Permissions system
		Account
			- admin_user (createuser, logoutuser, deleteuser, tempuser)
			- permissions
			- ranks
			- show_users (users / lastusers / lastregister)
		
]]--