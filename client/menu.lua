if Config.MenuReward == true then

    ESX = nil

    Citizen.CreateThread(function()
        TriggerEvent(Config.ESXSharedObject, function(obj)
            ESX = obj
        end)
        while ESX == nil do Citizen.Wait(0) end
        TriggerServerEvent("EXP:RefreshReward")
    end)

    local claims = {}

    RegisterNetEvent("EXP:RefreshReward")
    AddEventHandler("EXP:RefreshReward", function(_claims)
        claims = _claims
    end)

    function MenuRecomp()
        local main = RageUI.CreateMenu('', 'EXP')
        local options = RageUI.CreateSubMenu(main, '', 'Options')
        local listing = RageUI.CreateSubMenu(main, '', 'Liste des récompenses')
        local leveling = Rank.GetLevelFromXP(Config.xpAmount)

        if Config.BannerColor == true then 
        main:SetRectangleBanner(Config.ColorMenuR, Config.ColorMenuG, Config.ColorMenuB, Config.ColorMenuA)
        options:SetRectangleBanner(Config.ColorMenuR, Config.ColorMenuG, Config.ColorMenuB, Config.ColorMenuA)
        listing:SetRectangleBanner(Config.ColorMenuR, Config.ColorMenuG, Config.ColorMenuB, Config.ColorMenuA)
        end

        local function CanClaim(lvl)
            for k,v in pairs(claims) do
                if lvl == v then
                    return true
                end
            end
            return false
        end  
        
        RageUI.Visible(main, not RageUI.Visible(main))
            while main do
            Citizen.Wait(0)

                RageUI.IsVisible(main, true, true, true, function()

                    RageUI.Separator("")
                    RageUI.Separator("Votre niveau : "..leveling)
                    RageUI.Separator("")

                    RageUI.ButtonWithStyle("Liste des récompenses",nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                    end, listing)

                    RageUI.Separator("")

                    RageUI.ButtonWithStyle("Options",nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                    end, options)

                    end, function()
                    end)     

                    RageUI.IsVisible(options, true, true, true, function()
                    RageUI.Separator("")
                    RageUI.Separator("Votre niveau : "..leveling)
                    RageUI.Separator("")

                    RageUI.ButtonWithStyle("Voir ma progression",nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                        if Selected then 
                            Rank.CreateRankBar(Rank.GetXPFloorForLevel(Rank.GetLevelFromXP(tonumber(Config.xpAmount))), Rank.GetXPCeilingForLevel(Rank.GetLevelFromXP(tonumber(Config.xpAmount))), tonumber(Config.xpAmount), tonumber(Config.xpAmount), Rank.GetLevelFromXP(tonumber(Config.xpAmount)), false)
                        end 
                    end)
        
                    end, function()
                    end)  

                    RageUI.IsVisible(listing, true, true, true, function()
                    
                    RageUI.Separator("")
                    RageUI.Separator("Votre niveau : "..leveling)
                    RageUI.Separator("")
                    for k,v in pairs(Config.WinList) do 
                        local claimed = CanClaim(v.lvl)
                        RageUI.ButtonWithStyle(v.label, "Niveau "..v.lvl, {RightLabel = not claimed and "Récupérer →→" or claimed and "~r~Déjà récupérer"}, leveling >= v.lvl, function(Hovered, Active, Selected)
                            if Selected then
                                if not claimed then
                                    if v.type == "car" then
                                        local carHash = GetHashKey(v.value)
                                        if not HasModelLoaded(carHash) and IsModelInCdimage(carHash) then
                                            RequestModel(carHash)
                                            while not HasModelLoaded(carHash) do
                                                Citizen.Wait(4)
                                            end
                                        end
                                        local vehicle = CreateVehicle(carHash, vector3(0, 0, 0), 0.0, false, false)
                                        local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
                                        TriggerServerEvent("Give:Reward", v, vehicleProps)
                                    else
                                        TriggerServerEvent("Give:Reward", v)
                                    end
                                    ESX.ShowNotification("~g~Vous venez de récupérer votre palier") 
                                else 
                                    ESX.ShowNotification("~r~Vous avez déjà récupérer le palier")
                                end
                            end
                        end)
                    end

                end, function()
                end)  

                if not RageUI.Visible(main) and not RageUI.Visible(options) and not RageUI.Visible(listing) then
                main = RMenu:DeleteType(main, true)
            end
        end
    end

    Keys.Register(Config.OpenXPMenu, 'EXP', 'Ouvrir le menu EXP', function()
        MenuRecomp()
    end)

end