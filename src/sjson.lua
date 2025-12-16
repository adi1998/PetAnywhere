local helpTextPath = rom.path.combine(rom.paths.Content(),"Game\\Text\\en\\HelpText.en.sjson")

local helptextorder = {
    "Id",
    "DisplayName",
}

sjson.hook(helpTextPath, function (data)
    local entry = {
        Id = _PLUGIN.guid .. "PetFamiliarUseTextSpecial",
        DisplayName = "{SI} Pet",
    }
    table.insert(data.Texts,sjson.to_object(entry,helptextorder))
end)