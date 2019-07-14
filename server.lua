----------------------------------------
--- Discord Whitelist, Made by FAXES ---
----------------------------------------

--- Config ---
notWhitelisted = "Hallo! Du wurdest noch nicht gewhitelisted. Bitte tuh dies nun auf unserem Discord!" -- Message displayed when they are not whitelist with the role
noDiscord = "Du musst Discord geöffnet haben um auf dem Server zu Joinen" -- Message displayed when discord is not found

roles = { -- Role nickname(s) needed to pass the whitelist
    "Whitelisted",
    "Role2",
    "Role3",
}


--- Code ---

AddEventHandler("playerConnecting", function(name, setCallback, deferrals)
    local src = source
    deferrals.defer()
    deferrals.update("Checking Permissions")

    for k, v in ipairs(GetPlayerIdentifiers(src)) do
        if string.sub(v, 1, string.len("discord:")) == "discord:" then
            identifierDiscord = v
        end
    end

    if identifierDiscord then
        for i = 1, #roles do
            if exports.discord_perms:IsRolePresent(src, roles[i]) then
                deferrals.done()
            else
                deferrals.done(notWhitelisted)
            end
        end
    else
        deferrals.done(noDiscord)
    end
end)