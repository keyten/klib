local plugin = RegisterPlugin("KLib", "1.0")
KLib = {}
KLib.version = 1.0

-- Locale loading --
KLib.init = function()
	require('Klib/Locale/En.lua')
	if Locale then
		print('-----Klib: En Locale loaded-----')
	else
		print('-----^1Klib error: En Locale is not loaded-----')
	end


	-- Modules loading --
	require('Klib/Account.lua')
	if Account then
		print('-----Klib: Account system loaded-----')
	else
		print('-----^1Klib error: Account system is not loaded-----')
	end
	--[[
	require('Klib/Economic.lua')
	if Economic then
		print('-----Klib: Economic system loaded-----')
	else
		print('-----^1Klib error: Economic system is not loaded-----')
	end

	require('Klib/Entity.lua')
	if Entity then
		print('-----Klib: Entity system loaded-----')
	else
		print('-----^1Klib error: Entity system is not loaded-----')
	end

	require('Klib/Teleports.lua')
	if Teleports then
		print('-----Klib: Teleports system loaded-----')
	else
		print('-----^1Klib error: Teleports system is not loaded-----')
	end

	require('Klib/Messages.lua')
	if Messages then
		print('-----Klib: Messages system loaded-----')
	else
		print('-----^1Klib error: Messages system is not loaded-----')
	end

	require('Klib/Shops.lua')
	if Shops then
		print('-----Klib: Shops system loaded-----')
	else
		print('-----^1Klib error: Shops system is not loaded-----')
	end

	require('Klib/Statistic.lua')
	if Statistic then
		print('-----Klib: Statistic system loaded-----')
	else
		print('-----^1Klib error: Statistic system is not loaded-----')
	end

	require('Klib/Bans.lua')
	if Bans then
		print('-----Klib: Bans system loaded-----')
	else
		print('-----^1Klib error: Bans system is not loaded-----')
	end

	require('Klib/Adminsay.lua')
	if Adminsay then
		print('-----Klib: Adminsay system loaded-----')
	else
		print('-----^1Klib error: Adminsay system is not loaded-----')
	end

	require('Klib/Remap.lua')
	if Remap then
		print('-----Klib: Remap system loaded-----')
	else
		print('-----^1Klib error: Remap system is not loaded-----')
	end

	require('Klib/Clans.lua')
	if Clans then
		print('-----Klib: Clans system loaded-----')
	else
		print('-----^1Klib error: Clans system is not loaded-----')
	end

	require('Klib/Cheat.lua')
	if Cheat then
		print('-----Klib: Cheat system loaded-----')
	else
		print('-----^1Klib error: Cheat system is not loaded-----')
	end ]]--
end

-- Functions --
KLib.player_console = function(player, msg)
	if not player:IsBot() then
		SendReliableCommand(player:GetID(), string.format('print "%s\n"', tostring(msg)))
	end
end
KLib.error = function(msg)
	print('^1KLib error: ' .. msg)
end
KLib.copy = function(tab)
	local res = {}
	for k, v in pairs(tab) do
		res[k] = v
	end
	return res
end

-- Commands --
KLib.user_command = function(name, perm, func)
	AddClientCommand(name, function(player, arg)
		local user = Account.users[player:GetID()]
		local permissions
		if user then
			permissions = user['permissions']
		else
			permissions = Account.groups['unregistered']
		end
		if permissions[perm] ~= 1 then
			KLib.player_console(player, Locale.permission_deny)
			return
		end
		func(player, arg)
	end)
end


-- Save / Load --
KLib.LoadData = function()
	local ser = GetSerialiser('klib.dat', FSMode.READ)
	if ser == nil then
		KLib.error(Locale.error_loaddata)
		KLib.SaveData()
	end
	Account.reg_users = ser:ReadTable('accounts')
	ser:Close()
	ser = nil
end

KLib.SaveData = function()
	local ser = GetSerialiser('klib.dat', FSMode.WRITE)
	if ser == nil then
		KLib.error(Locale.error_loaddata)
	end
	ser:AddTable('accounts', Account.reg_users)
	ser:Close()
	ser = nil
end

KLib.init()
AddListener('JPLUA_EVENT_UNLOAD', KLib.SaveData)
KLib.LoadData()

