Rank = {}

Rank.Bar = {
    800, 2100, 3800, 6100, 9500, 12500, 16000, 19800, 24000, 28500, 33400, 38700, 44200, 50200, 56400, 63000, 69900, 77100, 84700, 92500,
    100700, 109200, 118000, 127100, 136500, 146200, 156200, 166500, 177100, 188000, 199200, 210700, 222400, 234500, 246800, 259400, 272300,
    285500, 299000, 312700, 326800, 341000, 355600, 370500, 385600, 401000, 416600, 432600, 448800, 465200, 482000, 499000, 516300, 533800,
    551600, 569600, 588000, 606500, 625400, 644500, 663800, 683400, 703300, 723400, 743800, 764500, 785400, 806500, 827900, 849600, 871500,
    893600, 916000, 938700, 961600, 984700, 1008100, 1031800, 1055700, 1079800, 1104200, 1128800, 1153700, 1178800, 1204200, 1229800, 1255600,
    1281700, 1308100, 1334600, 1361400, 1388500, 1415800, 1443300, 1471100, 1499100, 1527300, 1555800, 1584350
}

Rank.AddPlayerXP = function(XPAmount)	
    local CurrentXPWithAddedXP = tonumber(Config.xpAmount) + XPAmount
    local NewLevel =  Rank.GetLevelFromXP(CurrentXPWithAddedXP)
    local LevelDifference = 0
    if NewLevel > 500 - 1 then
        NewLevel = 500 -1
        CurrentXPWithAddedXP = Rank.GetXPCeilingForLevel(500 - 1)
    end
    if NewLevel > Rank.GetLevelFromXP(tonumber(Config.xpAmount)) then
        LevelDifference = NewLevel - Rank.GetLevelFromXP(tonumber(Config.xpAmount))
    end
    if LevelDifference > 0 then
        StartAtLevel = Rank.GetLevelFromXP(tonumber(Config.xpAmount))
        Rank.CreateRankBar(Rank.GetXPFloorForLevel(StartAtLevel), Rank.GetXPCeilingForLevel(StartAtLevel), tonumber(Config.xpAmount), Rank.GetXPCeilingForLevel(StartAtLevel), StartAtLevel, false)
        for i = 1, LevelDifference ,1 do 
            StartAtLevel = StartAtLevel + 1
            if i == LevelDifference then
                Rank.CreateRankBar(Rank.GetXPFloorForLevel(StartAtLevel), Rank.GetXPCeilingForLevel(StartAtLevel), Rank.GetXPFloorForLevel(StartAtLevel), CurrentXPWithAddedXP, StartAtLevel, false)
            else
                Rank.CreateRankBar(Rank.GetXPFloorForLevel(StartAtLevel), Rank.GetXPCeilingForLevel(StartAtLevel), Rank.GetXPFloorForLevel(StartAtLevel), Rank.GetXPCeilingForLevel(StartAtLevel), StartAtLevel, false)
            end
        end
    else
        Rank.CreateRankBar(Rank.GetXPFloorForLevel(NewLevel), Rank.GetXPCeilingForLevel(NewLevel), tonumber(Config.xpAmount), CurrentXPWithAddedXP, NewLevel, false)
    end
    Config.xpAmount = CurrentXPWithAddedXP
end

Rank.RemovePlayerXP = function(XPAmount)
    local CurrentXPWithRemovedXP = tonumber(Config.xpAmount) - XPAmount
    local NewLevel =  Rank.GetLevelFromXP(CurrentXPWithRemovedXP)
    local LevelDifference = 0
    if NewLevel < 1 then
        NewLevel = 1
    end
    if CurrentXPWithRemovedXP < 0 then
        CurrentXPWithRemovedXP = 0
    end
    if NewLevel < Rank.GetLevelFromXP(tonumber(Config.xpAmount)) then
        LevelDifference = math.abs(NewLevel - Rank.GetLevelFromXP(tonumber(Config.xpAmount)))
    end
    if LevelDifference > 0 then
        StartAtLevel = Rank.GetLevelFromXP(tonumber(Config.xpAmount))
        Rank.CreateRankBar(Rank.GetXPFloorForLevel(StartAtLevel), Rank.GetXPCeilingForLevel(StartAtLevel), tonumber(Config.xpAmount), Rank.GetXPFloorForLevel(StartAtLevel), StartAtLevel, true)
        for i = 1, LevelDifference ,1 do 
            StartAtLevel = StartAtLevel - 1
            if i == LevelDifference then
                Rank.CreateRankBar(Rank.GetXPFloorForLevel(StartAtLevel), Rank.GetXPCeilingForLevel(StartAtLevel), Rank.GetXPCeilingForLevel(StartAtLevel), CurrentXPWithRemovedXP, StartAtLevel, true)
            else
                Rank.CreateRankBar(Rank.GetXPFloorForLevel(StartAtLevel), Rank.GetXPCeilingForLevel(StartAtLevel), Rank.GetXPCeilingForLevel(StartAtLevel), Rank.GetXPFloorForLevel(StartAtLevel), StartAtLevel, true)
            end
        end
    else
        Rank.CreateRankBar(Rank.GetXPFloorForLevel(NewLevel), Rank.GetXPCeilingForLevel(NewLevel), tonumber(Config.xpAmount), CurrentXPWithRemovedXP , NewLevel, true)
    end
    Config.xpAmount = CurrentXPWithRemovedXP
