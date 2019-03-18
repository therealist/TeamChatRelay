STAFFGROUPS = {
	"coowner",
	"moderator",
	"superadmin",
	"owner",
	"founder",
	"admin",
	"trialmod",
	"dev",
	"wizard"
}


function TeamChatGrabber( player, strText, bTeamOnly )

	if ( bTeamOnly ) then
		SetGlobalString("saidteam", player:Team())
		SetGlobalString("saidname", player:Nick())
		SetGlobalString("saidtext", strText)
		if player:Alive() then
			SetGlobalBool("saidalive", true)
		else
			SetGlobalBool("saidalive", false)
		end
		said()
	end

end
hook.Add("PlayerSay", "TeamChatGrabber", TeamChatGrabber)

function said()
	for k, v in pairs (player.GetAll()) do
		if table.HasValue(STAFFGROUPS, v:GetUserGroup()) && v:Team() == TEAM_SPECTATOR then
			local getteam = GetGlobalString("saidteam")
			local aliveornot = GetGlobalBool("saidalive", false)
			if getteam != TEAM_SPECTATOR then 
				if aliveornot then
					ULib.tsayColor(v, false, Color(255, 200, 0), "[TEAM CHAT RELAY] ", Color(team.GetColor(getteam).r, team.GetColor(getteam).g, team.GetColor(getteam).b), GetGlobalString("saidname") .. ": ", Color(255, 255, 255), GetGlobalString("saidtext"))
				else
					ULib.tsayColor(v, false, Color(255, 200, 0), "[TEAM CHAT RELAY] ", Color(255, 0, 0), "*DEAD* ", Color(team.GetColor(getteam).r, team.GetColor(getteam).g, team.GetColor(getteam).b), GetGlobalString("saidname") .. ": ", Color(255, 255, 255), GetGlobalString("saidtext"))
				end
			end
		end
	end
end