--[[ Спецификация
- Обычная команда
+ Админ-команда

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


	Economic system
	// economic system включается cvar-ом klib_economic 1
		- money :: показывает кол-во денег
		+ money <num> :: устанавливает
		+ money <user> :: показывает
		+ money <user> <num>
		- grant <user> <moneys> :: передаёт свои деньги другому юзеру
		+ grant <user1> <user2> <money>
		+ lost <user> <moneys> :: забирает у юзера некоторые деньги )

	Entity system
	// entity system может быть доступным всем с помощью cvar-а klib_entity_guest 1
	// либо же правами 
		+ mark
		+ mark <x> <y> <z>
		+ mark <user>
		+ markoffset <x> <y> <z>
		+ markoffset <user> <x> <y> <z>
		+ markt
		+ marktoffset <x> <y> <z>
		+ grabbing <1|0> :: стандартно 0
		+ arm <-500 - 500> :: максимум и минимум меняются klib_entity_maxarm и klib_entity_minarm
		+ grab
		+ drop

		+ place <entity> <vars> :: создаёт в точке mark-а
		+ place <model> :: создаёт misc_model
		+ placefx <fx> <a> <b> :: создаёт fx_runner
		+ rotate <x> <y> <z> (<dur> <easing>)
		+ move <x> <y> <z> (<dur> <easing>)
		+ move <distance> (<dur> <easing>)
		+ select
		+ select <id>
		+ select <name>
		+ setname <name>
		+ objects
		+ objects <page>
		+ saveobjects :: сохраняет всё на карте
		+ savedobjects

	Teleports system
		- origin
		- sayorigin :: простым юзерам -- ограничение раз в 5 секунд )
		- sayorigin <user>
		+ sayorigin <x> <y> <z>
		+ sayorigin <user> <x> <y> <z>
		- telelast :: телепортирует по sayorigin
		+ telemark :: телепортирует в mark
		+ tele <x> <y> <z>
		+ tele <user> :: телепортирует себя к юзеру
		+ tele <user> <x> <y> <z> :: телепортирует юзера
		+ tele <player>
		+ telet
		+ maketeleport <user> <x> <y> <z> :: создаёт телепорт рядом с юзером (эффект типа env/btend)
		+ maketeleport <fx> <fy> <fz> <tx> <ty> <tz> :: создаёт телепорт в точке from в точку to
		+ onceteleport :: делает последний созданный телепорт одноразовым (закрывается после использования)
		+ teleports :: показывает все существующие телепорты (координаты начальные, конечные, количество использований, id)
		+ closeteleport <id>
		+ closeteleports

	Messages system
		- message <user> <message>
		- messages
		- messages <page>
		- messages new
		- messages <user>
	// неа, администрация не может читать переписку :)
	// хотя она могет влезть в исходники и написать функцию для этого...
		+ msgrank <rank1,rank2> <message>

	Shops system
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

	Statistic system
		- stats :: показывает последний заход, ip, смерти, убийства, проигранные / выигранные дуэли, дамаг
		+ stats <user>

	Bans system
		+ bans
		+ kick <user>
		+ ban <user>
		
	Chat system
		// игнор, молчанки, игнор ботов, игнор дуэлей, игнор подключений, каналы

	Adminsay system
	Remap system
		+ remap <shaderfrom> <shaderto>
		- remap <name> :: применяет сохранённый ремап
		- remaps :: показывает сохранённые
		+ remap list :: показывает применённые
		+ remap save <name> <shader1from>,<shader1to> ... :: сохраняет ремап под именем (недоступный для обычных юзеров)
		+ remap share <name> <shader1from>,<shader1to> <shader2from>,<shader2to> ... :: создаёт расшаренный (доступный для переключения всем юзерам!) ремап.
		+ remap block :: блокирует на 5 минут расшаренные ремапы )
		+ remap block <time>

		// администрация серва может создать несколько доступных всем юзерам ремапов, и пусть переключают
			// мб, сделать по-другому: после применения расшаренного ремапа юзеры не могут переключать ремап в течение 5 минут автоматом

	Cheat system
		+ god
		+ god <user>
		+ undying :: 999 хп? и как бы?
		+ undying <user>
		+ health
		+ health <user>
		+ health <user> <health>
		+ health <user> <+|-health> :: прибавляет / отнимает
		+ armor
		+ armor <user>
		+ armor <user> <armor>
		+ armor <user> <+|-armor>
		+ kill
		+ kill <user>
		+ weapon <weap1>, <weap2>, ... :: даёт
		+ weapon <user> <weap1>, ...
		+ ammo
		+ ammo <user>
		+ weapons
		+ weapons <user>
		+ npc :: показывает всех npc (и игроков, их заспаунящих)
		+ npc spawn <npc> <name>
		+ npc spawn vehicle <veh> <name>
		+ npc kill all
		+ npc kill everything :: бОльший приоритет (если есть юзер everything, то он не перебивает)
		+ npc kill <name>
		+ npc kill <user>
		+ empower
		+ empower <user>
		+ notarget
		+ notarget <user>

	Clan system
	// clan system включается klib_clan 1
		- registerclan <name> <pass> <pass> :: по умолчанию у unregistered нет права register_clan, и регистрация отправляется на премодерацию к админам (!) -- право admin_clans.
		- clan <myclan> <pass> :: логинит в клан. Если зарегистрированный юзер - логин сохраняется и логинит вместе с обычным логином. Если нет -- сохраняется в течение текущей сессии.
		- clanmsg <message> :: доступно для залогиненных в клане -- отправляет сообщение в клан-чат (его видят все, кто сейчас на серве из клана; есть возможность просмотра последних сообщений).
		- clanmsg :: показывает последние сообщения в клане
		+ delclan <name>
		+ sayclan <name> <msg> :: можно сказать что-то в какой-то клан, но нельзя читать, не будучи в нём зарегистрированным

	// если зашёл юзер с тегом незарегистрированного клана -- выдаётся предложение зарегистрировать клан
	// если зашёл юзер с тегом зарегистрированного клана, но незалогиненный -- выдаётся предложение залогиниться
	// если отказывается -- при cvar klib_clan_offdeny 1 тег из ника удаляется.

















]]--