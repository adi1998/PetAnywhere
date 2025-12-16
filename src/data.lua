game.FamiliarData.FrogFamiliar.SetupEvents[4].GameStateRequirements[1].IsAny = nil
game.FamiliarData.FrogFamiliar.SetupEvents[4].GameStateRequirements[1].IsNone = { "Hub_Main" }

game.FamiliarData.FrogFamiliar.SpecialInteractGameStateRequirements = {}

game.FamiliarData.HoundFamiliar.InteractVoiceLines[1].GameStateRequirements = {
    {
        PathFalse = { "CurrentRun", "Hero", "IsDead" },
    },
    {
        Path = { "GameState", "EquippedFamiliar" },
        Comparison = "~=",
        Value = "HoundFamiliar"
    }
}

for _, familiar in ipairs({"CatFamiliar", "RavenFamiliar", "PolecatFamiliar"}) do
    game.FamiliarData[familiar].InteractVoiceLines[1].GameStateRequirements = {
        {
            PathFalse = { "CurrentRun", "Hero", "IsDead" },
        },
        {
            Path = { "GameState", "EquippedFamiliar" },
            Comparison = "~=",
            Value = familiar
        }
    }

    game.FamiliarData[familiar].InteractVoiceLines[2].GameStateRequirements = {
        OrRequirements = {
            {
                PathTrue = { "CurrentRun", "Hero", "IsDead" },
            },
            {
                Path = { "GameState", "EquippedFamiliar" },
                Comparison = "==",
                Value = familiar
            }
        }
    }
end

for _, familiar in ipairs(game.FamiliarOrderData) do
    table.insert(game.FamiliarData[familiar].SetupEvents,{
        FunctionName = "OverwriteSelf",
        Args =
        {
            UseTextSpecial = _PLUGIN.guid .. "PetFamiliarUseTextSpecial"
        },
        GameStateRequirements =
        {
            {
                PathFalse = {"CurrentHubRoom"}
            },
            {
                Path = {"GameState","EquippedFamiliar"},
                Comparison = "==",
                Value = familiar
            }
        },
    })
end