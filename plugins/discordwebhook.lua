-- LIB MADE BY M3NTOR! --

DiscordWebHook = {}
DiscordWebHook.__index = DiscordWebHook

function DiscordWebHook.new(webhookURL)
    local self = setmetatable({},DiscordWebHook)
    self.webhookURL = webhookURL
    return self
end

function DiscordWebHook:Send(embed)

    PerformHTTPRequest(self.webhookURL,
    function(status, body, headers, err)
        if status ~= 204 then
            print("Error sending embed:", status, err)
            print("Response body:", body)
        end
    end,
    "POST",
    embed:toJSON(),
    {
        ['Content-Type'] = 'application/json'
    })
end

