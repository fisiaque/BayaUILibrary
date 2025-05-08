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

Load library:
```lua
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/fisiaque/BayaUILibrary/main/src.lua", true))();
```

Create GUI:
```lua
library:CreateGui()
```

Create Category:
```lua
local test = shared.baya:CreateCategory({
	Name = "Test",
	Icon = "Baya/Assets/ActionIcon.png",
	Size = UDim2.fromOffset(13, 14)
});
```

Create Button:
```lua
test:CreateButton({
  Name = 'Hello World',
	Function = function(callback)
		shared.baya:CreateNotification("Button", "Hello World pressed", 2, "Warning")
	end,
	Tooltip = "Notify the WORLD!"
})
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
})
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
})
```

Finish Load:
```lua
library:Load()
```

**Customizables**:

Notifications:
*Alert|Warning*
```lua
shared.baya:CreateNotification("?", "?", 5, "Alert")
```

Category Icons:
*ActionIcon.png|PrayerIcon.png*
```lua
Icon = "Baya/Assets/ActionIcon.png"
```

**Tips**:

Single Instance (Put at top):
```lua
repeat task.wait() until game:IsLoaded()

if shared.baya then shared.baya:Uninject() end
if shared.Init then return end

shared.Init = true
```