This collection of plugins (and loader) make up what I started calling DAK.

This mod can be downloaded via SteamWorkshop, and will autodownload on all clients on connect.
The ModID for DAK is 5f4f178, which you will want to set in the server command line, and in MapCycle.json.  The server will automatically download the mod once set.

*NOTE* - If you decide to load this from Server.lua to bypass mod filter, you will not want to add the ModID to the command line or MapCycle.json.  You can download the files from SteamWorkshop by
subscribing to the mod and launching your game.  It will then create a folder in %appdata%\natural selection 2\workshop called m5f4f178_##################.  You can also download the files from GitHub.
Once downloaded, you would want to merge them with your ns2/lua folder (there will not be any files overriden).  From there, you will want to edit Server.lua and add the line Script.Load("lua/DAKLoader_Server.lua") 
between the Script.Load statement for ServerConfig and Script.Load for Shared.lua - Between lines 13 and 24 currently.  Line 17 should be blank and is a good place.

Once you launch the server with DAK installed, a DAKConfig.json file will be automatically created in the config_path from the server command line, or in %AppData%\Natural Selection 2 if not specified.
All mods can be enabled/disabled and configured via the DAKconfig.json file.  A sample usable config file is generated by the mod, which uses the recommended values.
To enable/disable 'plugins' that use this loader, you simple want to look for the kPluginsList option in the DAKConfig.json file, and add/remove the exact name of the plugin there.
You can see a list of all the available plugins in the plugin folder, there is a config_ and plugin_ for each one.

Below is a sample of the default plugins and their config options, with an explanation of each option.

