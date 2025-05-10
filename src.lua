--______     ______     __  __     ______        __  __     __        __         __     ______     ______     ______     ______     __  __    
--/\  == \   /\  __ \   /\ \_\ \   /\  __ \      /\ \/\ \   /\ \      /\ \       /\ \   /\  == \   /\  == \   /\  __ \   /\  == \   /\ \_\ \   
--\ \  __<   \ \  __ \  \ \____ \  \ \  __ \     \ \ \_\ \  \ \ \     \ \ \____  \ \ \  \ \  __<   \ \  __<   \ \  __ \  \ \  __<   \ \____ \  
-- \ \_____\  \ \_\ \_\  \/\_____\  \ \_\ \_\     \ \_____\  \ \_\     \ \_____\  \ \_\  \ \_____\  \ \_\ \_\  \ \_\ \_\  \ \_\ \_\  \/\_____\ 
--  \/_____/   \/_/\/_/   \/_____/   \/_/\/_/      \/_____/   \/_/      \/_____/   \/_/   \/_____/   \/_/ /_/   \/_/\/_/   \/_/ /_/   \/_____/ 

local libraryapi = {
	Windows = {
		Draggable = {};
	};
	Tooltips = {};
	Categories = {};
	Libraries = {};
	Modules = {};
	Keybinds = {
		Held = {};
		Interact = {"RightShift"}
	};
	Loaded = false;
	Place = game.PlaceId;
	ThreadFix = setthreadidentity and true or false; -- checks if executor suppors setthreadidentity
	Version = "0.0.1"
}

-- variables
local color = {};
local theme = {
	Interface = {
		Hue = 0.63,
		Sat = 0.86,
		Value = 0.91
	};
	Main = Color3.fromRGB(20, 20, 20);
	Text = Color3.fromRGB(200, 200, 200);
	Font = Font.fromEnum(Enum.Font.Arial);
	FontSemiBold = Font.fromEnum(Enum.Font.Arial, Enum.FontWeight.SemiBold);
	Tween = TweenInfo.new(0.15, Enum.EasingStyle.Linear);
};
local tween = {
	tweens = {};
	tweenstwo = {};
}
local assets = { 
	["Baya/Assets/TargetNPC2.png"] = "rbxassetid://77239207133446";
	["Baya/Assets/TargetNPC1.png"] = "rbxassetid://75592962447173";
	["Baya/Assets/TargetPlayers2.png"] = "rbxassetid://123072416930061";
	["Baya/Assets/TargetPlayers1.png"] = "rbxassetid://128003379264185";
	["Baya/Assets/TargetsTab.png"] = "rbxassetid://140358380459563";
	["Baya/Assets/TargetInfoIcon.png"] = "rbxassetid://77997550419795";
	["Baya/Assets/OverlaysTab.png"] = "rbxassetid://116361074159990";
	["Baya/Assets/OverlaysIcon.png"] = "rbxassetid://122285297597247";
	["Baya/Assets/Cog.png"] = "rbxassetid://70765920396000";
	["Baya/Assets/Pin.png"] = "rbxassetid://113308222846418";
	["Baya/Assets/Back.png"] = "rbxassetid://75316536217652";
	["Baya/Assets/Close.png"] = "rbxassetid://102880067633676";
	["Baya/Assets/Warning.png"] = "rbxassetid://125144969372589";
	["Baya/Assets/Alert.png"] = "rbxassetid://102812705220441";
	["Baya/Assets/Info.png"] = "rbxassetid://105237774908134";
	["Baya/Assets/Notification.png"] = "rbxassetid://115871497200510";
	["Baya/Assets/GUILogo.png"] = "rbxassetid://89243102639787";
	["Baya/Assets/ExpandRight.png"] = "rbxassetid://93216503898531";
	["Baya/Assets/ExpandUp.png"] = "rbxassetid://110148963103901";
	["Baya/Assets/ActionIcon.png"] = "rbxassetid://129077738159596";
	["Baya/Assets/PrayerIcon.png"] = "rbxassetid://112615257443345";
	["Baya/Assets/BayaLogo.png"] = "rbxassetid://71142378499430"; 
	["Baya/Assets/Information.png"] = "rbxassetid://71332231979757"; 
}
-- getcustomasset built in-function in exploit executors
local assetfunction = getcustomasset 
local getcustomasset
local marked = "--MARKED: DELETE IF CACHED INCASE BAYA UPDATES.\n"

-- category previous position for window
local pp = UDim2.fromOffset(236, 60)

-- fontsize
local fontsize = Instance.new('GetTextBoundsParams')
fontsize.Width = math.huge

--
local components
local tooltip
local scale
local clickFrame

-- creates a safe reference to a roblox instance object if executor doesn"t already have on pre-built
local cloneref = cloneref or function(obj)
	return obj
end

-- services
local runService = cloneref(game:GetService("RunService"));
local guiService = cloneref(game:GetService("GuiService"));
local inputService = cloneref(game:GetService("UserInputService"));
local tweenService = cloneref(game:GetService("TweenService"));
local textService = cloneref(game:GetService("TextService"))

-- table
local function GetTableSize(tab)
	local ind = 0
	for _ in tab do ind += 1 end
	return ind
end

local function LoopClean(tab)
	for i, v in tab do
		if type(v) == "table" then
			LoopClean(v)
		end
		tab[i] = nil
	end
end

local function RemoveTags(str)
	str = str:gsub('<br%s*/>', '\n')
	return str:gsub('<[^<>]->', '')
end


local getfontsize = function(text, size, font)
	fontsize.Text = text
	fontsize.Size = size

	if typeof(font) == 'Font' then
		fontsize.Font = font
	end

	return textService:GetTextBoundsAsync(fontsize)
end

local function SetDownloadMessage(text)
	if libraryapi.Loaded ~= true then
		local loadingLabel = libraryapi.Downloader

		if not loadingLabel then
			loadingLabel = Instance.new("TextLabel")
			loadingLabel.Size = UDim2.new(1, 0, 0, 40)
			loadingLabel.BackgroundTransparency = 1
			loadingLabel.TextStrokeTransparency = 0
			loadingLabel.TextSize = 20
			loadingLabel.TextColor3 = Color3.new(1, 1, 1)
			loadingLabel.FontFace = theme.Font
			loadingLabel.Parent = libraryapi.gui

			libraryapi.Downloader = loadingLabel
		end

		loadingLabel.Text = "Downloading " .. text
	end
end

-- get asset
local function DownloadFile(path, func)
	if not isfile(path) then
		SetDownloadMessage(path)

		local suc, res = pcall(function()
			return game:HttpGet("https://raw.githubusercontent.com/fisiaque/BayaUILibrary/"..readfile("Baya/Commits/Library.txt").."/"..select(1, path:gsub("Baya/", "")), true)
		end)

		if not suc or res == "404: Not Found" then
			error(res)
		end

		if path:find(".lua") then
			res = marked .. res
		end

		writefile(path, res)
	end

	return (func or readfile)(path)
end
local isfile = isfile or function(file)
	local suc, res = pcall(function()
		return readfile(file)
	end)
	return suc and res ~= nil and res ~= ""
end
local delfile = delfile or function(file)
	writefile(file, "");
end

getcustomasset = not inputService.TouchEnabled and assetfunction and function(path)
	return DownloadFile(path, assetfunction)
end or function(path)
	return assets[path] or ""
end

-- rearrange
local function RearrangeButton(optionapi, _bool)
	optionapi.Enabled = _bool

	if optionapi.Object:FindFirstChild("Arrow") then
		tween:Tween(optionapi.Object.Arrow, theme.Tween, {
			Position = UDim2.new(1, optionapi.Enabled and -14 or -20, 0, 16)
		})
	end

	optionapi.Object.TextColor3 = optionapi.Enabled and Color3.fromHSV(theme.Interface.Hue, theme.Interface.Sat, theme.Interface.Value) or theme.Text;

	if optionapi.Icon then
		optionapi.Icon.ImageColor3 = optionapi.Object.TextColor3
	end

	optionapi.Object.BackgroundColor3 = optionapi.Enabled and color.Lighten(theme.Main, 0.02) or theme.Main;
	optionapi.Settings.Window.Visible = optionapi.Enabled
end

-- check keybinding
local function CheckKeybinds(compare, target, key)
	if type(target) == "table" then
		if table.find(target, key) then
			for i, v in target do
				if not table.find(compare, v) then
					return false
				end
			end
			return true
		end
	end

	return false
end

-- wipe folder
local function WipeFolder(path)
	-- check path
	if not isfolder(path) then return end

	local string = string.gsub(marked, "\n", "")

	for _, file in listfiles(path) do
		local search = select(1, readfile(file):find(string))

		if isfile(file) and search == 1 then
			delfile(file)
		end
	end
end

-- clean 
local function AddMaid(object)
	object.Connections = {}
	function object:Clean(callback)
		if typeof(callback) == "Instance" then
			table.insert(self.Connections, {
				Disconnect = function()
					callback:ClearAllChildren()
					callback:Destroy()
				end
			})
		elseif type(callback) == "function" then
			table.insert(self.Connections, {
				Disconnect = callback
			})
		else
			table.insert(self.Connections, callback)
		end
	end
end

-- 
local function AddTooltip(gui, text)
	if not text then return end

	local optionapi = {
		Visible = true;
		Forced = false;
	}

	local function TooltipMoved(x, y)
		local right = x + 16 + tooltip.Size.X.Offset > (scale.Scale * 1920)

		tooltip.Position = UDim2.fromOffset(
			(right and x - (tooltip.Size.X.Offset * scale.Scale) - 16 or x + 16) / scale.Scale,
			((y + 11) - (tooltip.Size.Y.Offset / 2)) / scale.Scale
		)

		tooltip.Visible = optionapi.Visible
	end

	gui.MouseEnter:Connect(function(x, y)
		local tooltipSize = getfontsize(text, tooltip.TextSize, theme.Font)
		tooltip.Size = UDim2.fromOffset(tooltipSize.X + 10, tooltipSize.Y + 10)
		tooltip.Text = text

		TooltipMoved(x, y)
	end)

	gui.MouseMoved:Connect(TooltipMoved)

	gui.MouseLeave:Connect(function()
		tooltip.Visible = false
	end)

	libraryapi.Tooltips[gui] = optionapi

	return optionapi
end

-- Create Close Button
local function CreateCloseButton(parent, offset)
	local close = Instance.new("ImageButton");
	close.Name = "Close";
	close.Size = UDim2.fromOffset(24, 24);
	close.Position = UDim2.new(1, -35, 0, offset or 9);
	close.BackgroundColor3 = Color3.new(1, 1, 1);
	close.BackgroundTransparency = 1;
	close.AutoButtonColor = false;
	close.Image = getcustomasset("Baya/Assets/Close.png");
	close.ImageColor3 = color.Lighten(theme.Text, 0.2);
	close.ImageTransparency = 0.5;
	close.Parent = parent;

	close.MouseEnter:Connect(function()
		close.ImageTransparency = 0.3;

		tween:Tween(close, theme.Tween, {
			BackgroundTransparency = 0.6
		});
	end);
	close.MouseLeave:Connect(function()
		close.ImageTransparency = 0.5;

		tween:Tween(close, theme.Tween, {
			BackgroundTransparency = 1
		});
	end);

	return close
end

