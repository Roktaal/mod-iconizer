require("defines")

local buttonName = nil
local buttons = {
	["upgrade-planner-config-button"] = true,
	["blueprintTools"] = true,
	["toggleTrainInfo"] = true,
	["research_Q"] = true,
	["ion-cannon-button"] = true,
}

local flows = {
	["fatControllerButtons"] = "toggleTrainInfo",
}

local technologies = {
	["upgrade-planner-config-button"] = "automated-construction",
	["blueprintTools"] = "automated-construction",
	["toggleTrainInfo"] = "rail-signals",
}

function doButtons(player_index, research_name)
	local player = game.players[player_index]
	local modlist = player.gui.top.children_names

	for i = 1, #modlist do
		if flows[modlist[i]] then
			buttonName = flows[modlist[i]]
		else
			buttonName = modlist[i]
		end
		--game.player.print(buttonName)

		if buttons[modlist[i]] or flows[modlist[i]] then
			player.gui.top[modlist[i]].destroy()
		end
		if not player.gui.top[buttonName] then --and (player.force.technologies[technologies[buttonName]].researched or technologies[buttonName] == research_name) then
			if technologies[buttonName] then
				if player.force.technologies[technologies[buttonName]].researched or technologies[buttonName] == research_name then
					player.gui.top.add({
						type = "button",
						name = buttonName,
						style = "mod-iconizer_" .. buttonName
					})
				end
			else
				player.gui.top.add({
					type = "button",
					name = buttonName,
					style = "mod-iconizer_" .. buttonName
				})
			end
		end
	end
end

script.on_event(defines.events.on_gui_click, function(event)
	local element = event.element
	local player = game.get_player(event.player_index)
	if buttons[element.name] then
		player.gui.top[element.name].caption = ""
	end
end)

script.on_event(defines.events.on_research_finished, function(event)
	for player_index, player in pairs(game.players) do
		doButtons(player_index, event.research.name)
	end
end)

script.on_event(defines.events.on_player_created, function(event) doButtons(event.player_index, nil) end)
script.on_configuration_changed(function(data) for i = 1, #game.players do doButtons(i, nil) end end)
script.on_init(function() for i=1, #game.players do doButtons(i, nil) end end)
