//afkkick default config

kDAKRevisions["AFKKicker"] = "0.1.114a"

local function SetupDefaultConfig(Save)
	if kDAKConfig.AFKKicker == nil then
		kDAKConfig.AFKKicker = { }
	end
	kDAKConfig.AFKKicker.kAFKKickDelay = 150
	kDAKConfig.AFKKicker.kAFKKickCheckDelay = 5
	kDAKConfig.AFKKicker.kAFKKickMinimumPlayers = 5
	kDAKConfig.AFKKicker.kAFKKickWarning1 = 30
	kDAKConfig.AFKKicker.kAFKKickWarning2 = 10
	if Save then
		SaveDAKConfig()
	end
end

table.insert(kDAKPluginDefaultConfigs, {PluginName = "AFKKicker", DefaultConfig = SetupDefaultConfig })