-- make gui draggable
local function Dragify(gui, window)
	libraryapi.Windows.Draggable[gui] = {
		Position = gui.Position;
		CanClick = true
	}

	gui.InputBegan:Connect(function(inputObj)
		if window and not window.Visible then return end -- window has to be visible

		if 
			(inputObj.UserInputType == Enum.UserInputType.MouseButton1 or inputObj.UserInputType == Enum.UserInputType.Touch) 
			and (inputObj.Position.Y - gui.AbsolutePosition.Y < 40 or window)
		then
			local dragPosition = Vector2.new(
				gui.AbsolutePosition.X - inputObj.Position.X,
				gui.AbsolutePosition.Y - inputObj.Position.Y + guiService:GetGuiInset().Y
			) 

			if gui:IsDescendantOf(libraryapi.gui.ScaledFrame) then
				dragPosition /= libraryapi.gui.ScaledFrame.UIScale.Scale
			end

			local changed = inputService.InputChanged:Connect(function(input)
				if input.UserInputType == (inputObj.UserInputType == Enum.UserInputType.MouseButton1 and Enum.UserInputType.MouseMovement or Enum.UserInputType.Touch) and (not libraryapi.Windows.Dragging or libraryapi.Windows.Dragging == gui) then
					libraryapi.Windows.Dragging = gui -- prevents more than 1 window from "stack" dragging

					for _, v in libraryapi.Tooltips do
						if v.Visible and not v.Forced then
							v.Visible = false
						end
					end

					local position = input.Position;
					-- snap to grid if left shift held
					if inputService:IsKeyDown(Enum.KeyCode.LeftShift) then
						dragPosition = (dragPosition // 3) * 3;
						position = (position // 3) * 3;
					end

					local posX = position.X
					local posY = position.Y

					local maxX = (gui.Parent.AbsoluteSize.X - gui.AbsoluteSize.X) 
					local maxY = (gui.Parent.AbsoluteSize.Y - gui.AbsoluteSize.Y) 

					if gui:IsDescendantOf(libraryapi.gui.ScaledFrame) then
						posX /= libraryapi.gui.ScaledFrame.UIScale.Scale
						posY /= libraryapi.gui.ScaledFrame.UIScale.Scale

						maxX /= libraryapi.gui.ScaledFrame.UIScale.Scale
						maxY /= libraryapi.gui.ScaledFrame.UIScale.Scale
					end

					local x = math.clamp((posX) + dragPosition.X, 0, maxX)
					local y = math.clamp((posY) + dragPosition.Y, 0, maxY)

					gui.Position = UDim2.fromOffset(x, y);
				end
			end)

			local ended
			ended = inputObj.Changed:Connect(function()
				if inputObj.UserInputState == Enum.UserInputState.End then
					if gui.Position ~= libraryapi.Windows.Draggable[gui].Position then -- if window has been moved then it won"t toggle after moved
						libraryapi.Windows.Dragging = nil

						libraryapi.Windows.Draggable[gui].Position = gui.Position
						libraryapi.Windows.Draggable[gui].CanClick = false

						task.delay(.25, function()
							libraryapi.Windows.Draggable[gui].CanClick = true
						end)
					end
					for _, v in libraryapi.Tooltips do
						if not v.Visible and not v.Forced then
							v.Visible = true
						end
					end
					if changed then
						changed:Disconnect()
					end
					if ended then
						ended:Disconnect()
					end
				end
			end)
		end
	end)
end

-- generates a random string
local function RandomString()
	local array = {};

	for i = 1, math.random(10, 100) do
		array[i] = string.char(math.random(32, 126))
	end

	return table.concat(array)
end

-- colors
do
	function color.Darken(col, num)
		local h, s, v = col:ToHSV()
		return Color3.fromHSV(h, s, math.clamp(select(3, theme.Main:ToHSV()) > 0.5 and v + num or v - num, 0, 1))
	end

	function color.Lighten(col, num)
		local h, s, v = col:ToHSV()
		return Color3.fromHSV(h, s, math.clamp(select(3, theme.Main:ToHSV()) > 0.5 and v - num or v + num, 0, 1))
	end
end

-- tween
do
	function tween:Tween(obj, tweeninfo, goal, tab)
		tab = tab or self.tweens
		if tab[obj] then
			tab[obj]:Cancel()
			tab[obj] = nil
		end

		if obj.Parent and obj.Visible then
			tab[obj] = tweenService:Create(obj, tweeninfo, goal)
			tab[obj].Completed:Once(function()
				if tab then
					tab[obj] = nil
					tab = nil
				end
			end)
			tab[obj]:Play()
		else
			for i, v in goal do
				obj[i] = v
			end
		end
	end

	function tween:Cancel(obj)
		if self.tweens[obj] then
			self.tweens[obj]:Cancel()
			self.tweens[obj] = nil
		end
	end
end

libraryapi.Libraries = {
	color = color;
	getcustomasset = getcustomasset;
	getfontsize = getfontsize;
	tween = tween;
	theme = theme;
}

components = {
	Button = function(optionSettings, children, api)
		local moduleapi = {
			Enabled = false;
			Category = api.Name or api.Button.Name;
			Running = false;
		}

		local hovered = false;

		local button = Instance.new("TextButton");
		button.Name = optionSettings.Name;
		button.Size = UDim2.fromOffset(220, 40);
		button.BackgroundColor3 = color.Darken(children.BackgroundColor3, optionSettings.Darker and 0.02 or 0)
		button.BorderSizePixel = 0;
		button.AutoButtonColor = false;
		button.Text = "            " .. optionSettings.Name;
		button.TextXAlignment = Enum.TextXAlignment.Left;
		button.TextColor3 = color.Darken(theme.Text, 0.16);
		button.TextSize = 14;
		button.FontFace = theme.Font;
		button.Parent = children;

		AddTooltip(button, optionSettings.Tooltip);

		local gradient = Instance.new("UIGradient");
		gradient.Rotation = 90;
		gradient.Enabled = false;
		gradient.Parent = button;

		moduleapi.Children = children;
		moduleapi.Object = button

		optionSettings.Function = optionSettings.Function or function() end

		AddMaid(moduleapi);

		function moduleapi:Click(multiple)
			if moduleapi.Running ~= false then return end
			moduleapi.Running = true

			if libraryapi.ThreadFix then
				setthreadidentity(8);
			end

			self.Enabled = true;
			gradient.Enabled = true;

			moduleapi.Object.TextColor3 = moduleapi.Enabled and Color3.fromHSV(theme.Interface.Hue, theme.Interface.Sat, theme.Interface.Value) or theme.Text;
			moduleapi.Object.BackgroundColor3 = moduleapi.Enabled and color.Lighten(theme.Main, 0.02) or theme.Main;

			task.spawn(optionSettings.Function, self.Enabled);

			task.wait(.02)

			self.Enabled = false;
			gradient.Enabled = false;

			moduleapi.Object.TextColor3 = moduleapi.Enabled and Color3.fromHSV(theme.Interface.Hue, theme.Interface.Sat, theme.Interface.Value) or theme.Text;
			moduleapi.Object.BackgroundColor3 = moduleapi.Enabled and color.Lighten(theme.Main, 0.02) or theme.Main;

			for _, v in self.Connections do
				v:Disconnect();
			end

			table.clear(self.Connections);

			moduleapi.Running = false
		end

		button.MouseEnter:Connect(function()
			hovered = true;

			if not moduleapi.Enabled then
				button.TextColor3 = theme.Text;
				button.BackgroundColor3 = color.Lighten(theme.Main, 0.02);
			end
		end)
		button.MouseLeave:Connect(function()
			hovered = false;

			if not moduleapi.Enabled then
				button.TextColor3 = color.Darken(theme.Text, 0.16);
				button.BackgroundColor3 = theme.Main;
			end
		end)
		button.MouseButton1Click:Connect(function()
			moduleapi:Click();
		end)

		moduleapi.Object = button;
		libraryapi.Modules[button.Name] = moduleapi;

		local sorting = {}
		for _, v in libraryapi.Modules do
			sorting[v.Category] = sorting[v.Category] or {};
			table.insert(sorting[v.Category], v.Name);
		end

		for _, sort in sorting do
			table.sort(sort);

			for i, v in sort do
				libraryapi.Modules[v].Index = i;
				libraryapi.Modules[v].Object.LayoutOrder = i;
				libraryapi.Modules[v].Children.LayoutOrder = i;
			end
		end

		return moduleapi
	end;
	Toggle = function(optionSettings, children, api)
		local moduleapi = {
			Type = 'Toggle';
			Category = api.Name or api.Button.Name;
			Enabled = false;
		}

		local hovered = false

		local toggle = Instance.new("TextButton");
		toggle.Name = optionSettings.Name .. "Toggle";
		toggle.Size = UDim2.new(1, 0, 0, 30);
		toggle.BackgroundColor3 = color.Darken(children.BackgroundColor3, optionSettings.Darker and 0.02 or 0)
		toggle.BorderSizePixel = 0;
		toggle.AutoButtonColor = false;
		toggle.Visible = optionSettings.Visible == nil or optionSettings.Visible;
		toggle.Text = "            " .. optionSettings.Name;
		toggle.TextXAlignment = Enum.TextXAlignment.Left;
		toggle.TextColor3 = color.Darken(theme.Text, 0.16);
		toggle.TextSize = 14;
		toggle.FontFace = theme.Font;
		toggle.Parent = children;

		AddTooltip(toggle, optionSettings.Tooltip);

		local knobHolder = Instance.new("Frame");
		knobHolder.Name = "Knob";
		knobHolder.Size = UDim2.fromOffset(22, 12);
		knobHolder.Position = UDim2.new(1, -30, 0, 9);
		knobHolder.BackgroundColor3 = color.Lighten(theme.Main, 0.14);
		knobHolder.Parent = toggle;

		local knob = knobHolder:Clone();
		knob.Size = UDim2.fromOffset(8, 8);
		knob.Position = UDim2.fromOffset(2, 2);
		knob.BackgroundColor3 = theme.Main;
		knob.Parent = knobHolder;

		optionSettings.Function = optionSettings.Function or function() end;

		AddMaid(moduleapi);

		function moduleapi:Toggle()
			self.Enabled = not self.Enabled;

			tween:Tween(knobHolder, theme.Tween, {
				BackgroundColor3 = self.Enabled and Color3.fromHSV(theme.Interface.Hue, theme.Interface.Sat, theme.Interface.Value) or (hovered and color.Lighten(theme.Main, 0.37) or color.Lighten(theme.Main, 0.14))
			});
			tween:Tween(knob, theme.Tween, {
				Position = UDim2.fromOffset(self.Enabled and 12 or 2, 2)
			});

			if not self.Enabled then
				for _, v in self.Connections do
					v:Disconnect();
				end

				table.clear(self.Connections);
			end

			optionSettings.Function(self.Enabled);
		end

		toggle.MouseEnter:Connect(function()
			hovered = true;

			if not moduleapi.Enabled then
				tween:Tween(knobHolder, theme.Tween, {
					BackgroundColor3 = color.Lighten(theme.Main, 0.37)
				});

				toggle.TextColor3 = theme.Text;
				toggle.BackgroundColor3 = color.Lighten(theme.Main, 0.02);
			end
		end)
		toggle.MouseLeave:Connect(function()
			hovered = false;

			if not moduleapi.Enabled then
				tween:Tween(knobHolder, theme.Tween, {
					BackgroundColor3 = color.Lighten(theme.Main, 0.14)
				});

				toggle.TextColor3 = color.Darken(theme.Text, 0.16);
				toggle.BackgroundColor3 = theme.Main;
			end
		end)
		toggle.MouseButton1Click:Connect(function()
			moduleapi:Toggle();
		end)

		moduleapi.Object = toggle;
		libraryapi.Modules[toggle.Name] = moduleapi;

		local sorting = {}
		for _, v in libraryapi.Modules do
			sorting[v.Category] = sorting[v.Category] or {};
			table.insert(sorting[v.Category], v.Name);
		end

		for _, sort in sorting do
			table.sort(sort);

			for i, v in sort do
				libraryapi.Modules[v].Index = i;
				libraryapi.Modules[v].Object.LayoutOrder = i;
				libraryapi.Modules[v].Children.LayoutOrder = i;
			end
		end

		return moduleapi
	end;
	Dropdown = function(optionSettings, children, api)
		local moduleapi = {
			Type = "Dropdown",
			Category = api.Name or api.Button.Name;
			Value = optionSettings.List[1] or "None",
			Index = 0
		}

		local dropdown = Instance.new("TextButton");
		dropdown.Name = optionSettings.Name .. "Dropdown";
		dropdown.Size = UDim2.new(1, 0, 0, 40);
		dropdown.BackgroundColor3 = color.Darken(children.BackgroundColor3, optionSettings.Darker and 0.02 or 0);
		dropdown.BorderSizePixel = 0;
		dropdown.AutoButtonColor = false;
		dropdown.Visible = optionSettings.Visible == nil or optionSettings.Visible;
		dropdown.Text = "";
		dropdown.Parent = children;

		AddTooltip(dropdown, optionSettings.Tooltip or optionSettings.Name)

		local bg = Instance.new("Frame");
		bg.Name = "Background";
		bg.Size = UDim2.new(1, -20, 1, -9);
		bg.Position = UDim2.fromOffset(10, 4);
		bg.BackgroundColor3 = color.Lighten(theme.Main, 0.034);
		bg.Parent = dropdown;

		local button = Instance.new("TextButton");
		button.Name = "Dropdown";
		button.Size = UDim2.new(1, -2, 1, -2);
		button.Position = UDim2.fromOffset(1, 1);
		button.BackgroundColor3 = theme.Main;
		button.AutoButtonColor = false;
		button.Text = "";
		button.Parent = bg;

		local title = Instance.new("TextLabel");
		title.Name = "Title";
		title.Size = UDim2.new(1, 0, 0, 29);
		title.BackgroundTransparency = 1;
		title.Text = "         " .. optionSettings.Name.." - " .. moduleapi.Value;
		title.TextXAlignment = Enum.TextXAlignment.Left;
		title.TextColor3 = color.Darken(theme.Text, 0.16);
		title.TextSize = 13;
		title.TextTruncate = Enum.TextTruncate.AtEnd;
		title.FontFace = theme.Font;
		title.Parent = button;

		local arrow = Instance.new("ImageLabel");
		arrow.Name = "Arrow";
		arrow.Size = UDim2.fromOffset(4, 8);
		arrow.Position = UDim2.new(1, -17, 0, 11);
		arrow.BackgroundTransparency = 1;
		arrow.Image = getcustomasset("Baya/Assets/ExpandRight.png");
		arrow.ImageColor3 = Color3.fromRGB(140, 140, 140);
		arrow.Rotation = 90;
		arrow.Parent = button;

		optionSettings.Function = optionSettings.Function or function() end;

		AddMaid(moduleapi);

		local dropdownChildren;

		function moduleapi:Change(list)
			optionSettings.List = list or {};
			if not table.find(optionSettings.List, self.Value) then
				self:SetValue(self.Value);
			end
		end

		function moduleapi:SetValue(val, mouse)
			self.Value = table.find(optionSettings.List, val) and val or optionSettings.List[1] or "None";

			title.Text = "         " .. optionSettings.Name .. " - " .. self.Value;

			if dropdownChildren then
				arrow.Rotation = 90;
				dropdownChildren:Destroy();
				dropdownChildren = nil;
				dropdown.Size = UDim2.new(1, 0, 0, 40);
			end

			optionSettings.Function(self.Value, mouse)

			for _, v in self.Connections do
				v:Disconnect();
			end

			table.clear(self.Connections);
		end

		button.MouseButton1Click:Connect(function()
			if not dropdownChildren then
				arrow.Rotation = 270;

				dropdown.Size = UDim2.new(1, 0, 0, 40 + (#optionSettings.List - 1) * 26);

				dropdownChildren = Instance.new("Frame");
				dropdownChildren.Name = "Children";
				dropdownChildren.Size = UDim2.new(1, 0, 0, (#optionSettings.List - 1) * 26);
				dropdownChildren.Position = UDim2.fromOffset(0, 27);
				dropdownChildren.BackgroundTransparency = 1;
				dropdownChildren.Parent = button;

				local ind = 0

				for _, v in optionSettings.List do
					if v == moduleapi.Value then continue end

					local dropdownOption = Instance.new("TextButton");
					dropdownOption.Name = v .. "Option";
					dropdownOption.Size = UDim2.new(1, 0, 0, 26);
					dropdownOption.Position = UDim2.fromOffset(0, ind * 26);
					dropdownOption.BackgroundColor3 = theme.Main;
					dropdownOption.BorderSizePixel = 0;
					dropdownOption.AutoButtonColor = false;
					dropdownOption.Text = "         " .. v;
					dropdownOption.TextXAlignment = Enum.TextXAlignment.Left;
					dropdownOption.TextColor3 = color.Darken(theme.Text, 0.16);
					dropdownOption.TextSize = 13;
					dropdownOption.TextTruncate = Enum.TextTruncate.AtEnd;
					dropdownOption.FontFace = theme.Font;
					dropdownOption.Parent = dropdownChildren;
					dropdownOption.MouseEnter:Connect(function()
						tween:Tween(dropdownOption, theme.Tween, {
							BackgroundColor3 = color.Lighten(theme.Main, 0.02)
						});
					end);

					dropdownOption.MouseLeave:Connect(function()
						tween:Tween(dropdownOption, theme.Tween, {
							BackgroundColor3 = theme.Main
						});
					end);

					dropdownOption.MouseButton1Click:Connect(function()
						moduleapi:SetValue(v, true);
					end);

					ind += 1;
				end
			else
				moduleapi:SetValue(moduleapi.Value, true);
			end
		end)

		dropdown.MouseEnter:Connect(function()
			tween:Tween(bg, theme.Tween, {
				BackgroundColor3 = color.Lighten(theme.Main, 0.0875)
			})

			dropdown.TextColor3 = theme.Text;
			dropdown.BackgroundColor3 = color.Lighten(theme.Main, 0.02);
		end)
		dropdown.MouseLeave:Connect(function()
			tween:Tween(bg, theme.Tween, {
				BackgroundColor3 = color.Lighten(theme.Main, 0.034)
			})

			dropdown.TextColor3 = color.Darken(theme.Text, 0.16);
			dropdown.BackgroundColor3 = theme.Main;
		end)

		moduleapi.Object = dropdown;
		libraryapi.Modules[dropdown.Name] = moduleapi;

		local sorting = {}
		for _, v in libraryapi.Modules do
			sorting[v.Category] = sorting[v.Category] or {};
			table.insert(sorting[v.Category], v.Name);
		end

		for _, sort in sorting do
			table.sort(sort);

			for i, v in sort do
				libraryapi.Modules[v].Index = i;
				libraryapi.Modules[v].Object.LayoutOrder = i;
				libraryapi.Modules[v].Children.LayoutOrder = i;
			end
		end

		return moduleapi
	end;
	Slider = function(optionSettings, children, api)
		local moduleapi = {
			Type = 'Slider';
			Category = api.Name or api.Button.Name;
			Value = optionSettings.Default or optionSettings.Min;
			Max = optionSettings.Max;
		}

		local slider = Instance.new("TextButton");
		slider.Name = optionSettings.Name .. "Slider";
		slider.Size = UDim2.new(1, 0, 0, 50);
		slider.BackgroundColor3 = color.Darken(children.BackgroundColor3, optionSettings.Darker and 0.02 or 0);
		slider.BorderSizePixel = 0;
		slider.AutoButtonColor = false;
		slider.Visible = optionSettings.Visible == nil or optionSettings.Visible;
		slider.Text = "";
		slider.Parent = children;

		AddTooltip(slider, optionSettings.Tooltip)

		local title = Instance.new("TextLabel");
		title.Name = "Title";
		title.Size = UDim2.fromOffset(60, 30);
		title.Position = UDim2.fromOffset(10, 2);
		title.BackgroundTransparency = 1;
		title.Text = optionSettings.Name;
		title.TextXAlignment = Enum.TextXAlignment.Left;
		title.TextColor3 = color.Darken(theme.Text, 0.16);
		title.TextSize = 11;
		title.FontFace = theme.Font;
		title.Parent = slider;

		local valueButton = Instance.new("TextButton");
		valueButton.Name = "Value";
		valueButton.Size = UDim2.fromOffset(60, 15);
		valueButton.Position = UDim2.new(1, -69, 0, 9);
		valueButton.BackgroundTransparency = 1;
		valueButton.Text = moduleapi.Value .. (optionSettings.Suffix and " " .. (type(optionSettings.Suffix) == "function" and optionSettings.Suffix(moduleapi.Value) or optionSettings.Suffix) or "");
		valueButton.TextXAlignment = Enum.TextXAlignment.Right;
		valueButton.TextColor3 = color.Darken(theme.Text, 0.16);
		valueButton.TextSize = 11;
		valueButton.FontFace = theme.Font;
		valueButton.Parent = slider;

		local valueBox = Instance.new("TextBox");
		valueBox.Name = "Box";
		valueBox.Size = valueButton.Size;
		valueBox.Position = valueButton.Position;
		valueBox.BackgroundTransparency = 1;
		valueBox.Visible = false;
		valueBox.Text = moduleapi.Value;
		valueBox.TextXAlignment = Enum.TextXAlignment.Right;
		valueBox.TextColor3 = color.Darken(theme.Text, 0.16);
		valueBox.TextSize = 11;
		valueBox.FontFace = theme.Font;
		valueBox.ClearTextOnFocus = false;
		valueBox.Parent = slider;

		local bg = Instance.new("Frame");
		bg.Name = "Slider";
		bg.Size = UDim2.new(1, -20, 0, 2);
		bg.Position = UDim2.fromOffset(10, 37);
		bg.BackgroundColor3 = color.Lighten(theme.Main, 0.034);
		bg.BorderSizePixel = 0;
		bg.Parent = slider;

		local fill = bg:Clone();
		fill.Name = "Fill";
		fill.Size = UDim2.fromScale(math.clamp((moduleapi.Value - optionSettings.Min) / optionSettings.Max, 0.04, 0.96), 1)
		fill.Position = UDim2.new()
		fill.BackgroundColor3 = Color3.fromHSV(theme.Interface.Hue, theme.Interface.Sat, theme.Interface.Value)
		fill.Parent = bg

		local knobHolder = Instance.new("Frame");
		knobHolder.Name = "Knob";
		knobHolder.Size = UDim2.fromOffset(24, 4);
		knobHolder.Position = UDim2.fromScale(1, 0.5);
		knobHolder.AnchorPoint = Vector2.new(0.5, 0.5);
		knobHolder.BackgroundColor3 = slider.BackgroundColor3;
		knobHolder.BorderSizePixel = 0;
		knobHolder.Parent = fill;

		local knob = Instance.new("Frame");
		knob.Name = "Knob";
		knob.Size = UDim2.fromOffset(14, 14);
		knob.Position = UDim2.fromScale(0.5, 0.5);
		knob.AnchorPoint = Vector2.new(0.5, 0.5);
		knob.BackgroundColor3 = Color3.fromHSV(theme.Interface.Hue, theme.Interface.Sat, theme.Interface.Value);
		knob.Parent = knobHolder;

		optionSettings.Function = optionSettings.Function or function() end
		optionSettings.Decimal = optionSettings.Decimal or 1

		AddMaid(moduleapi);

		function moduleapi:Color(hue, sat, val)
			fill.BackgroundColor3 = Color3.fromHSV(hue, sat, val)
			knob.BackgroundColor3 = fill.BackgroundColor3
		end

		function moduleapi:SetValue(value, pos, final)
			if tonumber(value) == math.huge or value ~= value then return end

			local check = self.Value ~= value

			self.Value = value

			tween:Tween(fill, theme.Tween, {
				Size = UDim2.fromScale(math.clamp(pos or math.clamp(value / optionSettings.Max, 0, 1), 0.04, 0.96), 1)
			})

			valueButton.Text = self.Value .. (optionSettings.Suffix and " " .. (type(optionSettings.Suffix) == "function" and optionSettings.Suffix(self.Value) or optionSettings.Suffix) or "")

			if check or final then
				optionSettings.Function(value, final)
			end

			for _, v in self.Connections do
				v:Disconnect();
			end

			table.clear(self.Connections);
		end

		slider.InputBegan:Connect(function(inputObj)
			if libraryapi.Windows.Dragging ~= nil then return end -- makes sure it doesn't change when dragging gui

			if
				(inputObj.UserInputType == Enum.UserInputType.MouseButton1 or inputObj.UserInputType == Enum.UserInputType.Touch)
				and (inputObj.Position.Y - slider.AbsolutePosition.Y) > (20 * scale.Scale)
			then
				local newPosition = math.clamp((inputObj.Position.X - bg.AbsolutePosition.X) / bg.AbsoluteSize.X, 0, 1)

				moduleapi:SetValue(math.floor((optionSettings.Min + (optionSettings.Max - optionSettings.Min) * newPosition) * optionSettings.Decimal) / optionSettings.Decimal, newPosition)

				local lastValue = moduleapi.Value
				local lastPosition = newPosition

				local changed = inputService.InputChanged:Connect(function(input)
					if input.UserInputType == (inputObj.UserInputType == Enum.UserInputType.MouseButton1 and Enum.UserInputType.MouseMovement or Enum.UserInputType.Touch) then
						local newPosition = math.clamp((input.Position.X - bg.AbsolutePosition.X) / bg.AbsoluteSize.X, 0, 1)

						moduleapi:SetValue(math.floor((optionSettings.Min + (optionSettings.Max - optionSettings.Min) * newPosition) * optionSettings.Decimal) / optionSettings.Decimal, newPosition)

						lastValue = moduleapi.Value
						lastPosition = newPosition
					end
				end)

				local ended
				ended = inputObj.Changed:Connect(function()
					if inputObj.UserInputState == Enum.UserInputState.End then
						if changed then
							changed:Disconnect()
						end
						if ended then
							ended:Disconnect()
						end
						moduleapi:SetValue(lastValue, lastPosition, true)
					end
				end)
			end
		end)

		slider.MouseEnter:Connect(function()
			tween:Tween(knob, theme.Tween, {
				Size = UDim2.fromOffset(16, 16)
			})
		end)
		slider.MouseLeave:Connect(function()
			tween:Tween(knob, theme.Tween, {
				Size = UDim2.fromOffset(14, 14)
			})
		end)

		valueButton.MouseButton1Click:Connect(function()
			valueButton.Visible = false

			valueBox.Visible = true
			valueBox.Text = moduleapi.Value

			valueBox:CaptureFocus()
		end)

		valueBox.FocusLost:Connect(function(enter)
			valueButton.Visible = true

			valueBox.Visible = false

			if enter and tonumber(valueBox.Text) then
				moduleapi:SetValue(tonumber(valueBox.Text), nil, true)
			end
		end)

		moduleapi.Object = slider
		libraryapi.Modules[slider.Name] = moduleapi;

		local sorting = {}
		for _, v in libraryapi.Modules do
			sorting[v.Category] = sorting[v.Category] or {};
			table.insert(sorting[v.Category], v.Name);
		end

		for _, sort in sorting do
			table.sort(sort);

			for i, v in sort do
				libraryapi.Modules[v].Index = i;
				libraryapi.Modules[v].Object.LayoutOrder = i;
				libraryapi.Modules[v].Children.LayoutOrder = i;
			end
		end

		return moduleapi
	end;
	TextBox = function(optionSettings, children, api)
		local moduleapi = {
			Type = "TextBox",
			Category = api.Name or api.Button.Name;
			Value = optionSettings.Default or "",
			Index = 0
		}

		local textBox = Instance.new("TextButton");
		textBox.Name = optionSettings.Name .. "TextBox";
		textBox.Size = UDim2.new(1, 0, 0, 58);
		textBox.BackgroundColor3 = color.Darken(children.BackgroundColor3, optionSettings.Darker and 0.02 or 0);
		textBox.BorderSizePixel = 0;
		textBox.AutoButtonColor = false;
		textBox.Visible = optionSettings.Visible == nil or optionSettings.Visible;
		textBox.Text = "";
		textBox.Parent = children;

		AddTooltip(textBox, optionSettings.Tooltip)

		local title = Instance.new("TextLabel");
		title.Size = UDim2.new(1, -10, 0, 20);
		title.Position = UDim2.fromOffset(10, 3);
		title.BackgroundTransparency = 1;
		title.Text = optionSettings.Name;
		title.TextXAlignment = Enum.TextXAlignment.Left;
		title.TextColor3 = theme.Text;
		title.TextSize = 12;
		title.FontFace = theme.Font;
		title.Parent = textBox;

		local bg = Instance.new("Frame");
		bg.Name = "Background";
		bg.Size = UDim2.new(1, -20, 0, 29);
		bg.Position = UDim2.fromOffset(10, 23);
		bg.BackgroundColor3 = color.Lighten(theme.Main, 0.02);
		bg.Parent = textBox;

		local box = Instance.new("TextBox");
		box.Size = UDim2.new(1, -8, 1, 0);
		box.Position = UDim2.fromOffset(8, 0);
		box.BackgroundTransparency = 1;
		box.Text = optionSettings.Default or "";
		box.PlaceholderText = optionSettings.Placeholder or "Click to set";
		box.TextXAlignment = Enum.TextXAlignment.Left;
		box.TextColor3 = color.Darken(theme.Text, 0.16);
		box.PlaceholderColor3 = color.Darken(theme.Text, 0.31);
		box.TextSize = 12;
		box.FontFace = theme.Font;
		box.ClearTextOnFocus = false;
		box.Parent = bg;

		optionSettings.Function = optionSettings.Function or function() end

		AddMaid(moduleapi);

		function moduleapi:SetValue(val, enter)
			self.Value = val;

			box.Text = val;

			local args = {val, enter};
			optionSettings.Function(args);

			for _, v in self.Connections do
				v:Disconnect();
			end

			table.clear(self.Connections);
		end

		textBox.MouseButton1Click:Connect(function()
			box:CaptureFocus()
		end)

		box.FocusLost:Connect(function(enter)
			moduleapi:SetValue(box.Text, enter)
		end)
		box:GetPropertyChangedSignal('Text'):Connect(function()
			moduleapi:SetValue(box.Text)
		end)

		moduleapi.Object = textBox
		libraryapi.Modules[textBox.Name] = moduleapi;

		local sorting = {}
		for _, v in libraryapi.Modules do
			sorting[v.Category] = sorting[v.Category] or {};
			table.insert(sorting[v.Category], v.Name);
		end

		for _, sort in sorting do
			table.sort(sort);

			for i, v in sort do
				libraryapi.Modules[v].Index = i;
				libraryapi.Modules[v].Object.LayoutOrder = i;
				libraryapi.Modules[v].Children.LayoutOrder = i;
			end
		end

		return moduleapi
	end;
	Divider = function(textSettings, children)
		local divider = Instance.new("Frame");
		divider.Name = "Divider";
		divider.Size = UDim2.new(1, 0, 0, 1);
		divider.BackgroundColor3 = color.Lighten(theme.Main, 0.02);
		divider.BorderSizePixel = 0;
		divider.Parent = children;

		if textSettings then
			local label = Instance.new("TextLabel");
			label.Name = "DividerLabel";
			label.Size = UDim2.fromOffset(218, 27);
			label.BackgroundTransparency = 1;
			label.Text = "          " .. textSettings.Text:upper();
			label.TextXAlignment = textSettings.Alignment;
			label.TextColor3 = color.Darken(theme.Text, 0.43);
			label.TextSize = 9;
			label.FontFace = theme.Font;
			label.Parent = children;
			divider.Position = UDim2.fromOffset(0, 26);
			divider.Parent = label;
		end
	end;
	Targets = function(optionSettings, children, api)
		local optionapi = {
			Type = "Targets",
			Index = GetTableSize(api.Options)
		}
		
		local textList = Instance.new("TextButton");
		textList.Name = "Targets";
		textList.Size = UDim2.new(1, 0, 0, 50);
		textList.BackgroundColor3 = color.Darken(children.BackgroundColor3, optionSettings.Darker and 0.02 or 0);
		textList.BorderSizePixel = 0;
		textList.AutoButtonColor = false;
		textList.Visible = optionSettings.Visible == nil or optionSettings.Visible;
		textList.Text = "";
		textList.Parent = children;

		AddTooltip(textList, optionSettings.Tooltip);

		local bkg = Instance.new("Frame");
		bkg.Name = "BKG";
		bkg.Size = UDim2.new(1, -20, 1, -9);
		bkg.Position = UDim2.fromOffset(10, 4);
		bkg.BackgroundColor3 = color.Lighten(theme.Main, 0.034);
		bkg.Parent = textList;

		local button = Instance.new("TextButton");
		button.Name = "TextList";
		button.Size = UDim2.new(1, -2, 1, -2);
		button.Position = UDim2.fromOffset(1, 1);
		button.BackgroundColor3 = theme.Main;
		button.AutoButtonColor = false;
		button.Text = "";
		button.Parent = bkg;

		local buttonTitle = Instance.new("TextLabel");
		buttonTitle.Name = "Title";
		buttonTitle.Size = UDim2.new(1, -5, 0, 15);
		buttonTitle.Position = UDim2.fromOffset(5, 6);
		buttonTitle.BackgroundTransparency = 1;
		buttonTitle.Text = "Target:";
		buttonTitle.TextXAlignment = Enum.TextXAlignment.Left;
		buttonTitle.TextColor3 = color.Darken(theme.Text, 0.16);
		buttonTitle.TextSize = 15;
		buttonTitle.TextTruncate = Enum.TextTruncate.AtEnd;
		buttonTitle.FontFace = theme.Font;
		buttonTitle.Parent = button;

		local items = buttonTitle:Clone();
		items.Name = "Items";
		items.Position = UDim2.fromOffset(5, 21);
		items.Text = "Ignore none";
		items.TextColor3 = color.Darken(theme.Text, 0.16);
		items.TextSize = 11;
		items.Parent = button;

		local tool = Instance.new("Frame");
		tool.Size = UDim2.fromOffset(65, 12);
		tool.Position = UDim2.fromOffset(52, 8);
		tool.BackgroundTransparency = 1;
		tool.Parent = button;

		local toolList = Instance.new("UIListLayout");
		toolList.FillDirection = Enum.FillDirection.Horizontal;
		toolList.Padding = UDim.new(0, 6);
		toolList.Parent = tool;

		local window = Instance.new("TextButton");
		window.Name = "TargetsTextWindow";
		window.Size = UDim2.fromOffset(220, 145);
		window.BackgroundColor3 = theme.Main;
		window.BorderSizePixel = 0;
		window.AutoButtonColor = false;
		window.Visible = false;
		window.Text = "";
		window.Parent = clickFrame;

		optionapi.Window = window;

		local icon = Instance.new("ImageLabel");
		icon.Name = "Icon";
		icon.Size = UDim2.fromOffset(18, 12);
		icon.Position = UDim2.fromOffset(10, 15);
		icon.BackgroundTransparency = 1;
		icon.Image = getcustomasset("Baya/Assets/TargetsTab.png");
		icon.Parent = window;

		local title = Instance.new("TextLabel");
		title.Name = "Title";
		title.Size = UDim2.new(1, -36, 0, 20);
		title.Position = UDim2.fromOffset(math.abs(title.Size.X.Offset), 11);
		title.BackgroundTransparency = 1;
		title.Text = "Target Settings";
		title.TextXAlignment = Enum.TextXAlignment.Left;
		title.TextColor3 = theme.Text;
		title.TextSize = 13;
		title.FontFace = theme.Font;
		title.Parent = window;

		local close = CreateCloseButton(window);

		optionSettings.Function = optionSettings.Function or function() end;
		
		function optionapi:Save(tab)
			tab.Targets = {
				Players = self.Players.Enabled,
				NPCs = self.NPCs.Enabled,
				Invisible = self.Invisible.Enabled,
				Walls = self.Walls.Enabled
			}
		end
		
		function optionapi:Load(tab)
			if self.Players.Enabled ~= tab.Players then
				self.Players:Toggle()
			end
			if self.NPCs.Enabled ~= tab.NPCs then
				self.NPCs:Toggle()
			end
			if self.Invisible.Enabled ~= tab.Invisible then
				self.Invisible:Toggle()
			end
			if self.Walls.Enabled ~= tab.Walls then
				self.Walls:Toggle()
			end
		end
		
		optionapi.Players = components.TargetsButton({
			Position = UDim2.fromOffset(11, 45),
			Icon = getcustomasset("Baya/Assets/TargetPlayers1.png"),
			IconSize = UDim2.fromOffset(15, 16),
			IconParent = tool,
			ToolIcon = getcustomasset("Baya/Assets/TargetPlayers2.png"),
			ToolSize = UDim2.fromOffset(11, 12),
			Tooltip = 'Players',
			Function = optionSettings.Function
		}, window, tool)

		optionapi.NPCs = components.TargetsButton({
			Position = UDim2.fromOffset(112, 45),
			Icon = getcustomasset("Baya/Assets/TargetNPC1.png"),
			IconSize = UDim2.fromOffset(12, 16),
			IconParent = tool,
			ToolIcon = getcustomasset("Baya/Assets/TargetNPC2.png"),
			ToolSize = UDim2.fromOffset(9, 12),
			Tooltip = 'NPCs',
			Function = optionSettings.Function
		}, window, tool)

		optionapi.Invisible = components.Toggle({
			Name = 'Ignore Invisible',
			Function = function()
				local text = 'none'
				if optionapi.Invisible.Enabled then
					text = 'invisible'
				end
				if optionapi.Walls.Enabled then
					text = text == 'none' and 'behind walls' or text..', behind walls'
				end
				items.Text = 'Ignore '..text
				optionSettings.Function()
			end
		}, window, {Options = {}})

		optionapi.Invisible.Object.Position = UDim2.fromOffset(0, 81);

		optionapi.Walls = components.Toggle({
			Name = 'Ignore behind walls',
			Function = function()
				local text = 'none'
				if optionapi.Invisible.Enabled then
					text = 'invisible'
				end
				if optionapi.Walls.Enabled then
					text = text == 'none' and 'behind walls' or text..', behind walls'
				end
				items.Text = 'Ignore '..text
				optionSettings.Function()
			end
		}, window, {Options = {}})

		optionapi.Walls.Object.Position = UDim2.fromOffset(0, 111)

		if optionSettings.Players then
			optionapi.Players:Toggle()
		end
		if optionSettings.NPCs then
			optionapi.NPCs:Toggle()
		end
		if optionSettings.Invisible then
			optionapi.Invisible:Toggle()
		end
		if optionSettings.Walls then
			optionapi.Walls:Toggle()
		end
		
		close.MouseButton1Click:Connect(function()
			window.Visible = false;
		end)

		button.MouseButton1Click:Connect(function()
			window.Visible = not window.Visible;
			tween:Cancel(bkg);
			bkg.BackgroundColor3 = window.Visible and Color3.fromHSV(libraryapi.Interface.Hue, libraryapi.Interface.Sat, libraryapi.Interface.Value) or color.Lighten(theme.Main, 0.37);
		end)

		textList.MouseEnter:Connect(function()
			if not optionapi.Window.Visible then
				tween:Tween(bkg, theme.Tween, {
					BackgroundColor3 = color.Lighten(theme.Main, 0.37)
				})
			end
		end)
		textList.MouseLeave:Connect(function()
			if not optionapi.Window.Visible then
				tween:Tween(bkg, theme.Tween, {
					BackgroundColor3 = color.Lighten(theme.Main, 0.034)
				})
			end
		end)
		textList:GetPropertyChangedSignal('AbsolutePosition'):Connect(function()
			if libraryapi.ThreadFix then
				setthreadidentity(8)
			end

			local actualPosition = (textList.AbsolutePosition + Vector2.new(0, 60)) / scale.Scale
			window.Position = UDim2.fromOffset(actualPosition.X + 220, actualPosition.Y)
		end)
		
		optionapi.Object = textList
		api.Options.Targets = optionapi
		
		return optionapi
	end,
	TargetsButton = function(optionSettings, children, api)
		local optionapi = {Enabled = false};
		
		local targetbutton = Instance.new("TextButton");
		targetbutton.Size = UDim2.fromOffset(98, 31);
		targetbutton.Position = optionSettings.Position;
		targetbutton.BackgroundColor3 = color.Lighten(theme.Main, 0.05);
		targetbutton.AutoButtonColor = false;
		targetbutton.Visible = optionSettings.Visible == nil or optionSettings.Visible;
		targetbutton.Text = "";
		targetbutton.Parent = children;

		AddTooltip(targetbutton, optionSettings.Tooltip);

		local bkg = Instance.new('Frame')
		bkg.Size = UDim2.new(1, -2, 1, -2)
		bkg.Position = UDim2.fromOffset(1, 1)
		bkg.BackgroundColor3 = theme.Main
		bkg.Parent = targetbutton

		local icon = Instance.new("ImageLabel");
		icon.Size = optionSettings.IconSize;
		icon.Position = UDim2.fromScale(0.5, 0.5);
		icon.AnchorPoint = Vector2.new(0.5, 0.5);
		icon.BackgroundTransparency = 1;
		icon.Image = optionSettings.Icon;
		icon.ImageColor3 = color.Lighten(theme.Main, 0.37);
		icon.Parent = bkg;
		
		optionSettings.Function = optionSettings.Function or function() end;

		local tooltipicon;
		
		function optionapi:Toggle()
			self.Enabled = not self.Enabled

			tween:Tween(bkg, theme.Tween, {
				BackgroundColor3 = self.Enabled and Color3.fromHSV(libraryapi.Interface.Hue, libraryapi.Interface.Sat, libraryapi.Interface.Value) or theme.Main
			})
			tween:Tween(icon, theme.Tween, {
				ImageColor3 = self.Enabled and Color3.new(1, 1, 1) or color.Lighten(theme.Main, 0.37)
			})

			if tooltipicon then
				tooltipicon:Destroy()
			end

			if self.Enabled then
				tooltipicon = Instance.new("ImageLabel");
				tooltipicon.Size = optionSettings.ToolSize;
				tooltipicon.BackgroundTransparency = 1;
				tooltipicon.Image = optionSettings.ToolIcon;
				tooltipicon.ImageColor3 = theme.Text;
				tooltipicon.Parent = optionSettings.IconParent;
			end

			optionSettings.Function(self.Enabled)
		end
		
		targetbutton.MouseEnter:Connect(function()
			if not optionapi.Enabled then
				tween:Tween(bkg, theme.Tween, {
					BackgroundColor3 = Color3.fromHSV(libraryapi.Interface.Hue, libraryapi.Interface.Sat, libraryapi.Interface.Value - 0.25)
				});
				tween:Tween(icon, theme.Tween, {
					ImageColor3 = Color3.new(1, 1, 1)
				});
			end
		end)
		targetbutton.MouseLeave:Connect(function()
			if not optionapi.Enabled then
				tween:Tween(bkg, theme.Tween, {
					BackgroundColor3 = theme.Main
				});
				tween:Tween(icon, theme.Tween, {
					ImageColor3 = color.Lighten(theme.Main, 0.37)
				});
			end
		end);
		targetbutton.MouseButton1Click:Connect(function()
			optionapi:Toggle();
		end);
		
		optionapi.Object = targetbutton;
		
		return optionapi
	end,
}

libraryapi.Components = setmetatable(components, {
	__newindex = function(self, ind, func)
		for _, v in libraryapi.Modules do
			rawset(v, "Create" .. ind, function(_, settings)
				return func(settings, v.Children, v)
			end)
		end

		rawset(self, ind, func)
	end
})

--|| ||--
AddMaid(libraryapi)

-- folder creation
for _, folder in {"Baya", "Baya/Commits", "Baya/Assets", "Baya/Games", "Baya/Libraries"} do
	if not isfolder(folder) then
		makefolder(folder)
	end
end

-- update baya libraryapi
local _, subbed = pcall(function()
	return game:HttpGet("https://github.com/fisiaque/BayaUILibrary")
end)

local commit = subbed:find("currentOid")
commit = commit and subbed:sub(commit + 13, commit + 52) or nil
commit = commit and #commit == 40 and commit or "main"

if commit == "main" or (isfile("Baya/Commits/Library.txt") and readfile("Baya/Commits/Library.txt") or "") ~= commit then
	WipeFolder("Baya/Assets")
	WipeFolder("Baya/Commits")
	WipeFolder("Baya/Games")
	WipeFolder("Baya/Libraries")
	WipeFolder("Baya")
end

writefile("Baya/Commits/Library.txt", commit)

-- gui creation
local gui = Instance.new("ScreenGui");
gui.Name = RandomString();
gui.DisplayOrder = 9999999;
gui.ZIndexBehavior = Enum.ZIndexBehavior.Global;
gui.IgnoreGuiInset = true;
gui.OnTopOfCoreBlur = true

-- if threadidentity exist parent to core gui otherwise player gui
if libraryapi.ThreadFix then
	gui.Parent = cloneref(game:GetService("CoreGui"));
else
	gui.Parent = cloneref(game:GetService("Players")).LocalPlayer.PlayerGui;
	gui.ResetOnSpawn = false;
end

-- set a main variable for gui
libraryapi.gui = gui

-- create main frame
local scaledFrame = Instance.new("Frame");
scaledFrame.Name = "ScaledFrame";
scaledFrame.Size = UDim2.fromScale(1, 1);
scaledFrame.BackgroundTransparency = 1;
scaledFrame.Parent = gui

-- create UI scale
scale = Instance.new("UIScale");
scale.Scale = math.max(gui.AbsoluteSize.X / 1920, 0.6);
scale.Parent = scaledFrame;

-- resize scaledFrame
scaledFrame.Size = UDim2.fromScale(1 / scale.Scale, 1 / scale.Scale)

-- create Notifications folder
notifications = Instance.new("Folder")
notifications.Name = "Notifications"
notifications.Parent = scaledFrame

-- create click gui
clickFrame = Instance.new("Frame");
clickFrame.Name = "ClickFrame";
clickFrame.Size = UDim2.fromScale(1, 1); 
clickFrame.BackgroundTransparency = 1;
clickFrame.Visible = false;
clickFrame.Parent = scaledFrame

-- create tooltip
tooltip = Instance.new("TextLabel");
tooltip.Name = "Tooltip";
tooltip.ZIndex = 5;
tooltip.BackgroundColor3 = color.Darken(theme.Main, 0.2);
tooltip.Position = UDim2.fromScale(-1, -1);
tooltip.Visible = false;
tooltip.Text = "";
tooltip.TextColor3 = color.Darken(theme.Text, 0.15);
tooltip.TextSize = 12;
tooltip.FontFace = theme.Font;
tooltip.Parent = scaledFrame

-- libraryapi
function libraryapi:CreateGUI()
	local categoryapi = {
		Type = "MainWindow";
		Buttons = {};
		Options = {};
	}

	local window = Instance.new("TextButton");
	window.Name = "GUICategory";
	window.Size = UDim2.fromOffset(220, 41);
	window.Position = UDim2.fromOffset(6, 60);
	window.BackgroundColor3 = color.Darken(theme.Main, 0.02);
	window.AutoButtonColor = false
	window.Text = "";
	window.Parent = clickFrame;

	Dragify(window)

	local logo = Instance.new("ImageLabel");
	logo.Name = "BayaLogo";
	logo.Size = UDim2.fromOffset(62, 18);
	logo.Position = UDim2.fromOffset(11, 10);
	logo.BackgroundTransparency = 1;
	logo.Image = getcustomasset("Baya/Assets/GUILogo.png");
	logo.ImageColor3 = select(3, theme.Main:ToHSV()) > 0.5 and theme.Text or Color3.new(1, 1, 1);
	logo.Parent = window

	local children = Instance.new("Frame");
	children.Name = "Children";
	children.Size = UDim2.new(1, 0, 1, -33);
	children.Position = UDim2.fromOffset(0, 37);
	children.BackgroundTransparency = 1;
	children.Parent = window

	local windowList = Instance.new("UIListLayout");
	windowList.SortOrder = Enum.SortOrder.LayoutOrder;
	windowList.HorizontalAlignment = Enum.HorizontalAlignment.Center;
	windowList.Parent = children

	categoryapi.Object = window

	function categoryapi:CreateButton(categorySettings)
		local optionapi = {
			Enabled = false;
			Index = GetTableSize(categoryapi.Buttons);
			Settings = categorySettings;
		}

		-- create main window button
		local button = Instance.new("TextButton");
		button.Name = categorySettings.Name;
		button.Size = UDim2.fromOffset(220, 40);
		button.BackgroundColor3 = theme.Main;
		button.BorderSizePixel = 0;
		button.AutoButtonColor = false;
		button.Text = (categorySettings.Icon and "                                 " or "             ") .. categorySettings.Name
		button.TextXAlignment = Enum.TextXAlignment.Left;
		button.TextColor3 = color.Darken(theme.Text, 0.16);
		button.TextSize = 14;
		button.FontFace = theme.Font;
		button.Parent = children;

		-- create icon if being received
		local icon

		if categorySettings.Icon then
			icon = Instance.new("ImageLabel");
			icon.Name = "Icon";
			icon.Size = categorySettings.Size;
			icon.Position = UDim2.fromOffset(13, 13);
			icon.BackgroundTransparency = 1;
			icon.Image = categorySettings.Icon;
			icon.ImageColor3 = color.Darken(theme.Text, 0.15);
			icon.Parent = button;
		end

		-- create arrow
		local arrow = Instance.new("ImageLabel");
		arrow.Name = "Arrow";
		arrow.Size = UDim2.fromOffset(4, 8);
		arrow.Position = UDim2.new(1, -20, 0, 16);
		arrow.BackgroundTransparency = 1;
		arrow.Image = getcustomasset("Baya/Assets/ExpandRight.png");
		arrow.ImageColor3 = color.Lighten(theme.Main, 0.35);
		arrow.Parent = button;

		optionapi.Name = categorySettings.Name;
		optionapi.Icon = icon;
		optionapi.Object = button;

		-- button toggle
		function optionapi:Toggle()
			for _, _button in libraryapi.Categories.Main.Buttons do
				if _button ~= libraryapi.Categories.Main.Buttons[optionapi.Name] and _button.Enabled then
					RearrangeButton(_button, false) -- close

					pp = _button.Settings.Window.Position
				end
			end

			RearrangeButton(self, not self.Enabled)

			if self.Enabled == false then -- if button closed then save previous position
				pp = optionapi.Settings.Window.Position
			end

			self.Settings.Window.Position = pp
		end

		button.MouseEnter:Connect(function()
			if not optionapi.Enabled then
				button.TextColor3 = theme.Text
				button.BackgroundColor3 = color.Lighten(theme.Main, 0.02)
			end
		end)
		button.MouseLeave:Connect(function()
			if not optionapi.Enabled then
				button.TextColor3 = color.Darken(theme.Text, 0.16)
				button.BackgroundColor3 = theme.Main
			end
		end)
		button.MouseButton1Click:Connect(function()
			optionapi:Toggle()
		end)

		categoryapi.Buttons[categorySettings.Name] = optionapi

		return optionapi
	end

	function categoryapi:CreateDivider(textSettings)
		components.Divider(textSettings, children)
	end

	function categoryapi:CreateOverlayBar()
		local optionapi = {Toggles = {}};

		local bar = Instance.new("Frame");
		bar.Name = "Overlays";
		bar.Size = UDim2.fromOffset(220, 36);
		bar.BackgroundColor3 = theme.Main;
		bar.BorderSizePixel = 0;
		bar.Parent = children;

		components.Divider(nil, bar)

		local button = Instance.new("ImageButton");
		button.Size = UDim2.fromOffset(24, 24);
		button.Position = UDim2.new(1, -29, 0, 7);
		button.BackgroundTransparency = 1;
		button.AutoButtonColor = false;
		button.Image = getcustomasset("Baya/Assets/OverlaysIcon.png");
		button.ImageColor3 = color.Lighten(theme.Main, 0.37);
		button.Parent = bar;

		AddTooltip(button, 'Open Overlays Menu');

		local shadow = Instance.new("TextButton");
		shadow.Name = "Shadow";
		shadow.Size = UDim2.new(1, 0, 1, -5);
		shadow.BackgroundColor3 = Color3.new();
		shadow.BackgroundTransparency = 1;
		shadow.AutoButtonColor = false;
		shadow.ClipsDescendants = true;
		shadow.Visible = false;
		shadow.Text = "";
		shadow.Parent = window;

		local window = Instance.new("Frame");
		window.Size = UDim2.fromOffset(220, 42);
		window.Position = UDim2.fromScale(0, 1);
		window.BackgroundColor3 = theme.Main;
		window.Parent = shadow;

		local icon = Instance.new("ImageLabel");
		icon.Name = "Icon";
		icon.Size = UDim2.fromOffset(14, 12);
		icon.Position = UDim2.fromOffset(10, 13);
		icon.BackgroundTransparency = 1;
		icon.Image = getcustomasset("Baya/Assets/OverlaysTab.png")
		icon.ImageColor3 = theme.Text;
		icon.Parent = window;

		local title = Instance.new("TextLabel");
		title.Name = "Title";
		title.Size = UDim2.new(1, -36, 0, 38);
		title.Position = UDim2.fromOffset(36, 0);
		title.BackgroundTransparency = 1;
		title.Text = "Overlays";
		title.TextXAlignment = Enum.TextXAlignment.Left;
		title.TextColor3 = theme.Text;
		title.TextSize = 15;
		title.FontFace = theme.Font;
		title.Parent = window;

		local close = CreateCloseButton(window, 7);

		local divider = Instance.new("Frame");
		divider.Name = "Divider";
		divider.Size = UDim2.new(1, 0, 0, 1);
		divider.Position = UDim2.fromOffset(0, 37);
		divider.BackgroundColor3 = color.Lighten(theme.Main, 0.02);
		divider.BorderSizePixel = 0;
		divider.Parent = window;

		local childrenToggle = Instance.new("Frame");
		childrenToggle.Position = UDim2.fromOffset(0, 38);
		childrenToggle.BackgroundTransparency = 1;
		childrenToggle.Parent = window;

		local windowList = Instance.new("UIListLayout");
		windowList.SortOrder = Enum.SortOrder.LayoutOrder;
		windowList.HorizontalAlignment = Enum.HorizontalAlignment.Center;
		windowList.Parent = childrenToggle;

		function optionapi:CreateToggle(toggleSettings)
			local toggleapi = {
				Enabled = false;
				Index = GetTableSize(optionapi.Toggles);
			}

			local hovered = false;

			local toggle = Instance.new("TextButton");
			toggle.Name = toggleSettings.Name .. "Toggle";
			toggle.Size = UDim2.new(1, 0, 0, 40);
			toggle.BackgroundTransparency = 1;
			toggle.AutoButtonColor = false;
			toggle.Text = string.rep(" ", 33 * scale.Scale) .. toggleSettings.Name;
			toggle.TextXAlignment = Enum.TextXAlignment.Left;
			toggle.TextColor3 = color.Darken(theme.Text, 0.16);
			toggle.TextSize = 14;
			toggle.FontFace = theme.Font;
			toggle.Parent = childrenToggle;

			local icon = Instance.new("ImageLabel");
			icon.Name = "Icon";
			icon.Size = toggleSettings.Size;
			icon.Position = toggleSettings.Position;
			icon.BackgroundTransparency = 1;
			icon.Image = toggleSettings.Icon;
			icon.ImageColor3 = theme.Text;
			icon.Parent = toggle;

			local knob = Instance.new("Frame");
			knob.Name = "Knob";
			knob.Size = UDim2.fromOffset(22, 12);
			knob.Position = UDim2.new(1, -30, 0, 14);
			knob.BackgroundColor3 = color.Lighten(theme.Main, 0.14);
			knob.Parent = toggle;

			local knobMain = knob:Clone();
			knobMain.Size = UDim2.fromOffset(8, 8);
			knobMain.Position = UDim2.fromOffset(2, 2);
			knobMain.BackgroundColor3 = theme.Main;
			knobMain.Parent = knob;

			toggleapi.Object = toggle;

			function toggleapi:Toggle()
				self.Enabled = not self.Enabled;

				tween:Tween(knob, theme.Tween, {
					BackgroundColor3 = self.Enabled and Color3.fromHSV(
						theme.Interface.Hue,
						theme.Interface.Sat,
						theme.Interface.Value
					) or (hovered and color.Lighten(theme.Main, 0.37) or color.Lighten(theme.Main, 0.14))
				})

				tween:Tween(knobMain, theme.Tween, {
					Position = UDim2.fromOffset(self.Enabled and 12 or 2, 2);
				})

				toggleSettings.Function(self.Enabled);
			end

			scale:GetPropertyChangedSignal("Scale"):Connect(function()
				toggle.Text = string.rep(" ", 33 * scale.Scale) .. toggleSettings.Name;
			end)

			toggle.MouseEnter:Connect(function()
				hovered = true

				if not toggleapi.Enabled then
					tween:Tween(knob, theme.Tween, {
						BackgroundColor3 = color.Lighten(theme.Main, 0.37)
					});
				end
			end)
			toggle.MouseLeave:Connect(function()
				hovered = false

				if not toggleapi.Enabled then
					tween:Tween(knob, theme.Tween, {
						BackgroundColor3 = color.Lighten(theme.Main, 0.14)
					})
				end
			end)
			toggle.MouseButton1Click:Connect(function()
				toggleapi:Toggle();
			end)

			table.insert(optionapi.Toggles, toggleapi);

			return toggleapi
		end

		button.MouseEnter:Connect(function()
			button.ImageColor3 = theme.Text;

			tween:Tween(button, theme.Tween, {
				BackgroundTransparency = 0.9
			});
		end)
		button.MouseLeave:Connect(function()
			button.ImageColor3 = color.Lighten(theme.Main, 0.37);

			tween:Tween(button, theme.Tween, {
				BackgroundTransparency = 1
			});
		end)
		button.MouseButton1Click:Connect(function()
			shadow.Visible = true;

			tween:Tween(shadow, theme.Tween, {
				BackgroundTransparency = 0.5
			});
			tween:Tween(window, theme.Tween, {
				Position = UDim2.new(0, 0, 1, -(window.Size.Y.Offset))
			});
		end)

		close.MouseButton1Click:Connect(function()
			tween:Tween(shadow, theme.Tween, {
				BackgroundTransparency = 1
			});
			tween:Tween(window, theme.Tween, {
				Position = UDim2.fromScale(0, 1)
			});

			task.wait(0.2)

			shadow.Visible = false
		end);

		shadow.MouseButton1Click:Connect(function()
			tween:Tween(shadow, theme.Tween, {
				BackgroundTransparency = 1
			});
			tween:Tween(window, theme.Tween, {
				Position = UDim2.fromScale(0, 1)
			});

			task.wait(0.2)

			shadow.Visible = false
		end)

		windowList:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
			if libraryapi.ThreadFix then
				setthreadidentity(8);
			end

			window.Size = UDim2.fromOffset(220, math.min(37 + windowList.AbsoluteContentSize.Y / scale.Scale, 605));

			childrenToggle.Size = UDim2.fromOffset(220, window.Size.Y.Offset - 5);
		end)

		libraryapi.Overlays = optionapi

		return optionapi
	end

	function categoryapi:CreateSettPane(categorySettings)
		local optionapi = {};

		local settButton = Instance.new("TextButton");
		settButton.Name = "Sett";
		settButton.Size = UDim2.fromOffset(40, 40);
		settButton.Position = UDim2.new(1, -40, 0, 0);
		settButton.BackgroundTransparency = 1;
		settButton.Text = "";
		settButton.Parent = window;

		local settTooltip = AddTooltip(settButton, "Open Sett");

		local settIcon = Instance.new("ImageLabel");
		settIcon.Size = UDim2.fromOffset(14, 14);
		settIcon.Position = UDim2.fromOffset(15, 12);
		settIcon.BackgroundTransparency = 1;
		settIcon.Image = getcustomasset("Baya/Assets/Information.png");
		settIcon.ImageColor3 = color.Lighten(theme.Main, 0.37);
		settIcon.Parent = settButton;

		local settPane = Instance.new("TextButton");
		settPane.Name = "MainsettPane";
		settPane.Size = UDim2.fromScale(1, 1);
		settPane.BackgroundColor3 = color.Darken(theme.Main, 0.02);
		settPane.AutoButtonColor = false;
		settPane.Visible = false;
		settPane.Text = "";
		settPane.Parent = window;

		local settTitle = Instance.new("TextLabel");
		settTitle.Name = "Title";
		settTitle.Size = UDim2.new(1, -36, 0, 20);
		settTitle.Position = UDim2.fromOffset(math.abs(settTitle.Size.X.Offset), 11);
		settTitle.BackgroundTransparency = 1;
		settTitle.Text = "Information";
		settTitle.TextXAlignment = Enum.TextXAlignment.Left;
		settTitle.TextColor3 = theme.Text;
		settTitle.TextSize = 13;
		settTitle.FontFace = theme.Font;
		settTitle.Parent = settPane;

		local settBack = Instance.new("ImageButton");
		settBack.Name = "Back";
		settBack.Size = UDim2.fromOffset(16, 16);
		settBack.Position = UDim2.fromOffset(11, 13);
		settBack.BackgroundTransparency = 1;
		settBack.Image = getcustomasset("Baya/Assets/Back.png");
		settBack.ImageColor3 = color.Lighten(theme.Main, 0.37);
		settBack.Parent = settPane;

		local settChildren = Instance.new("ScrollingFrame");
		settChildren.Name = "Children";
		settChildren.Size = UDim2.new(1, 0, 1, -57);
		settChildren.Position = UDim2.fromOffset(0, 41);
		settChildren.BackgroundColor3 = color.Darken(theme.Main, 0.02)
		settChildren.BorderSizePixel = 0;
		settChildren.ScrollBarThickness = 2;
		settChildren.ScrollBarImageTransparency = 0.75;
		settChildren.AutomaticCanvasSize = Enum.AutomaticSize.Y;
		settChildren.CanvasSize = UDim2.new(0, 0, 1, 0);
		settChildren.Parent = settPane;

		local settWindowList = Instance.new("UIListLayout");
		settWindowList.SortOrder = Enum.SortOrder.LayoutOrder;
		settWindowList.HorizontalAlignment = Enum.HorizontalAlignment.Center;
		settWindowList.Parent = settChildren;

		for i, v in components do
			optionapi["Create" .. i] = function(_, settings)
				return v(settings, settChildren, categoryapi)
			end
		end

		settBack.MouseEnter:Connect(function()
			settBack.ImageColor3 = theme.Text;
		end);
		settBack.MouseLeave:Connect(function()
			settBack.ImageColor3 = color.Lighten(theme.Main, 0.37);
		end);
		settBack.MouseButton1Click:Connect(function()
			settPane.Visible = false;
			settTooltip.Visible = true;
			settTooltip.Forced = false
		end);
		settButton.MouseEnter:Connect(function()
			settIcon.ImageColor3 = theme.Text;
		end);
		settButton.MouseLeave:Connect(function()
			settIcon.ImageColor3 = color.Lighten(theme.Main, 0.37);
		end);
		settButton.MouseButton1Click:Connect(function()
			settTooltip.Visible = false;
			settTooltip.Forced = true
			settPane.Visible = true;
		end);

		settWindowList:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
			if libraryapi.ThreadFix then
				setthreadidentity(8)
			end

			settPane.Size = UDim2.fromOffset(220, 45 + settWindowList.AbsoluteContentSize.Y / scale.Scale)

			for _, v in categoryapi.Buttons do
				if v.Icon then
					v.Object.Text = string.rep(' ', 33 * scale.Scale)..v.Name
				end
			end
		end)

		return optionapi
	end

	windowList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		if self.ThreadFix then
			setthreadidentity(8)
		end
		window.Size = UDim2.fromOffset(220, 42 + windowList.AbsoluteContentSize.Y / scale.Scale)
		for _, v in categoryapi.Buttons do
			if v.Icon then
				v.Object.Text = string.rep(" ", 36 * scale.Scale) .. v.Name
			end
		end
	end)

	self.Categories.Main = categoryapi

	return categoryapi
end

function libraryapi:CreateCategory(categorySettings)
	local categoryapi = {
		Type = "Category";
		Expanded = false
	}

	-- get icon asset
	categorySettings.Icon = getcustomasset(categorySettings.Icon)

	-- create window category
	local window = Instance.new("TextButton");
	window.Name = categorySettings.Name .. "Category";
	window.Size = UDim2.fromOffset(220, 41);
	window.Position = pp;
	window.BackgroundColor3 = theme.Main;
	window.AutoButtonColor = false;
	window.Visible = false;
	window.Text = "";
	window.Parent = clickFrame;

	Dragify(window)

	-- create icon 
	local icon = Instance.new("ImageLabel");
	icon.Name = "Icon";
	icon.Size = categorySettings.Size;
	icon.Position = UDim2.fromOffset(12, (icon.Size.X.Offset > 20 and 14 or 13));
	icon.BackgroundTransparency = 1;
	icon.Image = categorySettings.Icon;
	icon.ImageColor3 = theme.Text;
	icon.Parent = window

	-- create title
	local title = Instance.new("TextLabel");
	title.Name = "Title";
	title.Size = UDim2.new(1, -(categorySettings.Size.X.Offset > 18 and 40 or 33), 0, 41);
	title.Position = UDim2.fromOffset(math.abs(title.Size.X.Offset), 0);
	title.BackgroundTransparency = 1;
	title.Text = categorySettings.Name;
	title.TextXAlignment = Enum.TextXAlignment.Left;
	title.TextColor3 = theme.Text;
	title.TextSize = 14;
	title.FontFace = theme.Font;
	title.Parent = window;

	-- arrow button
	local arrowButton = Instance.new("TextButton");
	arrowButton.Name = "Arrow";
	arrowButton.Size = UDim2.fromOffset(40, 40);
	arrowButton.Position = UDim2.new(1, -40, 0, 0);
	arrowButton.BackgroundTransparency = 1;
	arrowButton.Text = "";
	arrowButton.Parent = window;

	-- arrow image
	local arrow = Instance.new("ImageLabel");
	arrow.Name = "Arrow";
	arrow.Size = UDim2.fromOffset(9, 4);
	arrow.Position = UDim2.fromOffset(20, 18);
	arrow.BackgroundTransparency = 1;
	arrow.Image = getcustomasset("Baya/Assets/ExpandUp.png");
	arrow.ImageColor3 = Color3.fromRGB(150, 150, 150);
	arrow.Rotation = 180;
	arrow.Parent = arrowButton;

	-- scrolling frame
	local children = Instance.new("ScrollingFrame");
	children.Name = "Children";
	children.Size = UDim2.new(1, 0, 1, -41);
	children.Position = UDim2.fromOffset(0, 37);
	children.BackgroundColor3 = color.Darken(theme.Main, 0.02)
	children.BackgroundTransparency = 1;
	children.BorderSizePixel = 0;
	children.Visible = false;
	children.ScrollBarThickness = 2;
	children.ScrollBarImageTransparency = 0.75;
	children.CanvasSize = UDim2.new();
	children.Parent = window;

	-- divider
	local divider = Instance.new("Frame");
	divider.Name = "Divider";
	divider.Size = UDim2.new(1, 0, 0, 1);
	divider.Position = UDim2.fromOffset(0, 37);
	divider.BackgroundColor3 = Color3.new(1, 1, 1);
	divider.BackgroundTransparency = 0.925;
	divider.BorderSizePixel = 0;
	divider.Visible = false;
	divider.Parent = window;

	local windowList = Instance.new("UIListLayout");
	windowList.SortOrder = Enum.SortOrder.LayoutOrder;
	windowList.HorizontalAlignment = Enum.HorizontalAlignment.Center;
	windowList.Parent = children;

	function categoryapi:CreateModule(moduleSettings)
		libraryapi:Remove(moduleSettings.Name)

		local moduleapi = {
			Enabled = false;
			Options = {};
			Bind = {};
			Index = GetTableSize(libraryapi.Modules);
			ExtraText = moduleSettings.ExtraText;
			Name = moduleSettings.Name;
			Category = categorySettings.Name;
		}

		local hovered = false;
		local held = false;
		local heldTime

		local moduleButton = Instance.new("TextButton");
		moduleButton.Name = moduleSettings.Name;
		moduleButton.Size = UDim2.fromOffset(220, 40);
		moduleButton.BackgroundColor3 = theme.Main;
		moduleButton.BorderSizePixel = 0;
		moduleButton.AutoButtonColor = false;
		moduleButton.Text = "            " .. moduleSettings.Name;
		moduleButton.TextXAlignment = Enum.TextXAlignment.Left;
		moduleButton.TextColor3 = color.Darken(theme.Text, 0.16);
		moduleButton.TextSize = 14;
		moduleButton.FontFace = theme.Font;
		moduleButton.Parent = children;

		local tooltipText = (moduleSettings.Tooltip or "") .. "(Right Click)"

		if inputService.TouchEnabled then
			tooltipText = (moduleSettings.Tooltip or "") .. "(Hold)"
		end

		AddTooltip(moduleButton, tooltipText)

		-- arrow image
		local arrow = Instance.new("ImageLabel");
		arrow.Name = "Arrow";
		arrow.Size = UDim2.fromOffset(9, 4);
		arrow.Position = UDim2.fromOffset(200, 18);
		arrow.BackgroundTransparency = 1;
		arrow.Image = getcustomasset("Baya/Assets/ExpandUp.png");
		arrow.ImageColor3 = Color3.fromRGB(150, 150, 150);
		arrow.Rotation = 180;
		arrow.Parent = moduleButton;

		local gradient = Instance.new("UIGradient");
		gradient.Rotation = 90;
		gradient.Enabled = false;
		gradient.Parent = moduleButton;

		local moduleChildren = Instance.new("Frame");
		moduleChildren.Name = moduleSettings.Name .. "Children";
		moduleChildren.Size = UDim2.new(1, 0, 0, 0);
		moduleChildren.BackgroundColor3 = color.Darken(theme.Main, 0.02);
		moduleChildren.BorderSizePixel = 0;
		moduleChildren.Visible = false;
		moduleChildren.Parent = children;

		moduleapi.Children = moduleChildren

		local windowList = Instance.new("UIListLayout");
		windowList.SortOrder = Enum.SortOrder.LayoutOrder;
		windowList.HorizontalAlignment = Enum.HorizontalAlignment.Center;
		windowList.Parent = moduleChildren;

		local divider = Instance.new("Frame");
		divider.Name = "Divider";
		divider.Size = UDim2.new(1, 0, 0, 1);
		divider.Position = UDim2.new(0, 0, 1, -1);
		divider.BackgroundColor3 = Color3.new(0.19, 0.19, 0.19);
		divider.BackgroundTransparency = 0.52;
		divider.BorderSizePixel = 0;
		divider.Visible = false;
		divider.Parent = moduleButton;

		moduleSettings.Function = moduleSettings.Function or function() end;

		AddMaid(moduleapi);

		function moduleapi:Toggle(multiple)
			if libraryapi.ThreadFix then
				setthreadidentity(8);
			end

			self.Enabled = not self.Enabled;
			divider.Visible = self.Enabled;
			gradient.Enabled = self.Enabled;

			moduleButton.TextColor3 = self.Enabled and Color3.fromHSV(theme.Interface.Hue, theme.Interface.Sat, theme.Interface.Value) or theme.Text;
			moduleButton.BackgroundColor3 = (hovered or moduleChildren.Visible) and color.Lighten(theme.Main, 0.02) or theme.Main

			if not self.Enabled then
				for _, v in self.Connections do
					v:Disconnect()
				end
				table.clear(self.Connections)
			end

			task.spawn(moduleSettings.Function, self.Enabled)
		end

		for i, v in components do
			moduleapi['Create'..i] = function(_, optionSettings)
				return v(optionSettings, moduleChildren, moduleapi)
			end
		end

		moduleButton.MouseEnter:Connect(function()
			hovered = true;

			if not moduleapi.Enabled and not moduleChildren.Visible then
				moduleButton.TextColor3 = theme.Text;
				moduleButton.BackgroundColor3 = color.Lighten(theme.Main, 0.02);
			end
		end);
		moduleButton.MouseLeave:Connect(function()
			hovered = false
			if not moduleapi.Enabled and not moduleChildren.Visible then
				moduleButton.TextColor3 = color.Darken(theme.Text, 0.16);
				moduleButton.BackgroundColor3 = theme.Main;
			end
		end);
		moduleButton.MouseButton1Click:Connect(function()
			if not heldTime then
				moduleapi:Toggle();
			end
		end);
		moduleButton.MouseButton2Click:Connect(function()
			moduleChildren.Visible = not moduleChildren.Visible
			arrow.Rotation = arrow.Rotation == 0 and 180 or 0
		end);

		if inputService.TouchEnabled then
			moduleButton.MouseButton1Down:Connect(function()
				held = true

				local holdtime, holdpos = tick(), inputService:GetMouseLocation()
				repeat
					held = (inputService:GetMouseLocation() - holdpos).Magnitude < 3
					heldTime = (tick() - holdtime) > 1
					task.wait()
				until heldTime or not held or not clickFrame.Visible

				if held and clickFrame.Visible then
					if libraryapi.ThreadFix then
						setthreadidentity(8);
					end

					moduleChildren.Visible = not moduleChildren.Visible
				end
			end)
			moduleButton.MouseButton1Up:Connect(function()
				held = false;
			end)
		end

		windowList:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
			if libraryapi.ThreadFix then
				setthreadidentity(8);
			end
			moduleChildren.Size = UDim2.new(1, 0, 0, windowList.AbsoluteContentSize.Y / scale.Scale);
		end);

		moduleapi.Object = moduleButton;
		libraryapi.Modules[moduleSettings.Name] = moduleapi;

		local sorting = {};
		for _, v in libraryapi.Modules do
			sorting[v.Category] = sorting[v.Category] or {};
			table.insert(sorting[v.Category], v.Name);
		end

		for _, sort in sorting do
			table.sort(sort);
			for i, v in sort do
				libraryapi.Modules[v].Index = i;
				libraryapi.Modules[v].Object.LayoutOrder = i;
				libraryapi.Modules[v].Children.LayoutOrder = i;
			end
		end

		return moduleapi
	end

	function categoryapi:Expand()
		self.Expanded = not self.Expanded;

		children.Visible = self.Expanded;
		arrow.Rotation = self.Expanded and 0 or 180;
		window.Size = UDim2.fromOffset(220, self.Expanded and math.min(41 + windowList.AbsoluteContentSize.Y / scale.Scale, 601) or 41);
		divider.Visible = children.CanvasPosition.Y > 10 and children.Visible;
	end

	-- buttons
	for i, v in components do
		categoryapi["Create" .. i] = function(_, optionSettings)
			return v(optionSettings, children, categoryapi)
		end
	end

	-- arrow button
	arrowButton.MouseButton1Click:Connect(function()
		categoryapi:Expand()
	end)
	arrowButton.MouseButton2Click:Connect(function()
		categoryapi:Expand()
	end)
	arrowButton.MouseEnter:Connect(function()
		arrow.ImageColor3 = Color3.fromRGB(220, 220, 220)
	end)
	arrowButton.MouseLeave:Connect(function()
		arrow.ImageColor3 = Color3.fromRGB(150, 150, 150)
	end)

	-- children frame
	children:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
		if self.ThreadFix then
			setthreadidentity(8)
		end

		divider.Visible = children.CanvasPosition.Y > 10 and children.Visible
	end)

	-- window
	window.InputBegan:Connect(function(inputObj)
		if inputObj.Position.Y < window.AbsolutePosition.Y + 41 and inputObj.UserInputType == Enum.UserInputType.MouseButton2 then
			categoryapi:Expand()
		end
	end)

	-- windowList
	windowList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		if self.ThreadFix then
			setthreadidentity(8)
		end

		children.CanvasSize = UDim2.fromOffset(0, windowList.AbsoluteContentSize.Y / scale.Scale)

		if categoryapi.Expanded then
			window.Size = UDim2.fromOffset(220, math.min(41 + windowList.AbsoluteContentSize.Y / scale.Scale, 601))
		end
	end)

	-- create button on main window
	categoryapi.Button = self.Categories.Main:CreateButton({
		Name = categorySettings.Name,
		Icon = categorySettings.Icon,
		Size = categorySettings.Size,
		Window = window
	})

	categoryapi.Object = window
	self.Categories[categorySettings.Name] = categoryapi

	return categoryapi
