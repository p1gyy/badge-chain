local gameId = game.Name
print("ok")

game.Players.PlayerAdded:Connect(function(plr)
	--do httpservice stuff
	local httpService = game:GetService("HttpService")
	local response = httpService:GetAsync("https://pastebin.com/raw/aQ5mzxeF")
	local decoded = game:GetService("HttpService"):JSONDecode(response)

	local badgeService = game:GetService("BadgeService")
	local badges = httpService:GetAsync("https://roapi.piggygaming.repl.co/getbadges?id=" .. tostring(game.GameId))
	local badgesDecoded = httpService:JSONDecode(badges)

	local badgeCount = 0
	for i = 1, #badgesDecoded do
		badgeCount = badgeCount + 1
	end
	
	--award badges
	local gui = plr.PlayerGui:WaitForChild("MainGUI"):WaitForChild("Background")
	gui.gameCount.Text = "Game: " .. gameId .. "/" .. decoded["gamesAmount"]

	for i = 1, #badgesDecoded do
		local badgeid = badgesDecoded[i]["id"]
		if not badgeService:UserHasBadgeAsync(plr.UserId, badgeid) then
			badgeService:AwardBadge(plr.UserId, badgeid)
			wait(0.25)
		end
		gui.badgeCount.Text = "Awarding badge: " .. i .. "/" .. badgeCount
		wait()

	end
	
	--teleport plr
	gui.badgeCount.Text = "Teleporting..."
	print("Teleporting to placeid " .. decoded["games"][tostring(gameId + 1)])
	game:GetService("TeleportService"):Teleport(decoded["games"][tostring(gameId + 1)], plr)
	
end) 