end

Rank.GetXPFloorForLevel = function(intLevelNr)
    if intLevelNr > 7999 then
        intLevelNr = 7999
    end
    if intLevelNr < 2 then
        return 0
    end
    if intLevelNr > 100 then
        MainAddPerLevel = 28550
        CurXPNeeded = 0	
        for i = 1, intLevelNr - 100 ,1 do 
            MainAddPerLevel = MainAddPerLevel + 50
            CurXPNeeded = CurXPNeeded + MainAddPerLevel
        end
        return Rank.Bar[99] + CurXPNeeded
    end
    return Rank.Bar[intLevelNr - 1]
end

Rank.GetXPCeilingForLevel = function(intLevelNr)
    if intLevelNr > 7999 then
        intLevelNr = 7999
    end
    if intLevelNr < 1 then
        return 800
    end
    if intLevelNr > 99 then
        MainAddPerLevel = 28550
        CurXPNeeded = 0
        for i = 1, intLevelNr - 99 ,1 
        do 
            MainAddPerLevel = MainAddPerLevel + 50
            CurXPNeeded = CurXPNeeded + MainAddPerLevel
        end
        return Rank.Bar[99] + CurXPNeeded
    end
    return Rank.Bar[intLevelNr]
end

Rank.GetLevelFromXP = function(intXPAmount)
    local intXPAmount = tonumber(intXPAmount)
    if intXPAmount < 0 then return 1 end
    if intXPAmount < Rank.Bar[99] then
        local CurLevelFound = -1
        local CurrentLevelScan = 0
        for k,v in pairs(Rank.Bar)do
            CurrentLevelScan = CurrentLevelScan + 1
            if intXPAmount < v then break end
        end
        return CurrentLevelScan
    else
        MainAddPerLevel = 28550
        CurXPNeeded = 0
        local CurLevelFound = -1
        for i = 1, 500 - 99 ,1 do
            MainAddPerLevel = MainAddPerLevel + 50
            CurXPNeeded = CurXPNeeded + MainAddPerLevel
            CurLevelFound = i
            if intXPAmount < (Rank.Bar[99] + CurXPNeeded) then break end
        end
        return CurLevelFound + 99
    end
end

Rank.CreateRankBar = function(XP_StartLimit_RankBar, XP_EndLimit_RankBar, playersPreviousXP, playersCurrentXP, CurrentPlayerLevel, TakingAwayXP)
    local RankBarColor = 116
    if TakingAwayXP then RankBarColor = 6 end
    if not HasHudScaleformLoaded(19) then
        RequestHudScaleform(19)
        while not HasHudScaleformLoaded(19) do
            Wait(1)
        end
    end
    BeginScaleformMovieMethodHudComponent(19, "SET_COLOUR")
    PushScaleformMovieFunctionParameterInt(RankBarColor)
    EndScaleformMovieMethodReturn()
    BeginScaleformMovieMethodHudComponent(19, "SET_RANK_SCORES")
    PushScaleformMovieFunctionParameterInt(XP_StartLimit_RankBar)
    PushScaleformMovieFunctionParameterInt(XP_EndLimit_RankBar)
    PushScaleformMovieFunctionParameterInt(playersPreviousXP)
    PushScaleformMovieFunctionParameterInt(playersCurrentXP)
    PushScaleformMovieFunctionParameterInt(CurrentPlayerLevel)
    PushScaleformMovieFunctionParameterInt(100)
    EndScaleformMovieMethodReturn()
end

exports('ShowPlayerXP', function()
    Rank.CreateRankBar(Rank.GetXPFloorForLevel(Rank.GetLevelFromXP(tonumber(Config.xpAmount))), Rank.GetXPCeilingForLevel(Rank.GetLevelFromXP(tonumber(Config.xpAmount))), tonumber(Config.xpAmount), tonumber(Config.xpAmount), Rank.GetLevelFromXP(tonumber(Config.xpAmount)), false)
end)

exports('AddPlayerXP', function(id, xpAmount)
    TriggerServerEvent("Five:AddPlayerXP", Config.Token, id, xpAmount)
end)

exports('RemovePlayerXP', function(id, xpAmount)
    TriggerServerEvent("Five:RemovePlayerXP", Config.Token, id, xpAmount)
end)

exports('GetPlayerXP', function()
    return Config.xpAmount
end)

exports('GetPlayerRank', function()
    return Rank.GetLevelFromXP(Config.xpAmount)
end)

if Config.ActiveCMD == true then 
    RegisterCommand("add", function()
        local myID = GetPlayerServerId(PlayerId())
        local addAmount = math.random(1250, 1500)
        exports.Five_Level:AddPlayerXP(myID, addAmount)
    end)
    RegisterCommand("remove", function()
        local myID = GetPlayerServerId(PlayerId())
        local removeAmount = math.random(1250, 1500)
        exports.Five_Level:RemovePlayerXP(myID, removeAmount)
    end)
    RegisterCommand("xp", function()
        local xp = exports.Five_Level:GetPlayerXP()
        print(xp)
    end)
    RegisterCommand("rank", function()
        local rank = exports.Five_Level:GetPlayerRank()
        print(rank)
    end)
end