end

function libraryapi:CreateOverlay(categorySettings)
	local window;
	local categoryapi;

	-- get asset
	categorySettings.Icon = getcustomasset(categorySettings.Icon)

	categoryapi = {
		Type = "Overlay";
		Expanded = false;
		Button = self.Overlays:CreateToggle({
			Name = categorySettings.Name;
			Function = function(callback)
				window.Visible = callback and (clickFrame.Visible or categoryapi.Pinned)

				if not callback then
					for _, v in categoryapi.Connections do
						v:Disconnect()
					end
					table.clear(categoryapi.Connections)
				end

				if categorySettings.Function then
					task.spawn(categorySettings.Function, callback)
				end
			end;
			Icon = categorySettings.Icon;
			Size = categorySettings.Size;
			Position = categorySettings.Position;
		});
		Pinned = false,
		Options = {}
	}

	window = Instance.new("TextButton");
	window.Name = categorySettings.Name .. "Overlay";
	window.Size = UDim2.fromOffset(categorySettings.CategorySize or 220, 41);
	window.Position = UDim2.fromOffset(240, 46);
	window.BackgroundColor3 = theme.Main;
	window.AutoButtonColor = false;
	window.Visible = false;
	window.Text = "";
	window.Parent = scaledFrame;

	Dragify(window);

	local icon = Instance.new("ImageLabel");
	icon.Name = "Icon";
	icon.Size = categorySettings.Size;
	icon.Position = UDim2.fromOffset(12, (icon.Size.X.Offset > 14 and 14 or 13));
	icon.BackgroundTransparency = 1;
	icon.Image = categorySettings.Icon;
	icon.ImageColor3 = theme.Text;
	icon.Parent = window;

	local title = Instance.new("TextLabel");
	title.Name = "Title";
	title.Size = UDim2.new(1, -32, 0, 41);
	title.Position = UDim2.fromOffset(math.abs(title.Size.X.Offset), 0);
	title.BackgroundTransparency = 1;
	title.Text = categorySettings.Name;
	title.TextXAlignment = Enum.TextXAlignment.Left;
	title.TextColor3 = theme.Text;
	title.TextSize = 13;
	title.FontFace = theme.Font;
	title.Parent = window;

	local pin = Instance.new("ImageButton");
	pin.Name = "Pin";
	pin.Size = UDim2.fromOffset(16, 16);
	pin.Position = UDim2.new(1, -47, 0, 12);
	pin.BackgroundTransparency = 1;
	pin.AutoButtonColor = false;
	pin.Image = getcustomasset("Baya/Assets/Pin.png");
	pin.ImageColor3 = color.Darken(theme.Text, 0.43);
	pin.Parent = window;

	local customChildren = Instance.new("Frame");
	customChildren.Name = "CustomChildren";
	customChildren.Size = UDim2.new(1, 0, 0, 200);
	customChildren.Position = UDim2.fromScale(0, 1);
	customChildren.BackgroundTransparency = 1;
	customChildren.Parent = window;

	local children = Instance.new("ScrollingFrame");
	children.Name = "Children";
	children.Size = UDim2.new(1, 0, 1, -41);
	children.Position = UDim2.fromOffset(0, 37);
	children.BackgroundColor3 = color.Darken(theme.Main, 0.02);
	children.BorderSizePixel = 0;
	children.Visible = false;
	children.ScrollBarThickness = 2;
	children.ScrollBarImageTransparency = 0.75;
	children.CanvasSize = UDim2.new();
	children.Parent = window;

	local windowList = Instance.new("UIListLayout");
	windowList.SortOrder = Enum.SortOrder.LayoutOrder;
	windowList.HorizontalAlignment = Enum.HorizontalAlignment.Center;
	windowList.Parent = children;

	AddMaid(categoryapi);

	function categoryapi:Expand(check)
		if check then return end

		self.Expanded = not self.Expanded;
		children.Visible = self.Expanded;

		if self.Expanded then
			window.Size = UDim2.fromOffset(window.Size.X.Offset, math.min(41 + windowList.AbsoluteContentSize.Y / scale.Scale, 601));
		else
			window.Size = UDim2.fromOffset(window.Size.X.Offset, 41);
		end
	end

	function categoryapi:Pin()
		self.Pinned = not self.Pinned;
		pin.ImageColor3 = self.Pinned and theme.Text or color.Darken(theme.Text, 0.43);
	end

	function categoryapi:Update()
		window.Visible = self.Button.Enabled and (clickFrame.Visible or self.Pinned);

		if self.Expanded then
			self:Expand()
		end

		if clickFrame.Visible then
			window.Size = UDim2.fromOffset(window.Size.X.Offset, 41);
			window.BackgroundTransparency = 0;
			icon.Visible = true;
			title.Visible = true;
			pin.Visible = true;
		else
			window.Size = UDim2.fromOffset(window.Size.X.Offset, 0);
			window.BackgroundTransparency = 1;
			icon.Visible = false;
			title.Visible = false;
			pin.Visible = false;
		end
	end

	for i, v in components do
		categoryapi['Create'..i] = function(self, optionSettings)
			return v(optionSettings, children, categoryapi)
		end
	end

	pin.MouseButton1Click:Connect(function()
		categoryapi:Pin()
	end)

	window.MouseButton2Click:Connect(function()
		categoryapi:Expand(true)
	end)

	windowList:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
		if self.ThreadFix then
			setthreadidentity(8);
		end

		children.CanvasSize = UDim2.fromOffset(0, windowList.AbsoluteContentSize.Y / scale.Scale);

		if categoryapi.Expanded then
			window.Size = UDim2.fromOffset(window.Size.X.Offset, math.min(41 + windowList.AbsoluteContentSize.Y / scale.Scale, 601));
		end
	end)

	self:Clean(clickFrame:GetPropertyChangedSignal('Visible'):Connect(function()
		categoryapi:Update();
	end))

	categoryapi:Update()

	categoryapi.Object = window
	categoryapi.Children = customChildren

	self.Categories[categorySettings.Name] = categoryapi

	return categoryapi
