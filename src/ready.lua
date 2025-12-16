
function mod.dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. mod.dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

game.FamiliarData.FrogFamiliar.SetupEvents[4].GameStateRequirements[1].IsAny = nil
game.FamiliarData.FrogFamiliar.SetupEvents[4].GameStateRequirements[1].IsNone = { "Hub_Main" }

game.FamiliarData.FrogFamiliar.SpecialInteractGameStateRequirements = {}

table.insert(game.FamiliarData.FrogFamiliar.EncounterEndEvents, {
    FunctionName = _PLUGIN.guid .. "RemovePetInputBlock",
})

modutil.mod.Path.Wrap("FamiliarSetup", function (base, source, args)
    base(source,args)
    print("removing input block")
    print(game.MapState.FamiliarUnit)
    game.RemoveInteractBlock(game.MapState.FamiliarUnit,"InRun")
end)

modutil.mod.Path.Wrap("CanSpecialInteract", function (base, source)
    print(mod.dump(source.SpecialInteractFunctionName))
    print(mod.dump(source.SpecialInteractGameStateRequirements))
    print(mod.dump(source.SpecialInteractCooldown))
    print(game.IsComplexHarvestAllowed())
    print(CurrentHubRoom)
    local result = base(source)
    if game.IsComplexHarvestAllowed() and source == game.MapState.FamiliarUnit then
        return true and base(source)
    elseif (not game.IsComplexHarvestAllowed()) and source == game.MapState.FamiliarUnit and CurrentHubRoom == nil then
        return false
    end
    return result
end)

modutil.mod.Path.Wrap("CanReceiveGift", function (base, source)
    print(mod.dump(source.SpecialInteractFunctionName))
    print(mod.dump(source.SpecialInteractGameStateRequirements))
    print(mod.dump(source.SpecialInteractCooldown))
    print(game.IsComplexHarvestAllowed())
    print(CurrentHubRoom)
    local result = base(source)
    if source == game.MapState.FamiliarUnit and CurrentHubRoom == nil then
        return false
    end
    return result
end)


modutil.mod.Path.Wrap("StartEncounter", function (base, currentRun, currentRoom, encounter)
    if not encounter.Completed then
        game.AddInteractBlock(game.MapState.FamiliarUnit,"InRun")
    end
    base(currentRun, currentRoom, encounter)
    if encounter.Completed then
        game.RemoveInteractBlock(game.MapState.FamiliarUnit,"InRun")
    end
end)

function mod.RemovePetInputBlock( familiar )
    game.RemoveInteractBlock(familiar,"InRun")
end