"VoteSurrender": {
  "kVoteSurrenderMinimumPercentage": Minimum Percentage of votes needed for surrender to pass.
  "kSurrenderChatCommands": [ Array of chat strings that can be used to start a surrender vote. ]
  "kVoteSurrenderAlertDelay": Delay between alert messages regarding the surrender vote.
  "kVoteSurrenderVotingTime": Time that a surrender vote will run for.
},
"AFKKicker": {
  "kAFKKickWarning1": Time before being kicked that the second warning message will be shown (best to use number cleanly divisible by your CheckDelay)
  "kAFKKickWarning2": Time before being kicked that the first warning message will be shown (best to use number cleanly divisible by your CheckDelay)
  "kAFKKickDelay": Delay in seconds before a AFK user will be kicked.
  "kAFKKickMinimumPlayers": Amount of players required before people will be kicked for being AFK.
  "kAFKKickCheckDelay": Delay between checks of users position and view angles.
},
"AutoMapCycle": {
  "kMaximumPlayers": Maximum players that can be on the server and still have the map change automatically.
  "kAutoMapCycleDuration": Time in minutes before automatic map cycle will start.  Once started, it will check every tick if there are too many players.
  "kMapCycleMaps": [ Array of map names to use if kUseStandardMapCycle is false, will load any mods from mapcycle if applicable. ]
  "kUseStandardMapCycle": If the automatic map cycle will just trigger the mapcycle, or if it will change the map itself using the specified maps.
},
"MapVote": {
  "kVoteMinimumPercentage": Minimum Percentage of votes required for a single map for it to succeed.
  "kRTVMinimumPercentage": Minimum Percentage of rtv votes (rock the vote) to start a map vote at any time.
  "kMapsToSelect": Maximum number of maps to select for vote.
  "kPregameLength": Length of pregame time before round resets and game starts.
  "kVotingDuration": Duration of the map vote.
  "kDontRepeatFor": How long to store a map and not repeat. - More of a future proof setup, there isnt enough maps currently to cause this to be used.
  "kVoteNotifyDelay": How often to display current vote status.
  "kVoteChatCommands": [ Array of chat strings that can be used to vote for a map ]
  "kRockTheVoteChatCommands": [ Array of chat strings that can be used to start a map vote ]
  "kVoteStartDelay": Delay in seconds between a vote being initialized and the vote starting.
  "kPregameNotifyDelay": Delay in seconds between notification messages during pregame.
  "kTimeleftChatCommands": [ Array of chat strings that can be used to trigger timeleft message ]
  "kRoundEndDelay": Amount of time in seconds after a round ends before the mapvote will trigger.
  "kVoteChangeDelay": Delay after successful vote before map change.
  "kMaximumExtends": Maximum amount of extends that can occur per map.
  "kExtendDuration": Time in minutes to that an extend map vote will add.
  "kMaximumTies": Maximum amount of times that a tie vote can occur before a map is randomly choosen from the tied maps.
},
"AutoConcede": {
  "kImbalanceAmount": Amount of players difference needed between teams.
  "kMinimumPlayers": Amount of players required before autoconcede will activate.
  "kImbalanceDuration": Time before round will end due to imbalanced teams.
},
"MOTD": {
  "kMOTDMessageDelay": Delay in seconds between blocks of messages sent to client.
  "kPrintMOTDChatCommands": [ Array of chat strings that can be used by client to have MOTD messages printed. ]
  "kMOTDMessagesPerTick": How many messages to send per block.
  "kAcceptMOTDChatCommands": [ Array of chat strings that a client can use to accept the motd & supress it. ]
  "kMOTDMessageRevision": The revision of the MOTD used to track accepted clients.
},
"ReservedSlots": {
  "kMinimumSlots": This is the amount of slots the server will always keep free (unless completely full of reserve slot players).  Should most likely always be 1.
  "kReservedSlots": This is the amount of slots that will be reserved for reserve slot players.  Note, setting this to 0 does not disable reserve slots, it will only make it so that no slots are left open for reserveslot players.
  "kDelayedKickTime": Delay before kicking a player due to a reserve slot.
  "kReservePassword": This is the password set when all the regular player slots are full, that all reserve players would need to know.
  "kMaximumSlots": This is the server's maximum number of slots.
  "kDelayedSyncTime": Delay in which the server will wait after most recent connect/disconnect to update password status.
},
"Messages": {
  "kMessageInterval": Amount of minutes between broadcast message.
  "kMessagesPerTick": Number of messages sent per block.
  "kMessageStartDelay": Amount of minutes before the first message starts. - (You must also add kMessageInterval)
  "kMessageTickDelay": Delay in seconds between blocks of messages.
},
"TournamentMode": {
  "kTournamentModeAlertDelay": Frequency of message displayed to clients waiting for round start.
  "kTournamentModeGameStartDelay": Delay between round starting after both teams are ready.
  "kReadyChatCommands": [ Array of chat strings that can be used to ready a team. ]
  "kTournamentModeReadyDelay": This delay prevents ready/unready spam.
  "kTournamentModePubMode": This boolean controls if the tournamentmode will run in pub mode, which prevents the game from starting until both teams have kTournamentModePubMinPlayers.
  "kTournamentModePubMinPlayersPerTeam": Minimum number of players needed per team to start the round in pub mode.
  "kTournamentModePubMinPlayersOnline": Minimum amount of players that need to be online for pub mode to be active, otherwise game will start like vanilla NS2.
  "kTournamentModeOverrideCanJoinTeam": Override the default team join rules, so that players can join any team regardless of size
},
"CommBans": {
  "kTeamVotePercentage": Changes default vote % of commander ejection votes
  "kMinVotesNeeded": Changes minimum votes required for commander ejections.
},
"DAKLoader": {
  "MessageSender": The name that will show up next to all messages sent to players.
  "ServerAdmin": {
	"kQueryURL": This is the URL that DAK will query for a list of admins.
	"kQueryTimeout": This controls how long DAK will wait in seconds before it checks to see if the Query responded, or if the cached file should be loaded.
	"kMapChangeDelay": This is the number of minutes after a map change that a new query will not run during.
	"kUpdateDelay": This is the number of seconds after a client connect that a new query will not run.
  },
  "kDelayedClientConnect": This controls the delay after client connect that the DelayedClientConnect event is triggered.
  "kDefaultLanguage": Default language that is used by all clients.
  "kLanguageChatCommands": [ Array of chat strings that can be used to change your language. ]
  "OverrideInterp": {
	"kInterp": This is the amount of MS the interpolation will be set to on client connect. (default 100)
	"kEnabled": This is a boolean for if the Interpolation override should be enabled.
  },
  "GamerulesClassName": This is the classname of the Gamerules entity (default NS2Gamerules), used to override those functions for increased functionality.
  "kLanguageList": List of languages that are loaded and available for use by clients.
  "GamerulesExtensions": This is used to enable/disable certain functions of DAK that are overrides of GamerulesClassName functions (many logging functions and a couple others)
  "kDelayedServerUpdate": This controls the delay between updates of anything running on ServerUpdate DAK Event (per server frame, default 1 second)
  "kPluginsList": [ This array stores the list of plugins to load, looks for a config_ and plugin_ for the name provided in the plugins subfolder. "motd" loads config_motd and plugin_motd from the plugins folder.  Below is a list of avail. plugins by default. ],
	  afkkick
	  autoconcede
	  automapcycle
	  baseadmincommands
	  commbans
	  enhancedlogging
	  mapvote
	  messages
	  motd
	  reservedslots
	  tournamentmode
	  unstuck
	  voterandom
	  votesurrender
},
"VoteRandom": {
  "kVoteRandomChatCommands": [ Array of chat strings that can be used to vote for random teams ]
  "kVoteRandomInstantly": This boolean controls how the random teams plugin works.  If true, the teams are randomed instantly for one round.  If false, the teams are randomed each round starting with the next new round for kVoteRandomDuration.
  "kVoteRandomMinimumPercentage": The percentage of votes required to turn on random teams.
  "kVoteRandomDuration": The duration that the random team vote stays enabled for (if kVoteRandomInstantly is false).
},
"Unstuck": {
  "kMinimumWaitTime": This is delay between typing the unstuck and when your actually moved.
  "kTimeBetweenUntucks": This is delay after being unstuck before you can be unstuck again.
  "kUnstuckAmount": Amount player is moved when 'unstuck'
  "kUnstuckChatCommands": [ Array of chat strings that can be used to unstuck. ]
},
"EnhancedLogging": {
  "kLogWriteDelay": Delay in seconds to delay writes to not queue up tons of drive write time.
  "kServerTimeZoneAdjustment": This adjusts the log timing based on the value set, -8 for PST, -5 EST and so on.
  "kEnhancedLoggingSubDir": Subdirectory under the config_path in which log files should be stored.
},
"BaseAdminCommands": {
  "kCryptographyKey": Key used to verify the validity of a webbans submission.
  "kUpdateDelay": Time in seconds between updates of the webbans list.
  "kMapChangeDelay": Time in minutes after a map change where the webbans list will not update.
  "kBansQueryTimeout": Time in seconds that DAK will wait before checking the success of the webbans query, and falling back on the cached file.
  "kBansQueryURL": URL that DAK will query for the webbans list.
  "kBlacklistedCommands": [ "Console_sv_kick", "Console_sv_eject", "Console_sv_switchteam", "Console_sv_randomall", "Console_sv_rrall", "Console_sv_reset", "Console_sv_changemap", "Console_sv_statusip", "Console_sv_status", "Console_sv_say", "Console_sv_tsay", "Console_sv_psay", "Console_sv_slay", "Console_sv_password", "Console_sv_ban", "Console_sv_unban", "Console_sv_listbans" ],
  "kUnBanSubmissionURL": URL that DAK will use to submit unban requests.
  "kBanSubmissionURL": URL that DAK will use to submit ban requests.
}

