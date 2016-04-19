data:extend(
	{
	  {
		type = "font",
		name = "mod-iconizer_font",
		from = "default",
		size = 10
	  }
	}
)

for _, button in pairs(buttons) do
	data.raw["gui-style"].default["mod-iconizer_" .. button.name] =
	{
		type = "button_style",
		parent = "button_style",
		width = 34,
		height = 34,
		top_padding = 6,
		right_padding = 0,
		bottom_padding = 0,
		left_padding = 0,
		font = "mod-iconizer_font",
		default_graphical_set =
		{
			type = "monolith",
			monolith_image =
			{
				filename = "__mod-iconizer__/graphics/mod-iconizer_" .. button.name .. ".png",
				priority = "extra-high-no-scale",
				width = 36,
				height = 36,
				x = 0,
				y = 0,
			}
		},
		hovered_graphical_set =
		{
			type = "monolith",
			monolith_image =
			{
				filename = "__mod-iconizer__/graphics/mod-iconizer_" .. button.name .. ".png",
				priority = "extra-high-no-scale",
				width = 36,
				height = 36,
				x = 36,
				y = 0,
			}
		},
		clicked_graphical_set =
		{
			type = "monolith",
			monolith_image =
			{
				filename = "__mod-iconizer__/graphics/mod-iconizer_" .. button.name .. ".png",
				width = 36,
				height = 36,
				x = 36,
				y = 0,
			}
		},
		left_click_sound =
		{
			filename = "__core__/sound/gui-click.ogg",
			volume = 1
		}
	}
end
