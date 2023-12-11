local P = {2753915549,4442272183,7449423635};
for i,v in pairs(game:GetService("Players"):GetChildren()) do
	shared.Min = i
end

game:GetService("RunService").Heartbeat:Connect(function()
	for i,v in pairs(P) do
		if v == game.PlaceId then
			if game:GetService("Workspace").Map:FindFirstChild("MysticIsland") then
				shared.Mystic = "Spawn"
			else
				shared.Mystic = "Not spawn"
			end
			
			if game:GetService("Lighting").Sky.MoonTextureId == "http://www.roblox.com/asset/?id=9709149431" then
				shared.FullMoon = tostring("100%".." | ".."Full Moon")
			elseif game:GetService("Lighting").Sky.MoonTextureId == "http://www.roblox.com/asset/?id=9709149052" then
				shared.FullMoon = tostring("75%")
			elseif game:GetService("Lighting").Sky.MoonTextureId == "http://www.roblox.com/asset/?id=9709143733" then
				shared.FullMoon = tostring("50%")
			elseif game:GetService("Lighting").Sky.MoonTextureId == "http://www.roblox.com/asset/?id=9709150401" then
				shared.FullMoon = tostring("25%")
			elseif game:GetService("Lighting").Sky.MoonTextureId == "http://www.roblox.com/asset/?id=9709149680" then
				shared.FullMoon = tostring("15%")
			else
				shared.FullMoon = tostring("0%".." | ".."Fake Moon")
			end
		end
	end
end)

for i,v in pairs(P) do
	if v == game.PlaceId then
		local url =
			"https://discord.com/api/webhooks/1172869716323344386/J-OVJOwbB3dzZylgsTbrTJ118ceU3qx4oxMdULQBMVghWYHTJYVazpCrvk4xupV14AXX"
		local data = {
			["embeds"] = {
				{
					["description"] = "**NOTIFICATION**\n```lua\n"..tostring('game:GetService("ReplicatedStorage").__ServerBrowser:InvokeServer("teleport","'..game.JobId..'")').."\n```",
					["color"] = 16711751,
					["fields"] = {
						{["name"] = "**Players Count: **",["value"] = "```yaml\n"..shared.Min.."/"..game:GetService("Players").MaxPlayers.."\n```",["inline"] = true,},
						{["name"] = "**Job ID: **",["value"] = "```yaml\n"..game.JobId.."\n```",["inline"] = true,},
						{["name"] = "**Moon Status :**",["value"] = "```yaml\n"..shared.FullMoon.."\n```",["inline"] = true,},
						{["name"] = "**Mirage Status :**",["value"] = "```lua\n"..tostring(shared.Mystic).."\n```",["inline"] = true,}
					},
					["footer"] = {
						["text"] = "Status Notify - Edward Newgate Hub",
						["icon_url"] = "https://cdn.discordapp.com/attachments/1176767059657510933/1183755688938320002/image.png?ex=65897d65&is=65770865&hm=a80fed522654d20437319d381301fd74f9a42908a72b605bd99cf246cf2a22cf&"
					},
					["timestamp"] = DateTime.now():ToIsoDate(),
					["thumbnail"] = {
						["url"] = "https://cdn.discordapp.com/attachments/1176767059657510933/1183755688938320002/image.png?ex=65897d65&is=65770865&hm=a80fed522654d20437319d381301fd74f9a42908a72b605bd99cf246cf2a22cf&"
					}
				}
			},
		}
		local newdata = game:GetService("HttpService"):JSONEncode(data)

		local headers = {
			["content-type"] = "application/json"
		}
		request = http_request or request or HttpPost or syn.request
		local R = {Url = url, Body = newdata, Method = "POST", Headers = headers}
		request(R)
	end
end
loadstring(game:HttpGet("https://raw.githubusercontent.com/davidcaYTHUEUTS1/Edward-Newgate1/main/blox%20fruit"))()
