This is a fightclub resource where you gain certain buffs while you are in ring and loose them as soon as you leave the ring.

# Location:
`vector3(-506.56, -1709.31, 22.7)`

# Dependencies
* qb-core ([Github](https://github.com/qbcore-framework/qb-core))
* ps-buffs ([Github](https://github.com/Project-Sloth/ps-buffs))
* qb-ambulancejob ([Github](https://github.com/qbcore-framework/qb-ambulancejob))
* Ring MLO (Included) ([Credits](https://www.gta5-mods.com/maps/fight-ring-add-on-sp-oiv-fivem)) 

# Install Guide
```lua
-- Add this in `qb-ambulanVcejob/client/dead.lua` in line 145 before `if isDead then` and after `EnableControlAction(0, 47, true)`
TriggerEvent("playerDeadTriggeredEvent")
```

Note: I dont own the assets of boxing ring, the location was only modified us and all the credits for the model creation goes to [changer](https://www.gta5-mods.com/maps/fight-ring-add-on-sp-oiv-fivem)