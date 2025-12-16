
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

modutil.mod.Path.Wrap("FamiliarSetup", function (base, source, args)
    base(source,args)
    game.RemoveInteractBlock(game.MapState.Familiar,"InRun")
end)