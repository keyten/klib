Locale = {}

-- Accounts
Locale.loggedin = '^1Error: you are already logged in'
Locale.out_loggedin = '^1Error: you are already logged out'
Locale.register_using = '^2Usage: ^7/register <nickname> <password> <password>'
Locale.register_pdnm = '^1Error: passwords do not match'
Locale.register_exist = '^1Error: could not create account, an account by this name already exists'
Locale.registered = '^2Successfully registered! You are logged in'
Locale.register_badname = '^1Error: username needs to have english letters and numbers (but not starts from number)'
Locale.register_shortname = '^1Error: username needs to be at least 3 characters in length'
Locale.register_longname = '^1Error: username needs to be no more than 36 characters in length'
Locale.register_shortpass = '^1Error: password needs to be at least 6 characters in length'
Locale.login_using = '^2Usage: ^7/login <nickname> <password>'
Locale.login_userwrong = '^1Error: wrong username or password'
Locale.login_passwrong = '^1Error: wrong username or password'
Locale.login_success = '^2You are now logged in'
Locale.logged_out = '^3You are now logged out'

Locale.createuser_using = '^2Usage: ^7/createuser <nickname> <password> <password>'
Locale.created_user = '^2Account created!'
Locale.user_using = '^2Usage: ^7/user <nickname>'
Locale.user_isnotexist = '^1Error: user is not exist'
Locale.user_ranked = '^2User has ranked!'
-- Locale.user_rank = '^2Rank successfully changed!'
Locale.rank_has = '^2 now has ^1'
Locale.group_isnotexist = '^1Error: rank is not exist'

Locale.user_group = '^3Group: ^7'
Locale.user_group_changed = ' (changed)'
Locale.user_last_visit = '^3Last visit: ^7'
Locale.user_last_ip = '^3Last IP: ^7'


-- Permissions
Locale.permission_deny = '^1Error: you do not have permission'

-- Errors
Locale.error_loaddata = 'can not load data'