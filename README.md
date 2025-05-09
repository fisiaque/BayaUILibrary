<p align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="./README/BayaLogo_White.png">
    <source media="(prefers-color-scheme: light)" srcset="./README/BayaLogo_Black.png">
    <img alt="Mr.Baya" src="./README/BayaLogo.png">
  </picture>
</p>
<h2 align="center">
  A Roblox UI Library
  <br/>
   Catered for ME!
</h2>

## Made with ❤️ by Baya

**Documentation**:

Load library & Store to Global Variable:
```lua
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/fisiaque/BayaUILibrary/main/src.lua", true))();
shared.baya = library;
```

Create GUI:
```lua
local main = library:CreateGui();
```

Create Divider:
```lua
--|| Creates a Divider w/ Text
main:CreateDivider({
	Text = "Hello World";
	Alignment = Enum.TextXAlignment.Center;
});

--|| Creates a Divider for said category i.e main category
main:CreateDivider();
```

Create Info Pane:
```lua
local info = main:CreateInfoPane()

info:CreateDivider({ -- add text
	Text = "Hello World";
	Alignment = Enum.TextXAlignment.Left;
});
```

Create Settings Overlay:
```lua
main:CreateSettingBar()

local uiSettings = library:CreateSetting({
	Name = "Test";
	Icon = getcustomasset("Baya/Assets/Cog.png");
	Size = UDim2.fromOffset(16, 12);
	Position = UDim2.fromOffset(12, 14);
	Function = function(val)
		library:CreateNotification("Settings[test]", tostring(val), 2, "Alert")
	end
});
```

Create Category:
```lua
local test = shared.baya:CreateCategory({
	Name = "Test",
	Icon = "Baya/Assets/ActionIcon.png",
	Size = UDim2.fromOffset(13, 14)
});
```

Create Moduels within Category:
```lua
ESP = test:CreateModule({
	Name = 'ESP',
	Function = function(callback)
		print("ESP: " .. tostring(callback))
	end,
	Tooltip = 'Highlights players or entities through walls'
})
Mode = ESP:CreateDropdown({
	Name = 'Mode',
	List = {'Box', 'Chams'},
	Function = function(val)
		print("MODE: " .. tostring(val))
	end,
	Tooltip = 'Box - Draws a box around players\nChams - Highlights players with see-through colors'
})
Opacity = ESP:CreateSlider({
	Name = 'Opacity',
	Min = 0,
	Max = 1,
	Default = 1,
	Decimal = 4,
	Function = function(val)
		print("OPACITY: " .. tostring(val))
	end,
})
```

Create Button:
```lua
test:CreateButton({
	Name = 'Hello World',
	Function = function(callback)
		shared.baya:CreateNotification("Button", "Hello World pressed", 2, "Warning")
	end,
	Tooltip = "Notify the WORLD!"
});
```

Create Toggle:
```lua
test:CreateToggle({
	Name = 'Hello World 2',
	Function = function(callback)
		if callback then
			shared.baya:CreateNotification("Toggle", "World ON", 2, "Alert")
		else
			shared.baya:CreateNotification("Toggle", "World OFF", 2, "Alert")
		end
	end,
	Tooltip = "World is cool huh!"
});
```

Create Slider:
```lua
test:CreateSlider({
	Name = 'Coolness',
	Min = 1,
	Max = 100,
	Default = math.random(1, 100),
	Function = function(value)
		shared.baya:CreateNotification("Slider", tostring(value), 2, "Alert")
	end,
	Tooltip = "Are you COOL!"
});
```

Create Dropdown List:
```lua
test:CreateDropdown({
	Name = 'Hello Baya',
	List = {"Baya1", "Baya2", "Baya3", "Baya4"},
	Function = function(value)
		shared.baya:CreateNotification("Dropdown", value, 2, "Alert")
	end,
	Tooltip = "Baya UI Library!"
})
```

Create TextBox:
```lua
test0:CreateTextBox({
	Name = 'Text Here',
	Placeholder = 'Any Text Boy',
	Function = function(...)
		local text, enterPressed = table.unpack(...)

		shared.baya:CreateNotification("TextBox: " .. tostring(enterPressed), text, 2, "Alert")
	end,
	Tooltip = "What text are you going to write!"
});
```

Finish Load:
```lua
library:Load();
```

**Customizables**:

Notifications:
*Alert|Warning*
```lua
shared.baya:CreateNotification("?", "?", 5, "Alert");
```

Category Icons:
*ActionIcon.png|PrayerIcon.png*
```lua
Icon = "Baya/Assets/ActionIcon.png";
```

**Tips**:

Single Instance (Put at top):
```lua
repeat task.wait() until game:IsLoaded()

if shared.baya then shared.baya:Uninject() end
if shared.Init then return end

shared.Init = true;
```