# nxeRewards
 
** Get le rank :**
```exports.Five_Level:GetPlayerRank()```
 
** Get l'EXP : ** 
```exports.Five_Level:GetPlayerXP()```

**For Add XP in client :** 
 ```
local myID = GetPlayerServerId(PlayerId())
local addAmount = math.random(800, 1000)
exports.Five_Level:AddPlayerXP(myID, addAmount)
```

**For Remove XP in client :**
```
local myID = GetPlayerServerId(PlayerId())
local removeAmount = math.random(800, 1000)
exports.Five_Level:RemovePlayerXP(myID, removeAmount)
```