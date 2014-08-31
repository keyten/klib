KLib
======================
KLib is a JA++ addon with next systems:
- Account
- Economic
- Entity
- Teleports
- Messages
- Shops
- Bots
- Statistics
- Punishment
- Chat
- Adminsay
- Remap
- Cheat
- Clan

Installation
-----------------------
1. Download as a zip.
2. Make the folder "lua/sv/klib" in zip and copy to that all lua files.
3. Rename klib-master.zip to klib.pk3
4. Copy it to your GameData/japlus folder.

***Warning!* KLib are on development, and some functions may work incorrect.**

Systems
-----------------------

(normal font -- user command; *italic font -- admin command*.. but you are can add any permissions to any ranks)

### Account system

- login &lt;nick> <pass>
- logout
- register <nick> <pass> <pass>
- *createuser <nick> <pass> <pass> [group] -- makes new user without logout.*
- *user <user> -- shows you user info.*
- *givepermission <user> <perm1>, <perm2>...*

***For example, user with rank "Knight" after giving permission to him, will have rank "Knight (changed)"***

- *removepermission <user> <perm1>, <perm2>...*
- *rank <groupname> <permission1>... -- makers new rank, or changes permissions of the rank*
- *rankuser <user> <rank> -- gives rank to user*
- *logout <user>*
- *deluser <user>*
- *tempuser <name|null> <player> <rank|permissions> -- makes the player (with <player> id) as a temporary user (after logout, account will deleted)*
- *users -- shows all online users*
- *users <groupname>, <groupname2>...*
- *lastusers -- last logins*
- *lastregister*

***Standart logout-players group -- "guest"***

***Standart login-players group -- "user"***

***Standart admin group -- "admin" (you can't deny to "admin" group any command).***

### Economic system
*(only if cvar klib_economic 1)*
- money -- shows your money.
- *money <money>*
- *money <user>*
- *money <user> <money>*
- grant <user> <money>

### Entity system
*Needs an Entity API in JA++*

### Teleports system
- origin -- shows your origin.
- sayorigin
- sayorigin <user>
- *sayorigin <x> <y> <z>*
- *sayorigin <user> <x> <y> <z>*
- telelast -- teleports to the last "sayorigin".
- *tele <x> <y> <z>*
- *tele <user -- teleports to the user*
- *tele <user> <x> <y> <z> -- teleports the user*
- *telet -- tele target*

(entity api)

- *telemark -- (entity api)*
- *maketeleport <user> <x> <y> <z> -- makes teleport about the user*
- *maketeleport <fx> <fy> <fz> <tx> <ty> <tz> -- from; to*
- *onceteleport -- makes the last opened teleport to close after first using*
- *teleports -- shows all teleports*
- *closeteleport <id>*
- *closeteleports*

### Messages system
(you can send message to the offline user)
- message <user> <message>
- messages
- messages <page>
- messages new
- messages <user>
- *msgrank <rank1,rank2> <message> -- message to the all ranked users*

### Shops system
### Bots system
- *addbot <botname> <skill 1-5> <team> <delay> <altname>*
- *makebot <botname> <skill 1-5> <team> <delay> <altname> -- saves the bot (in the next server starting, klib will add the bot)*
- *sharebot <botname> <skill 1-5> <team> <delay> <altname> -- any user can call a shared bot*
- bots -- shared bots.
- *bots -- shared and saved bots.*
- *delbot <id>*
- callbot <id>
		
TODO: npcs

### Statistic system
- stats -- last ip, last visit time, kills, deaths, duels...
- *stats <user>*

### Bans system
...

### Chat system
...

### Adminsay system
...

### Remap system
- *remap <shaderfrom> <shaderto>*
- remap <name> -- applies an shared remap
- remaps
+ *remap list*
+ *remap save <name> <shader1from>,<shader1to> ...*
+ *remap share <name> <shader1from>,<shader1to> <shader2from>,<shader2to> ...*
+ *remap block -- blocks shared remaps in 5 minutes.*
+ *remap block <time>*

### Cheat system
...

### Clan system
...