end

function libraryapi:Load()
	local saveCheck = true

	-- if downloader exists | delete
	if self.Downloader then
		self.Downloader:Destroy()
		self.Downloader = nil
	end

	self.Loaded = saveCheck

	if inputService.TouchEnabled then -- mobile
		local button = Instance.new("TextButton");
		button.Name = "BayaMobile";
		button.Size = UDim2.fromOffset(32, 32);
		button.Position = UDim2.new(0, 4, 1, -35);
		button.BackgroundColor3 = Color3.new();
		button.BackgroundTransparency = 0.5;
		button.Text = "";
		button.Parent = gui;

		Dragify(button);

		local image = Instance.new("ImageLabel");
		image.Size = UDim2.fromOffset(26, 26);
		image.Position = UDim2.fromOffset(3, 3);
		image.BackgroundTransparency = 1
		image.Image = getcustomasset("Baya/Assets/BayaLogo.png");
		image.Parent = button;

		local buttoncorner = Instance.new("UICorner");
		buttoncorner.Parent = button;

		self.BayaButton = button;

		button.MouseButton1Click:Connect(function()
			if libraryapi.Windows.Draggable[button].CanClick ~= true then return end -- make sure CanClick true before running

			if self.ThreadFix then
				setthreadidentity(8);
			end

			clickFrame.Visible = not clickFrame.Visible;
			tooltip.Visible = false;
		end)

		libraryapi:CreateNotification("Baya UI Loaded", "Press button to toggle!", 5);

		if tween.Tween then
			local tweenInfo = TweenInfo.new(
				.5, -- time in seconds for tween
				Enum.EasingStyle.Sine, -- tweening style
				Enum.EasingDirection.Out, -- tweening direction
				5, -- times to repeat (when less than zero the tween will loop indefinitely)
				true, -- reverse?
				0 -- delay time
			);

			tween:Tween(button, tweenInfo, {
				BackgroundColor3 = Color3.new(1, 1, 1)
			});
		end
	else
		local concattedKeybinds = table.concat(self.Keybinds.Interact, ", ")

		libraryapi:CreateNotification("Baya UI Loaded", "Press " .. concattedKeybinds .. " to toggle!", 5)
	end
