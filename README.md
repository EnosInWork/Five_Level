# nxeRewards

[Voir la vidéo](https://youtu.be/f2SXpMzkUFo)
-
[Clique ici pour rejoindre le Discord](https://discord.gg/5dev)
-

<p>XP système</p>
<p>Rewards menu </p>
<p>Anti-Cheat trigger</p>
<p>Full Config </p>
<p>Full Logs</p>

**Get le rank :**
```
exports.Five_Level:GetPlayerRank()
```
 
**Get l'EXP :** 

```
exports.Five_Level:GetPlayerXP()
```

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