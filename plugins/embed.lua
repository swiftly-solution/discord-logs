-- LIB MADE BY M3NTOR! --
Embed = {}
Embed.__index = Embed

function Embed.new()
    local self = setmetatable({}, Embed)
    self.embed = {
        embeds = {}
    }
    return self
end

function Embed:_ensureEmbed()
    self.embed.embeds[1] = self.embed.embeds[1] or {}
end

function Embed:setColor(color)
    self:_ensureEmbed()
    self.embed.embeds[1].color = color
end

function Embed:setTitle(title)
    self:_ensureEmbed()
    self.embed.embeds[1].title = title
end

function Embed:setURL(url)
    self:_ensureEmbed()
    self.embed.embeds[1].url = url
end

function Embed:setAuthor(name, icon_url, url)
    self:_ensureEmbed()
    self.embed.embeds[1].author = {
        name = name,
        icon_url = icon_url,
        url = url
    }
end

function Embed:setDescription(description)
    self:_ensureEmbed()
    self.embed.embeds[1].description = description
end

function Embed:setThumbnail(url)
    self:_ensureEmbed()
    self.embed.embeds[1].thumbnail = {
        url = url
    }
end

function Embed:addField(name, value, inline)
    self:_ensureEmbed()
    self.embed.embeds[1].fields = self.embed.embeds[1].fields or {}
    table.insert(self.embed.embeds[1].fields, {
        name = name,
        value = tostring(value),
        inline = inline
    })
end

function Embed:setImage(url)
    self:_ensureEmbed()
    self.embed.embeds[1].image = {
        url = url
    }
end

function Embed:setTimestamp()
    self:_ensureEmbed()
    self.embed.embeds[1].timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
end

function Embed:setFooter(text, icon_url)
    self:_ensureEmbed()
    self.embed.embeds[1].footer = {
        text = text,
        icon_url = icon_url
    }
end

function Embed:toJSON()
    return json.encode(self.embed)
end