end

function libraryapi:CreateNotification(title, text, duration, type)
	task.delay(0, function()
		if self.ThreadFix then
			setthreadidentity(8);
		end

		local i = #notifications:GetChildren() + 1;

		local notification = Instance.new("ImageLabel");
		notification.Size = UDim2.fromOffset(math.max(getfontsize(RemoveTags(text), 14, theme.Font).X + 80, 266), 75);
		notification.Position = UDim2.new(1, 0, 1, -(29 + (78 * i)));
		notification.ZIndex = 5;
		notification.BackgroundTransparency = 1;
		notification.Image = getcustomasset("Baya/Assets/Notification.png");
		notification.ScaleType = Enum.ScaleType.Slice;
		notification.SliceCenter = Rect.new(7, 7, 9, 9);
		notification.Parent = notifications;

		local iconShadow = Instance.new("ImageLabel");
		iconShadow.Name = "Icon";
		iconShadow.Size = UDim2.fromOffset(60, 60);
		iconShadow.Position = UDim2.fromOffset(-5, -8);
		iconShadow.ZIndex = 5;
		iconShadow.BackgroundTransparency = 1;
		iconShadow.Image = getcustomasset("Baya/Assets/" .. (type or "Info") .. ".png");
		iconShadow.ImageColor3 = Color3.new();
		iconShadow.ImageTransparency = 0.5;
		iconShadow.Parent = notification;

		local icon = iconShadow:Clone();
		icon.Position = UDim2.fromOffset(-1, -1);
		icon.ImageColor3 = Color3.new(1, 1, 1);
		icon.ImageTransparency = 0;
		icon.Parent = iconShadow;

		local titleLabel = Instance.new("TextLabel");
		titleLabel.Name = "Title";
		titleLabel.Size = UDim2.new(1, -56, 0, 20);
		titleLabel.Position = UDim2.fromOffset(46, 16);
		titleLabel.ZIndex = 5;
		titleLabel.BackgroundTransparency = 1;
		titleLabel.Text = "<stroke color='#FFFFFF' joins='round' thickness='0.3' transparency='0.5'>"..title..'</stroke>'
		titleLabel.TextXAlignment = Enum.TextXAlignment.Left;
		titleLabel.TextYAlignment = Enum.TextYAlignment.Top;
		titleLabel.TextColor3 = Color3.fromRGB(209, 209, 209);
		titleLabel.TextSize = 14;
		titleLabel.RichText = true;
		titleLabel.FontFace = theme.FontSemiBold;
		titleLabel.Parent = notification;

		local textShadow = titleLabel:Clone();
		textShadow.Name = "Text";
		textShadow.Position = UDim2.fromOffset(47, 44);
		textShadow.Text = RemoveTags(text);
		textShadow.TextColor3 = Color3.new();
		textShadow.TextTransparency = 0.5;
		textShadow.RichText = false;
		textShadow.FontFace = theme.Font;
		textShadow.Parent = notification;

		local textLabel = textShadow:Clone();
		textLabel.Position = UDim2.fromOffset(-1, -1);
		textLabel.Text = text;
		textLabel.TextColor3 = Color3.fromRGB(170, 170, 170);
		textLabel.TextTransparency = 0;
		textLabel.RichText = true;
		textLabel.Parent = textShadow;

		local progress = Instance.new("Frame");
		progress.Name = "Progress";
		progress.Size = UDim2.new(1, -13, 0, 2);
		progress.Position = UDim2.new(0, 3, 1, -4);
		progress.ZIndex = 5;
		progress.BackgroundColor3 =
			type == "Alert" and Color3.fromRGB(250, 50, 56)
			or type == "Warning" and Color3.fromRGB(236, 129, 43)
			or Color3.fromRGB(220, 220, 220);
		progress.BorderSizePixel = 0;
		progress.Parent = notification;

		if tween.Tween then
			tween:Tween(notification, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), {
				AnchorPoint = Vector2.new(1, 0)
			}, tween.tweenstwo);
			tween:Tween(progress, TweenInfo.new(duration, Enum.EasingStyle.Linear), {
				Size = UDim2.fromOffset(0, 2)
			});
		end

		task.delay(duration, function()
			if tween.Tween then
				tween:Tween(notification, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), {
					AnchorPoint = Vector2.new(0, 0)
				}, tween.tweenstwo);
			end

			task.wait(0.2)

			notification:ClearAllChildren()
			notification:Destroy()
		end)
	end)
