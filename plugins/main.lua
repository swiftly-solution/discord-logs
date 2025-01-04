local playersname = {}

AddEventHandler("OnPluginStart", function (event)
    if config:Fetch("discord-logs.discord-logs.general_log") then
        SetTimer(config:Fetch("discord-logs.discord-logs.general_log_interval"), function()
            playersname = {}
            local embed = Embed.new()
            local data = config:Fetch("discord-logs.embeds.logs")
            embed:setTitle(data.general_log.title)
            embed:setColor(tostring(data.general_log.color))
            data.general_log.fields[1].value = server:GetMap()
            data.general_log.fields[2].value = playermanager:GetPlayerCount()
            for i = 1, playermanager:GetPlayerCap() do
                local pl = GetPlayer(i-1)
                if pl then
                    table.insert(playersname, pl:CBasePlayerController().PlayerName)
                end
            end
            data.general_log.fields[3].value = "```\n" .. table.concat(playersname, "\n") .. "\n```"
            embed:addField(data.general_log.fields[1].name, data.general_log.fields[1].value, data.general_log.fields[1].inline)
            embed:addField(data.general_log.fields[2].name, data.general_log.fields[2].value, data.general_log.fields[2].inline)
            embed:addField(data.general_log.fields[3].name, data.general_log.fields[3].value, data.general_log.fields[3].inline)
            embed:setTimestamp()
            local webhook = DiscordWebHook.new(config:Fetch("discord-logs.discord-logs.general_log_webhook"))
            webhook:Send(embed)
        end) 
    end
end)


AddEventHandler("OnPlayerConnectFull", function (event)
    local playerid = event:GetInt("userid")
    local player = GetPlayer(playerid)
    if not player or not player:IsValid() then return end
    if player:IsFakeClient() then return end

    if config:Fetch("discord-logs.discord-logs.connectlogs") then
        local embed = Embed.new()
        local data = config:Fetch("discord-logs.embeds.logs")
        embed:setTitle(data.connectlog.title)
        embed:setColor(tostring(data.connectlog.color))
        data.connectlog.fields[1].value = player:CBasePlayerController().PlayerName
        data.connectlog.fields[2].value = player:GetSteamID()
        embed:addField(data.connectlog.fields[1].name, data.connectlog.fields[1].value, data.connectlog.fields[1].inline)
        embed:addField(data.connectlog.fields[2].name, data.connectlog.fields[2].value, data.connectlog.fields[2].inline)
        embed:setTimestamp()
        local webhook = DiscordWebHook.new(config:Fetch("discord-logs.discord-logs.connectwebhook"))
        webhook:Send(embed)
    end
end)

AddEventHandler("OnClientDisconnect", function (event, playerid)
    local player = GetPlayer(playerid)
    if not player then return end
    if player:IsFakeClient() then return end


    if config:Fetch("discord-logs.discord-logs.disconnectlogs") then
        local embed = Embed.new()
        local data = config:Fetch("discord-logs.embeds.logs")
        embed:setTitle(data.disconnectlog.title)
        embed:setColor(tostring(data.disconnectlog.color))
        data.disconnectlog.fields[1].value = player:CBasePlayerController().PlayerName
        data.disconnectlog.fields[2].value = player:GetSteamID()
        embed:addField(data.disconnectlog.fields[1].name, data.disconnectlog.fields[1].value, data.disconnectlog.fields[1].inline)
        embed:addField(data.disconnectlog.fields[2].name, data.disconnectlog.fields[2].value, data.disconnectlog.fields[2].inline)
        embed:setTimestamp()
        local webhook = DiscordWebHook.new(config:Fetch("discord-logs.discord-logs.disconnectwebhook"))
        webhook:Send(embed)
    end
end)