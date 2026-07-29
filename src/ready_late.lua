for petFunction, inputBlock in pairs({
    FrogFamiliarSpecialInteractUnlockedInHub = "PetFamiliarFrog",
    CatFamiliarSpecialInteractUnlockedInHub = "PetFamiliarCat",
    RavenFamiliarSpecialInteractUnlockedInHub = "PetFamiliarRaven",
    HoundFamiliarSpecialInteractUnlockedInHub = "PetFamiliarHound",
    PolecatFamiliarSpecialInteractUnlockedInHu = "PetFamiliarPolecat",
}) do
    modutil.mod.Path.Context.Env(petFunction, function (...)
        modutil.mod.Path.Wrap("AddInputBlock", function (base, args)
            if args.Name == inputBlock then
                game.AddTimerBlock( game.CurrentRun, _PLUGIN.guid .. "FamiliarSpecialInteract" )
            end
            return base(args)
        end)

        modutil.mod.Path.Wrap("RemoveInputBlock", function (base, args)
            if args.Name == inputBlock then
                game.RemoveTimerBlock( game.CurrentRun, _PLUGIN.guid .. "FamiliarSpecialInteract" )
            end
            return base(args)
        end)
    end)
end