end

function libraryapi:Remove(obj)
	local tab = self.Categories

	if tab and tab[obj] then
		local newobj = tab[obj]

		if self.ThreadFix then
			setthreadidentity(8)
		end

		for _, v in {"Object", "Children", "Toggle", "Button"} do
			local childobj = typeof(newobj[v]) == "table" and newobj[v].Object or newobj[v]
			if typeof(childobj) == "Instance" then
				childobj:Destroy()
				childobj:ClearAllChildren()
			end
		end

		LoopClean(newobj)

		tab[obj] = nil
	end
end

function libraryapi:Uninject()
	libraryapi.Loaded = nil

	for _, v in self.Modules do
		if v["Toggle"] and v.Enabled then
			v:Toggle()
		end
	end

	for _, v in self.Categories do
		if v.Type == "Overlay" and v.Button.Enabled then
			v.Button:Toggle()
		end
	end

	for _, v in libraryapi.Connections do
		pcall(function()
			v:Disconnect()
		end)
	end

	if libraryapi.ThreadFix then
		setthreadidentity(8)
		clickFrame.Visible = false
	end

	libraryapi.gui:ClearAllChildren()
	libraryapi.gui:Destroy()

	table.clear(libraryapi.Libraries)

	LoopClean(libraryapi)

	shared.baya = nil
	shared.Init = nil
