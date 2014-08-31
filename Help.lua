Help = {}

Help['en'] = {}
Help['ru'] = {}

AddClientCommand('info', function(player, args)
	if args[1] ~= nil then
		local locale = Help[args[1]] -- string.tolower
	else
		local locale = Help['en']

	local str = 'KLib v' .. KLib.version .. '\n'
	str = str .. '^2/info emotes^7 - your emotions\n'
	str = str .. '^2/info accounts^7 - login, logout and other\n'
	str = str .. '^2/info economic^7 - money\n'
	str = str .. '^2/info entity^7 - entities, objects, effects and other\n'
	str = str .. '^2/info tele^7 - teleporting, teleports\n'
	str = str .. '^2/info messages^7 - messages between users\n'
	str = str .. '^2/info shops^7 - shops, where you can buy items\n'
	str = str .. '^2/info bots^7 - bot system\n'
	str = str .. '^2/info statistic^7 - stats\n'
	str = str .. '^2/info shops^7 - shops\n'
	
	KLib.player_console(player, str)
end)

AddClientCommand('help', function(player, args)
	KLib.player_console(player, 'Maybe, you have mean /info?')
end)