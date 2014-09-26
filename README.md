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

- login &lt;nick> &lt;pass>
- logout
- register &lt;nick> &lt;pass> &lt;pass>
- *createuser &lt;nick> &lt;pass> &lt;pass> [group] -- makes new user without logout.*
- *user &lt;user> -- shows you user info.*
- *givepermission &lt;user> &lt;perm1>, &lt;perm2>...*

***For example, user with rank "Knight" after giving permission to him, will have rank "Knight (changed)"***

- *removepermission &lt;user> &lt;perm1>, &lt;perm2>...*
- *rank &lt;groupname> &lt;permission1>... -- makers new rank, or changes permissions of the rank*
- *rankuser &lt;user> &lt;rank> -- gives rank to user*
- *logout &lt;user>*
- *deluser &lt;user>*
- *tempuser &lt;name|null> &lt;player> &lt;rank|permissions> -- makes the player (with &lt;player> id) as a temporary user (after logout, account will deleted)*
- *users -- shows all online users*
- *users &lt;groupname>, &lt;groupname2>...*
- *lastusers -- last logins*
- *lastregister*

***Standart logout-players group -- "guest"***

***Standart login-players group -- "user"***

***Standart admin group -- "admin" (you can't deny to "admin" group any command).***

### Economic system
*(only if cvar klib_economic 1)*
- money -- shows your money.
- *money &lt;money>*
- *money &lt;user>*
- *money &lt;user> &lt;money>*
- grant &lt;user> &lt;money>

### Entity system
*Needs an Entity API in JA++*

### Teleports system
- origin -- shows your origin.
- sayorigin
- sayorigin &lt;user>
- *sayorigin &lt;x> &lt;y> &lt;z>*
- *sayorigin &lt;user> &lt;x> &lt;y> &lt;z>*
- telelast -- teleports to the last "sayorigin".
- *tele &lt;x> &lt;y> &lt;z>*
- *tele &lt;user -- teleports to the user*
- *tele &lt;user> &lt;x> &lt;y> &lt;z> -- teleports the user*
- *telet -- tele target*

(entity api)

- *telemark -- (entity api)*
- *maketeleport &lt;user> &lt;x> &lt;y> &lt;z> -- makes teleport about the user*
- *maketeleport &lt;fx> &lt;fy> &lt;fz> &lt;tx> &lt;ty> &lt;tz> -- from; to*
- *onceteleport -- makes the last opened teleport to close after first using*
- *teleports -- shows all teleports*
- *closeteleport &lt;id>*
- *closeteleports*

### Messages system
(you can send message to the offline user)
- message &lt;user> &lt;message>
- messages
- messages &lt;page>
- messages new
- messages &lt;user>
- *msgrank &lt;rank1,rank2> &lt;message> -- message to the all ranked users*

### Shops system
### Bots system
- *addbot &lt;botname> &lt;skill 1-5> &lt;team> &lt;delay> &lt;altname>*
- *makebot &lt;botname> &lt;skill 1-5> &lt;team> &lt;delay> &lt;altname> -- saves the bot (in the next server starting, klib will add the bot)*
- *sharebot &lt;botname> &lt;skill 1-5> &lt;team> &lt;delay> &lt;altname> -- any user can call a shared bot*
- bots -- shared bots.
- *bots -- shared and saved bots.*
- *delbot &lt;id>*
- callbot &lt;id>
		
TODO: npcs

### Statistic system
- stats -- last ip, last visit time, kills, deaths, duels...
- *stats &lt;user>*

### Bans system
...

### Chat system
...

### Adminsay system
...

### Remap system
- *remap &lt;shaderfrom> &lt;shaderto>*
- remap &lt;name> -- applies an shared remap
- remaps
+ *remap list*
+ *remap save &lt;name> &lt;shader1from>,&lt;shader1to> ...*
+ *remap share &lt;name> &lt;shader1from>,&lt;shader1to> &lt;shader2from>,&lt;shader2to> ...*
+ *remap block -- blocks shared remaps in 5 minutes.*
+ *remap block &lt;time>*

### Cheat system
...

### Clan system
...