end


-- clean
libraryapi:Clean(gui:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
	scale.Scale = math.max(gui.AbsoluteSize.X / 1920, 0.6);
end))
libraryapi:Clean(scale:GetPropertyChangedSignal("Scale"):Connect(function()
	scaledFrame.Size = UDim2.fromScale(1 / scale.Scale, 1 / scale.Scale);
	-- reset scaling
	for _, obj in scaledFrame:GetDescendants() do
		if obj:IsA("GuiObject") and obj.Visible then
			obj.Visible = false
			obj.Visible = true
		end
	end
	-- re-position draggable
	for window, _ in libraryapi.Windows.Draggable do
		local x = math.clamp(window.Position.X.Offset, 0, (window.Parent.AbsoluteSize.X - window.AbsoluteSize.X) / libraryapi.gui.ScaledFrame.UIScale.Scale)
		local y = math.clamp(window.Position.Y.Offset, 0, (window.Parent.AbsoluteSize.Y - window.AbsoluteSize.Y) / libraryapi.gui.ScaledFrame.UIScale.Scale)

		window.Position = UDim2.fromOffset(x, y);
	end
end))

-- gui interaction
libraryapi:Clean(inputService.InputBegan:Connect(function(inputObj)
	if not inputService:GetFocusedTextBox() and inputObj.KeyCode ~= Enum.KeyCode.Unknown then
		table.insert(libraryapi.Keybinds.Held, inputObj.KeyCode.Name);

		-- if gui interact keybind is pressed
		if CheckKeybinds(libraryapi.Keybinds.Held, libraryapi.Keybinds.Interact, inputObj.KeyCode.Name) then
			if libraryapi.ThreadFix then
				setthreadidentity(8);
			end

			clickFrame.Visible = not clickFrame.Visible
			tooltip.Visible = false
		end
	end
end))

