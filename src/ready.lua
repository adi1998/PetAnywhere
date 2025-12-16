
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
    print("removing input block")
    print(game.MapState.FamiliarUnit)
    game.RemoveInteractBlock(game.MapState.FamiliarUnit,"InRun")
end)

modutil.mod.Path.Wrap("CanSpecialInteract", function (base, source)
    local result = base(source)
    if game.IsComplexHarvestAllowed() and source == game.MapState.FamiliarUnit then
        return true and result
    elseif (not game.IsComplexHarvestAllowed()) and source == game.MapState.FamiliarUnit and game.CurrentHubRoom == nil then
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