Current ServerAdmin Command List:

 sv_status: Lists player Ids and names for use in sv commands
 sv_who: Will list all online admins.
 These two commands can be run by any user, no admin groups are required.  Admins with access to sv_status will see connected players IP addresses in the printout, non-admins wont.
 
 sv_reloadconfig: Will reload the configuration files.
 sv_defaultconfig: <Plugin Name> Will default the config for the plugin passed, also accepts ALL.
 sv_resetsettings: Resets anything saved in DAK settings - Currently stored there are:
	RandomEnabledTill - controls if random teams are enabled over a period of time.
    MOTDAcceptedClients - any clients that have accepted the motd are stored here, along with the version accepted.
    FriendlyFire - If friendly fire is enabled, its stored here.
    TournamentMode - If  tournament mode is enabled, its stored here.
    PreviousMaps - Previous maps are tracked here for the mapvote.
 sv_rcon: <command> Will execute specified command on server.
 sv_alltalk: Will toggle the alltalk setting on server.
 sv_listplugins: Will list the state of all loaded plugins.
 sv_maps: Will list all the maps currently on the server.
 sv_cheats: Will enable/disable cheats.
 sv_listadmins: Will list all groups and admins.
 sv_setlanguage <player id> <language> Changes the language set for the provided player.
 sv_changemap: <map name> Switches to the map specified
 sv_reset: Resets the game round
 sv_rrall: Forces all players to go to the Ready Room
 sv_randomall: Forces all players to join a random team
 sv_switchteam: <player id> <team number> Moves passed player to provided team. 1 is Marine, 2 is Alien.
 sv_eject: <player id> Ejects Commander from the Command Structure
 sv_kick: <player id> Kicks the player from the server
 sv_say: <message> Sends a message to every player on the server
 sv_tsay: <team number> <message> Sends a message to one team
 sv_psay: <player id> <message> Sends a message to a single player
 sv_slay: <player id> Kills player
 sv_password: <string> Changes the password on the server
 sv_ban: <player id> <duration in minutes> <reason text> Bans the player from the server, pass in 0 for duration to ban forever
 sv_unban: <steam id> Removes the player matching the passed in Steam Id from the ban list
 sv_listbans: Lists the banned players
 sv_p_logall: Starts performance logging
 sv_p_endlog: Ends performance logging
 sv_autobalance: <true/false> <player count> <seconds> Toggles auto team balance. The player count and seconds are optional. Count defaults to 2 over balance to enable. Defaults to 10 second wait to enable.
 sv_commban: <player id> <duration in minutes> <reason text> Bans the player from commanding, pass in 0 for duration to ban forever
 sv_uncommban: <steam id> Removes the player matching the passed in Steam Id from the commander ban list
 sv_listcommbans: Lists the commander banned players
 sv_votemap: Will start a map vote.
 sv_cancelmapvote: Will cancel a map vote.
 sv_randomoff: Turns off any currently active random teams vote.
 sv_randomon: Will enable random teams.
 sv_cancelsurrendervote: <teamnumber> Cancelles a currently running surrender vote for the provided team.
 sv_surrendervote: <teamnumber> Will start a surrender vote for that team.
 sv_reloadplugins: Reloads all plugins.
 
 sv_afkimmune: Grants the admin immunity from AFK kicker.
 sv_ejectionprotection: Grants the admin immunity from commander ejection
 sv_hasreserve: Grants the admin a reserved slot that doesnt expire.
 sv_dontrandom: Prevents the admin from being randomed to a team.

 All server admin commands will also print to any other admins consoles when used (admins that also have access to that command).
 
 General console/chat commands added:
 timeleft - displays time left till next map vote.
 acceptmotd - supresses motd messages unless the kMOTDMessageRevision is changed.  This is saved in DAKSettings.json and persists between map changes.
 printmotd - will print the motd out.
 voterandom - will vote to enable random teams.
 ready - marks your team as ready if tournamentmode is enabled.
 vote - used to vote for a map during map vote, needs to have a number as a paramater.
 rtv or rockthevote - used to vote for a map vote (can be started anytime)
 surrender - used to start or vote in an active surrender vote.
 
 DAK also now includes a language system, which allows clients to specifiy their language to change the format/language of the messages they recieve.  Currently only EN is included, hope to expand this to include many languages by default.
 The language files are included in the lua folder by default, lua/lang/%LANGUAGENAME%.json.  Default.json should not be modified, as it will include all messages that are used.  If you are creating a new language, you will want to copy and rename 
 that file accordingly.  This will allow those messages to still show up in game, before other language files are updated.  DAK will also check in the config_path/lang folder for the language files specified.  You can configure the languages DAK 
 will load in DAKConfig.json, EN being the only default.  Clients can then change their language by using the two letter identification string for that language (currently using 2, EN, FR, ES etc.., may switch to 4 - ENUS, ENGB etc.).  
 Currently they can use the console command setlanguage en, or use the chat command \lang en.  As for configuring the messages, it works mostly the same as before, however all messages are located in the language json files, and you would need 
 to customize each language as needed.  The same notes still apply regarding regex strings, you will want to maintain the same amounts (%s, %f, %d). 
 
 Breakdown of current 'Plugins' system and the standard 'Plugins'
 DAK extends various events from the engine, and creates a couple of its own.
 
 kDAKOnClientConnect
 kDAKOnClientDisconnect
 kDAKOnServerUpdate
 kDAKOnClientDelayedConnect
 kDAKOnTeamJoin
 kDAKOnGameEnd
 kDAKOnEntityKilled
 kDAKOnUpdatePregame
 kDAKOnCastVoteByPlayer
 kDAKOnSetGameState
 kDAKOnClientChatMessage
 kDAKCheckMapChange
 kDAKOverrideMapChange
 
 Functions can be added to these variables which will be run when these events occur, sample shown below:
 DAKRegisterEventHook(kDAKOnServerUpdate, UpdateMapVotes, 5) - (EventArray, Function, Priority) This also allows a priority to be set for the Event, the higher the number the greater the priority. - Default 5
 
 This also allows for the EventHooks to be removed during runtime, for greater efficiency.  
 DAKDeregisterEventHook(kDAKOnServerUpdate, UpdateMapVotes) - (EventArray, Function) - This removes the function from the array, so that it wont be called anymore.
 
 Plugins are loaded from the plugin folder by DAK, with config_ files being loaded to setup config if needed, and plugin_ files containing the plugin logic.
 The config_ files uses an array to track all config functions:
 table.insert(kDAKPluginDefaultConfigs, {PluginName = "AFKKicker", DefaultConfig = SetupDefaultConfig })
 
 Notes about Gamerules overrides - they require the same args from vanilla NS2, or will need manual configuration.
 This can be changed in DAKLoader.lua, kDAKBaseGamerules is the class name used when setting up the overrides.
 Below are the functions overriden and their default configuration.
 
	function NS2Gamerules:JoinTeam(player, newTeamNumber, force)
	function NS2Gamerules:EndGame(winningTeam)
	function NS2Gamerules:OnEntityKilled(targetEntity, attacker, doer, point, direction)
	function NS2Gamerules:UpdatePregame(timePassed)
	function NS2Gamerules:SetGameState(state)
	function NS2Gamerules:CastVoteByPlayer(voteTechId, player)
	
	Also included is a function to capture chat messages and raise events based on them, disabling the gamerules extensions
	will also disable this.

	function Server.AddChatToHistory(message, playerName, steamId, teamNumber, teamOnly)
	
	Also have added some additional overrides for added logging:
	
	function CommandStructure:LoginPlayer(player)
	function CommandStructure:Logout()
	
	function RecycleMixin:OnResearchComplete(researchId)
	function RecycleMixin:OnResearch(researchId)
	
	function ConstructMixin:OnInitialized()

 These can be disabled in DAKConfig.json, GamerulesExtensions which is under DAKLoader.
 
 Please note that errors caused in functions added are systemic, meaning they will affect the execution of NS2 gamecode, so some care must be taken.
 
 OverrideInterp Plugin
 - This is mainly for testing, however it overrides the default interpolation value of 100ms on each clients connect, making sure that
 the value is correct set client/server side.
 
 AutoConcede Plugin
 - This plugin adds an Automatic Concedede check to the GameEnd function, which will alert players if the teams are different by a configurable amount of players, and will
 end the game if the team imbalance isnt resolved after a configurable amount of time.
 
 AutoMapCycle Plugin
 - This plugin will automatically cycle the map after a configurable amount of time, and with a configurable minimum player count.  It will invoke a MapCycle change, or alternatively
 can be configured to use a specific map list.
 
 BaseAdminCommands Plugin
 - This plugin replaces the basic admin commands that are provided with NS2, and changes some functionality, and also extends some basic functionallity, like offering GameIds for 
 connected players.
 
 CommBans Plugin
 - This plugin allows commander bans to be set, which can be permanent or time based.  They can be added and or removed in game.  This allows adds protection to commander ejecting
 for various admin levels, if the sv_ejectionprotection command is granted.
 
 VoteRandom Plugin
 - This plugin enables players to vote to enable random teams, and supports either randoming the teams instantly, or enabling random teams for a set duration,
 where the next game and all games for a set duration have random teams.
 
 TournamentMode Plugin
 - Made a recent re-visit to this plugin to improve basics regarding it, created basic framework for PCW/Official modes.  May continue to improve
 and add to differences between modes.
 
 ReservedSlots Plugin
 - Basic Reserve slots plugin, however is more a proof of concept and does not have the ability to work in a way that provides a good user experience.
 Basic framework may prove useful should the ability arise to reject clients connection earlier or modify query response.
 
 MOTD Plugin
 - This plugin provides a MOTD system that could be more accurately described as a rules system, which allows clients to accept and have the messages
 not always appear on connect.  Should be loaded as last plugin so that other plugins can stop the messages if needed.  Messages are also sent in groups
 so that they can all be viewed onscreen.
 
 Messages Plugin
 - This plugin provides a periodic message delivery function, which allows for flexible configuration.  The total amount of messages, messages per block, interval between blocks,
 interval between message cycles, and a start delay for message cycling.
 
 MapVote Plugin
 - This plugin provides a map voting system, which will read the mapcycle.txt for cycle time and the list of maps.  On round end a map vote is triggered
 if enough time has elapsed, with a randomly selected list of maps which excludes some of the map last played.  Since NS2 only has 4 offical maps currently
 the plugin will automatically add back in maps if there is not enough to make the minimum.  Almost all parts are configurable in the configs.
 
 AFKKicker Plugin
 - This plugin checks if a player is idle by caching their viewangles and origin, and displays messages to alert them if they are going to be kicked.
 May in the future be improved to use idle parameter on the player.
 
 EnhancedLogging Plugin
 - This plugin enables alot of extra logging, which is done to a seperate directory within the configured server admin path.
 Sample log file below with some information omitted:
 
 L 9/16/2012 - 12:55:53 - <AAA><10><STEAMID><0> joined team 2.
 L 9/16/2012 - 12:55:59 - <[Mi7] JumpinJackFlas><13><STEAMID><0> changed name to [Mi7] JumpinJackFlash.
 L 9/16/2012 - 12:56:01 - <[Mi7] JumpinJackFlas><13><STEAMID><0> connected, address IPADDRESS
 L 9/16/2012 - 12:56:06 - <FatherTime><6><STEAMID><2> killed <Sphen><4><STEAMID><1> with BiteLeap at (attacker_position 38.560000 3.970000 -2.400000) (victim_position 39.510000 2.750000 -4.130000)
 L 9/16/2012 - 12:56:20 - <FatherTime><6><STEAMID><2> killed <Siylenia><12><STEAMID><1> with BiteLeap at (attacker_position 62.810000 0.330000 19.350000) (victim_position 63.350000 -0.160000 20.500000)
 L 9/16/2012 - 12:56:47 - <Siylenia><12><STEAMID><1> killed <FatherTime><6><STEAMID><2> with Rifle at (attacker_position 81.250000 0.390000 30.740000) (victim_position 83.000000 1.180000 30.890000)
 L 9/16/2012 - 12:56:53 - <Siylenia><12><STEAMID><1> killed <AAA><10><STEAMID><2> with Rifle at (attacker_position 75.930000 -0.100000 35.140000) (victim_position 68.780000 4.880000 36.570000)
 L 9/16/2012 - 12:57:00 - <Teh_Prodigy><2><STEAMID><1> killed Hydra with Shotgun at (attacker_position 69.100000 0.010000 33.650000) (victim_position 64.600000 -0.000000 30.490000)
 
 VoteSurrender Plugin
 - This plugin provides a surrender vote system for each team, which can be used to vote for the game to end if a set percentage of the team votes.
 
 UnStuck Plugin
 - This plugin provides an unstuck command for players, and has some basic configurable options for delays to prevent abuse, and to change the unstuck amount.
 
 //Config
 
 Reserve Slot config - ReservedPlayers.json

 -Name is just a friendly name for the user, is not checked in game.
 -ID is the steamID for the user, which is what is used to authenticate them in game.
 -Reason is the reason for why the user has a reserve slot
 -Time is the unix system time of when the reserve slot will expire, 0 will set it to not expire.

 Sample file below:

 {
 	{ "name": "dragon", "id": 5176141, "reason": "meh", "time": 0 }
 }
 
 ServerAdmin config - ServerAdmin.json
 
 This files works identically to the base admin system's configuration file.
 
 Sample file below:
 
 {
    "groups":
    {
        "admin_group": { "type": "disallowed", "commands": [ ] },
        "mod_group": { "type": "disallowed", "commands": [ "sv_ban", "sv_reset" ] },
        "clan_group": { "type": "allowed", "commands": [ "sv_kick", "sv_say" ] }
    }
    
    "users":
    {
        "dragon": { "id": 5176141, "groups": [ "clan_group" ] },
    }
}