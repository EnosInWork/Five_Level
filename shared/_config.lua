Config = {
    
    Token = nil, -- Don't Touch this
    XPAmount = 0, -- Don't Touch this

    ESXSharedObject = "esx:getSharedObject", -- Votre trigger ESX

    logs = {
		-------------------------	
		NameLogs = "Logs - XP",
		-------------------------
		webhook = "votrewebhook",
	},

    BannerColor = false, -- Bannière en couleurs 

    ColorMenuR = 255, -- Bannière couleur R
    ColorMenuG = 11, -- Bannière couleur G
    ColorMenuB = 11, -- Bannière couleur B
    ColorMenuA = 150, -- Bannière couleur A

    MenuReward = true,  -- true, false, menu reward
    OpenXPMenu = "F9", -- touche pour ouvrir le menu reward
    ActiveCMD = true, -- Actviation des commandes /add /remove give XP

    WinList = {
        {type = "money" , value = 5000, label = "Sac d'argent (5000$)", desc = "", lvl = 2},
        {type = "money" , value = 10000, label = "Sac d'argent (10000$)", desc = "", lvl = 10},
        {type = "money" , value = 25000, label = "Sac d'argent (25000$)", desc = "", lvl = 20},
        {type = "item" , value = "bread", label = "Silver Box", desc = "", lvl = 30},
        {type = "weapon" , value = "WEAPON_PISTOL", label = "Armes létale", desc = "", lvl = 40},
        {type = "car" , value = "t20", label = "Voiture de luxe", desc = "", lvl = 50},
    },

}