libraryapi:Clean(inputService.InputEnded:Connect(function(inputObj)
	local index = table.find(libraryapi.Keybinds.Held, inputObj.KeyCode.Name)
	if index then
		table.remove(libraryapi.Keybinds.Held, index)
	end
end))

--[[
	Creation
]]
local main = libraryapi:CreateGUI();
main:CreateDivider()

main:CreateOverlayBar()
--[[
	Target Info
]]
local targetinfo
local targetinfoobj
local targetinfobcolor

targetinfoobj = libraryapi:CreateOverlay({
	Name = "Target Info";
	Icon = getcustomasset("Baya/Assets/TargetInfoIcon.png");
	Size = UDim2.fromOffset(14, 14);
	Position = UDim2.fromOffset(12, 14);
	CategorySize = 240;
	Function = function(callback)
		if callback then
			task.spawn(function()
				repeat
					targetinfo:UpdateInfo()
					task.wait()
				until not targetinfoobj.Button or not targetinfoobj.Button.Enabled
			end)
		end
	end
})

-- ui
local targetinfobkg = Instance.new("Frame")
targetinfobkg.Size = UDim2.fromOffset(240, 89)
targetinfobkg.BackgroundColor3 = color.Darken(theme.Main, 0.1)
targetinfobkg.BackgroundTransparency = 0.5
targetinfobkg.Parent = targetinfoobj.Children

local targetinfoshot = Instance.new("ImageLabel")
targetinfoshot.Size = UDim2.fromOffset(26, 27)
targetinfoshot.Position = UDim2.fromOffset(19, 17)
targetinfoshot.BackgroundColor3 = theme.Main
targetinfoshot.Image = "rbxthumb://type=AvatarHeadShot&id=1&w=420&h=420"
targetinfoshot.Parent = targetinfobkg

local targetinfoshotflash = Instance.new("Frame")
targetinfoshotflash.Size = UDim2.fromScale(1, 1)
targetinfoshotflash.BackgroundTransparency = 1
targetinfoshotflash.BackgroundColor3 = Color3.new(1, 0, 0)
targetinfoshotflash.Parent = targetinfoshot

local targetinfoname = Instance.new("TextLabel")
targetinfoname.Size = UDim2.fromOffset(145, 20)
targetinfoname.Position = UDim2.fromOffset(54, 20)
targetinfoname.BackgroundTransparency = 1
targetinfoname.Text = "Target's Name"
targetinfoname.TextXAlignment = Enum.TextXAlignment.Left
targetinfoname.TextYAlignment = Enum.TextYAlignment.Top
targetinfoname.TextScaled = true
targetinfoname.TextColor3 = color.Lighten(theme.Text, 0.4)
targetinfoname.TextStrokeTransparency = 1
targetinfoname.FontFace = theme.Font

local targetinfoshadow = targetinfoname:Clone()
targetinfoshadow.Position = UDim2.fromOffset(55, 21)
targetinfoshadow.TextColor3 = Color3.new()
targetinfoshadow.TextTransparency = 0.65
targetinfoshadow.Visible = false
targetinfoshadow.Parent = targetinfobkg

targetinfoname:GetPropertyChangedSignal("Size"):Connect(function()
	targetinfoshadow.Size = targetinfoname.Size
end)
targetinfoname:GetPropertyChangedSignal("Text"):Connect(function()
	targetinfoshadow.Text = targetinfoname.Text
end)
targetinfoname:GetPropertyChangedSignal("FontFace"):Connect(function()
	targetinfoshadow.FontFace = targetinfoname.FontFace
end)

targetinfoname.Parent = targetinfobkg

local targetinfohealthbkg = Instance.new("Frame")
targetinfohealthbkg.Name = "HealthBKG"
targetinfohealthbkg.Size = UDim2.fromOffset(200, 9)
targetinfohealthbkg.Position = UDim2.fromOffset(20, 56)
targetinfohealthbkg.BackgroundColor3 = theme.Main
targetinfohealthbkg.BorderSizePixel = 0
targetinfohealthbkg.Parent = targetinfobkg

local targetinfohealth = targetinfohealthbkg:Clone()
targetinfohealth.Size = UDim2.fromScale(0.8, 1)
targetinfohealth.Position = UDim2.new()
targetinfohealth.BackgroundColor3 = Color3.fromHSV(1 / 2.5, 0.89, 0.75)
targetinfohealth.Parent = targetinfohealthbkg

targetinfohealth:GetPropertyChangedSignal("Size"):Connect(function()
	targetinfohealth.Visible = targetinfohealth.Size.X.Scale > 0.01
end)

local targetinfohealthextra = targetinfohealth:Clone()
targetinfohealthextra.Size = UDim2.new()
targetinfohealthextra.Position = UDim2.fromScale(1, 0)
targetinfohealthextra.AnchorPoint = Vector2.new(1, 0)
targetinfohealthextra.BackgroundColor3 = Color3.fromRGB(255, 170, 0)
targetinfohealthextra.Visible = false
targetinfohealthextra.Parent = targetinfohealthbkg
targetinfohealthextra:GetPropertyChangedSignal("Size"):Connect(function()
	targetinfohealthextra.Visible = targetinfohealthextra.Size.X.Scale > 0.01
end)

local targetinfob = Instance.new("UIStroke")
targetinfob.Enabled = false
targetinfob.Color = Color3.fromHSV(0.44, 1, 1)
targetinfob.Parent = targetinfobkg

local targetinfodisplay = targetinfoobj:CreateToggle({
	Name = 'Use Displayname',
	Default = true
})

local lasthealth = 0
local lastmaxhealth = 0

targetinfo = {
	Targets = {},
	Object = targetinfobkg,
	UpdateInfo = function(self)
		if not libraryapi.Libraries then return end

		for i, v in self.Targets do
			if v < tick() then
				self.Targets[i] = nil
			end
		end

		local v, highest = nil, tick()
		for i, check in self.Targets do
			if check > highest then
				v = i
				highest = check
			end
		end

		targetinfobkg.Visible = v ~= nil or libraryapi.gui.ScaledFrame.ClickFrame.Visible
		if v then
			targetinfoname.Text = v.Player and (targetinfodisplay.Enabled and v.Player.DisplayName or v.Player.Name) or v.Character and v.Character.Name or targetinfoname.Text
			targetinfoshot.Image = 'rbxthumb://type=AvatarHeadShot&id='..(v.Player and v.Player.UserId or 1)..'&w=420&h=420'

			if not v.Character then
				v.Health = v.Health or 0
				v.MaxHealth = v.MaxHealth or 100
			end

			if v.Health ~= lasthealth or v.MaxHealth ~= lastmaxhealth then
				local percent = math.max(v.Health / v.MaxHealth, 0)
				tween:Tween(targetinfohealth, TweenInfo.new(0.3), {
					Size = UDim2.fromScale(math.min(percent, 1), 1), BackgroundColor3 = Color3.fromHSV(math.clamp(percent / 2.5, 0, 1), 0.89, 0.75)
				})
				tween:Tween(targetinfohealthextra, TweenInfo.new(0.3), {
					Size = UDim2.fromScale(math.clamp(percent - 1, 0, 0.8), 1)
				})
				if lasthealth > v.Health and self.LastTarget == v then
					tween:Cancel(targetinfoshotflash)
					targetinfoshotflash.BackgroundTransparency = 0.3
					tween:Tween(targetinfoshotflash, TweenInfo.new(0.5), {
						BackgroundTransparency = 1
					})
				end
				lasthealth = v.Health
				lastmaxhealth = v.MaxHealth
			end

			if not v.Character then table.clear(v) end
			self.LastTarget = v
		end
		return v
	end
}

libraryapi.Libraries.targetinfo = targetinfo

return libraryapi