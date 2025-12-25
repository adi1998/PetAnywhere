
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

modutil.mod.Path.Wrap("FamiliarSetup", function (base, source, args)
    base(source,args)
    print("removing familiar input block")
    if game.MapState.FamiliarUnit ~= nil then
        game.RemoveInteractBlock(game.MapState.FamiliarUnit, "InRun")
        game.SetInteractProperty({ DestinationId = game.MapState.FamiliarUnit.ObjectId, Property = "Distance", Value = 50 })
    end
end)

modutil.mod.Path.Wrap("CanSpecialInteract", function (base, source)
    local result = base(source)
    if (not game.IsComplexHarvestAllowed()) and source == game.MapState.FamiliarUnit and game.CurrentHubRoom == nil then
        return false
    end
    return result
end)

modutil.mod.Path.Wrap("CanReceiveGift", function (base, source)
    local result = base(source)
    if source == game.MapState.FamiliarUnit and game.CurrentHubRoom == nil then
        return false
    end
    return result
end)
