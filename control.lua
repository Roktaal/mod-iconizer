require("defines")
require("config")

function message(mes)
	for i, player in pairs(game.players) do
		player.print(mes)
	end
end

function doButtons(player_index, research_name)
	local player = game.get_player(player_index)
	local modlist = player.gui.top.children_names
	local element
	local buttonName
	
	for i = 1, #modlist do
		element = player.gui.top[modlist[i]]

		if buttons[element.name] then
			if buttons[element.name].type ~= "flow" then
				if buttons[element.name].technology then
					if (research_name ~= nil and research_name == buttons[element.name].technology) or player.force.technologies[buttons[element.name].technology].researched then
						player.gui.top[element.name].caption = ""
						player.gui.top[element.name].style = "mod-iconizer_" .. element.name
					end
				else
					player.gui.top[element.name].caption = ""
					player.gui.top[element.name].style = "mod-iconizer_" .. element.name
				end
			else
				buttonName = buttons[element.name].name
				
				if buttons[element.name].technology then
					if (research_name ~= nil and research_name == buttons[element.name].technology) or player.force.technologies[buttons[element.name].technology].researched then
						player.gui.top[element.name][buttonName].caption = ""
						player.gui.top[element.name][buttonName].style = "mod-iconizer_" .. buttonName
					end
				else
					player.gui.top[element.name][buttonName].caption = ""
					player.gui.top[element.name][buttonName].style = "mod-iconizer_" .. buttonName
				end
			end
		end
	end
end

script.on_event(defines.events.on_gui_click, function(event) 
	local element = event.element
	local player = game.get_player(event.player_index)
	
	if buttons[element.name] then
		player.gui.top[element.name].caption = ""
		player.gui.top[element.name].style = "mod-iconizer_" .. element.name
	elseif buttons[element.parent.name] and buttons[element.parent.name].name == element.name then
		player.gui.top[element.parent.name][element.name].caption = ""
		player.gui.top[element.parent.name][element.name].style = "mod-iconizer_" .. element.name
	end
end)

script.on_event(defines.events.on_research_finished, function(event)
	for player_index, player in pairs(game.players) do
		doButtons(player_index, event.research.name)
	end
end)

script.on_event(defines.events.on_player_created, function(event) doButtons(event.player_index, nil) end)
script.on_configuration_changed(function(data) for i = 1, #game.players do doButtons(i, nil) end end)
script.on_init(function() for i = 1, #game.players do doButtons(i, nil) end end)
