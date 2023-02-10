local gameNum = game.Name

game.Players.PlayerAdded:Connect(function(plr)
	--do httpservice stuff
	local httpService = game:GetService("HttpService")
	local games = httpService:GetAsync("https://github.com/Piggy-Gaming/badge-chain/blob/9c1eabff72bcdd397f99b51e53669e43907dd278/games.json")
	local gamesDecoded = game:GetService("HttpService"):JSONDecode(games)

	local badgeService = game:GetService("BadgeService")
	local badges = httpService:GetAsync("https://badgechain.piggygaming.repl.co/getbadges?id=" .. tostring(game.GameId))
	local badgesDecoded = httpService:JSONDecode(badges)

	local badgeCount = 0
	for i = 1, #badgesDecoded do
		badgeCount = badgeCount + 1
	end
	
	--award badges
	local gui = plr.PlayerGui:WaitForChild("MainGUI"):WaitForChild("Background")
	gui.gameCount.Text = "Chain: " .. gameNum

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
	local nextgame = gamesDecoded[tostring(gameNum + 1)]
	print("Teleporting to placeid " .. nextgame
	game:GetService("TeleportService"):Teleport(nextgame, plr)
	
end) 
print("script loaded")
