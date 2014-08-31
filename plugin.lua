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

--[[ ������������
- ������� �������
+ �����-�������

	Account system
		- login <nick> <pass>
		- logout
		- register <nick> <pass> <pass>
		+ createuser <nick> <pass> <pass> :: ������ ����� ��� �������� (����� ��-��� ������ ������)
		+ user <user> :: ���������� ���������� � ������������ (����� �����������, IP, ������, �����)
		+ givepermission <user> <perm1>, <perm2>, ...
		+ removepermission <user> <perm1>, <perm2>, ...
		+ rank <groupname> <permission1>, ... :: ������ ����� ������ ���� / �������� �����
		+ rankuser <user> <groupname> :: ��������� � ������������ ������ ���� (����� ���������� ����� �������� �����, ����� ������ ����� <��������� (changed)>
		+ logoutuser <user> :: ������������� �����
		+ deluser <user>
		+ tempuser <name|null> <player> <group|permissions> :: ������ ������ � id/����� player ������� � ������ name (��������, ����� ���������� ������������)
-- �� �����: ����� $id / $nick		+ markplayer <player> <name> :: �������� ������ player ��� ����� user (������ �������, ����� ��� mark <user> � tele <user> ������� �����) :: ����� ������ �������; ����� �� ������������, ���.���� �� ����� -- � ������� �� tempuser
		+ users :: ���������� ������������ ������
		+ users <groupname> <groupname2> ... :: ������������� ����� (�������� ������ � ���������� ������� ������, �� ������������ ������ ������). 
		+ lastusers :: ��������� ������
		+ lastregister
	// ����������� ������ �������������� ������������� -- unregistered, �� ����� ������ ����� � �.�.
	// ����������� ������ ������������ ������������� -- registered
	// ����� ������ ������ ����� ����� ������������, �������� $1, $2, $*id* -- �� ��� id, � ����� $nickname


	Economic system
	// economic system ���������� cvar-�� klib_economic 1
		- money :: ���������� ���-�� �����
		+ money <num> :: �������������
		+ money <user> :: ����������
		+ money <user> <num>
		- grant <user> <moneys> :: ������� ���� ������ ������� �����
		+ grant <user1> <user2> <money>
		+ lost <user> <moneys> :: �������� � ����� ��������� ������ )

	Entity system
	// entity system ����� ���� ��������� ���� � ������� cvar-� klib_entity_guest 1
	// ���� �� ������� 
		+ mark
		+ mark <x> <y> <z>
		+ mark <user>
		+ markoffset <x> <y> <z>
		+ markoffset <user> <x> <y> <z>
		+ markt
		+ marktoffset <x> <y> <z>
		+ grabbing <1|0> :: ���������� 0
		+ arm <-500 - 500> :: �������� � ������� �������� klib_entity_maxarm � klib_entity_minarm
		+ grab
		+ drop

		+ place <entity> <vars> :: ������ � ����� mark-�
		+ place <model> :: ������ misc_model
		+ placefx <fx> <a> <b> :: ������ fx_runner
		+ rotate <x> <y> <z> (<dur> <easing>)
		+ move <x> <y> <z> (<dur> <easing>)
		+ move <distance> (<dur> <easing>)
		+ select
		+ select <id>
		+ select <name>
		+ setname <name>
		+ objects
		+ objects <page>
		+ saveobjects :: ��������� �� �� �����
		+ savedobjects

	Teleports system
		- origin
		- sayorigin :: ������� ������ -- ����������� ��� � 5 ������ )
		- sayorigin <user>
		+ sayorigin <x> <y> <z>
		+ sayorigin <user> <x> <y> <z>
		- telelast :: ������������� �� sayorigin
		+ telemark :: ������������� � mark
		+ tele <x> <y> <z>
		+ tele <user> :: ������������� ���� � �����
		+ tele <user> <x> <y> <z> :: ������������� �����
		+ tele <player>
		+ telet
		+ maketeleport <user> <x> <y> <z> :: ������ �������� ����� � ������ (������ ���� env/btend)
		+ maketeleport <fx> <fy> <fz> <tx> <ty> <tz> :: ������ �������� � ����� from � ����� to
		+ onceteleport :: ������ ��������� ��������� �������� ����������� (����������� ����� �������������)
		+ teleports :: ���������� ��� ������������ ��������� (���������� ���������, ��������, ���������� �������������, id)
		+ closeteleport <id>
		+ closeteleports

	Messages system
		- message <user> <message>
		- messages
		- messages <page>
		- messages new
		- messages <user>
	// ���, ������������� �� ����� ������ ��������� :)
	// ���� ��� ����� ������ � ��������� � �������� ������� ��� �����...
		+ msgrank <rank1,rank2> <message>

	Shops system
	Bots system
		+ addbot <botname> <skill 1-5> <team> <delay> <altname> :: ����������� ������� ������ ���� (��� ����������)
		+ makebot <botname> <skill 1-5> <team> <delay> <altname> :: ������ ���� �� ������� � ��������� (��� ���������� ��� ������ ����� �������������
		+ sharebot <botname> <skill 1-5> <team> <delay> <altname> :: ������ ������������ ���� (������������ ����� ��� �������� � ��������)
		+ bots :: ������ ���������� �����
		+ delbot <id>
		- bots :: ������ ����������� �����
		- callbot <botname> :: �������� ������������ ����
		
		cvar klib_bot_limit :: ��� ����������� ���������� ������� �� ������� ���� ���������, ���������� �����... ��� ��� ����� �� ��������?))
	// TODO: �������� ������� ��� ������ � �������� ���)

	Statistic system
		- stats :: ���������� ��������� �����, ip, ������, ��������, ����������� / ���������� �����, �����
		+ stats <user>

	Bans system
		+ bans
		+ kick <user>
		+ ban <user>
		
	Chat system
		// �����, ��������, ����� �����, ����� ������, ����� �����������, ������

	Adminsay system
	Remap system
		+ remap <shaderfrom> <shaderto>
		- remap <name> :: ��������� ���������� �����
		- remaps :: ���������� ����������
		+ remap list :: ���������� ����������
		+ remap save <name> <shader1from>,<shader1to> ... :: ��������� ����� ��� ������ (����������� ��� ������� ������)
		+ remap share <name> <shader1from>,<shader1to> <shader2from>,<shader2to> ... :: ������ ����������� (��������� ��� ������������ ���� ������!) �����.
		+ remap block :: ��������� �� 5 ����� ����������� ������ )
		+ remap block <time>

		// ������������� ����� ����� ������� ��������� ��������� ���� ������ �������, � ����� �����������
			// ��, ������� ��-�������: ����� ���������� ������������ ������ ����� �� ����� ����������� ����� � ������� 5 ����� ���������

	Cheat system
		+ god
		+ god <user>
		+ undying :: 999 ��? � ��� ��?
		+ undying <user>
		+ health
		+ health <user>
		+ health <user> <health>
		+ health <user> <+|-health> :: ���������� / ��������
		+ armor
		+ armor <user>
		+ armor <user> <armor>
		+ armor <user> <+|-armor>
		+ kill
		+ kill <user>
		+ weapon <weap1>, <weap2>, ... :: ���
		+ weapon <user> <weap1>, ...
		+ ammo
		+ ammo <user>
		+ weapons
		+ weapons <user>
		+ npc :: ���������� ���� npc (� �������, �� �����������)
		+ npc spawn <npc> <name>
		+ npc spawn vehicle <veh> <name>
		+ npc kill all
		+ npc kill everything :: ������� ��������� (���� ���� ���� everything, �� �� �� ����������)
		+ npc kill <name>
		+ npc kill <user>
		+ empower
		+ empower <user>
		+ notarget
		+ notarget <user>

	Clan system
	// clan system ���������� klib_clan 1
		- registerclan <name> <pass> <pass> :: �� ��������� � unregistered ��� ����� register_clan, � ����������� ������������ �� ������������ � ������� (!) -- ����� admin_clans.
		- clan <myclan> <pass> :: ������� � ����. ���� ������������������ ���� - ����� ����������� � ������� ������ � ������� �������. ���� ��� -- ����������� � ������� ������� ������.
		- clanmsg <message> :: �������� ��� ������������ � ����� -- ���������� ��������� � ����-��� (��� ����� ���, ��� ������ �� ����� �� �����; ���� ����������� ��������� ��������� ���������).
		- clanmsg :: ���������� ��������� ��������� � �����
		+ delclan <name>
		+ sayclan <name> <msg> :: ����� ������� ���-�� � �����-�� ����, �� ������ ������, �� ������ � �� ������������������

	// ���� ����� ���� � ����� ��������������������� ����� -- ������� ����������� ���������������� ����
	// ���� ����� ���� � ����� ������������������� �����, �� �������������� -- ������� ����������� ������������
	// ���� ������������ -- ��� cvar klib_clan_offdeny 1 ��� �� ���� ���������.

















]]--