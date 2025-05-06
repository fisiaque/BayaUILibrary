--______     ______     __  __     ______        __  __     __        __         __     ______     ______     ______     ______     __  __    
--/\  == \   /\  __ \   /\ \_\ \   /\  __ \      /\ \/\ \   /\ \      /\ \       /\ \   /\  == \   /\  == \   /\  __ \   /\  == \   /\ \_\ \   
--\ \  __<   \ \  __ \  \ \____ \  \ \  __ \     \ \ \_\ \  \ \ \     \ \ \____  \ \ \  \ \  __<   \ \  __<   \ \  __ \  \ \  __<   \ \____ \  
-- \ \_____\  \ \_\ \_\  \/\_____\  \ \_\ \_\     \ \_____\  \ \_\     \ \_____\  \ \_\  \ \_____\  \ \_\ \_\  \ \_\ \_\  \ \_\ \_\  \/\_____\ 
--  \/_____/   \/_/\/_/   \/_____/   \/_/\/_/      \/_____/   \/_/      \/_____/   \/_/   \/_____/   \/_/ /_/   \/_/\/_/   \/_/ /_/   \/_____/ 
                                                                                                                                                                                                                         
local library = {
	Windows = {
		Draggable = {};
	};
    Categories = {};
    Libraries = {};
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
        Hue = 0.46,
		Sat = 0.96,
		Value = 0.52
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
	["Baya/UIAssets/Warning.png"] = "rbxassetid://125144969372589";
	["Baya/UIAssets/Alert.png"] = "rbxassetid://102812705220441";
	["Baya/UIAssets/Info.png"] = "rbxassetid://105237774908134";
	["Baya/UIAssets/Notification.png"] = "rbxassetid://115871497200510";
    ["Baya/UIAssets/GUILogo.png"] = "rbxassetid://89243102639787";
    ["Baya/UIAssets/ExpandRight.png"] = "rbxassetid://93216503898531";
    ["Baya/UIAssets/ExpandUp.png"] = "rbxassetid://110148963103901";
    ["Baya/UIAssets/ActionIcon.png"] = "rbxassetid://129077738159596";
	["Baya/UIAssets/PrayerIcon.png"] = "rbxassetid://112615257443345";
    ["Baya/UIAssets/BayaLogo.png"] = "rbxassetid://120654586984889";
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
	if library.Loaded ~= true then
		local loadingLabel = library.Downloader

		if not loadingLabel then
			loadingLabel = Instance.new("TextLabel")
			loadingLabel.Size = UDim2.new(1, 0, 0, 40)
			loadingLabel.BackgroundTransparency = 1
			loadingLabel.TextStrokeTransparency = 0
			loadingLabel.TextSize = 20
			loadingLabel.TextColor3 = Color3.new(1, 1, 1)
			loadingLabel.FontFace = theme.Font
			loadingLabel.Parent = library.gui
			
			library.Downloader = loadingLabel
		end

		loadingLabel.Text = "Downloading " .. text
	end
end

-- get asset
local function DownloadFile(path, func)
    if not isfile(path) then
        SetDownloadMessage(path)

        local suc, res = pcall(function()
            return game:HttpGet("https://raw.githubusercontent.com/fisiaque/BayaUILibrary/"..readfile("Baya/commit.txt").."/"..select(1, path:gsub("Baya/", "")), true)
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
    
    tween:Tween(optionapi.Object.Arrow, theme.Tween, {
        Position = UDim2.new(1, optionapi.Enabled and -14 or -20, 0, 16)
    })

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

-- make gui draggable
local function Dragify(gui, window)
	library.Windows.Draggable[gui] = {
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
			) / library.gui.ScaledFrame.UIScale.Scale

            local changed = inputService.InputChanged:Connect(function(input)
				if input.UserInputType == (inputObj.UserInputType == Enum.UserInputType.MouseButton1 and Enum.UserInputType.MouseMovement or Enum.UserInputType.Touch) and (not library.Windows.Dragging or library.Windows.Dragging == gui) then
					library.Windows.Dragging = gui -- prevents more than 1 window from "stack" dragging
					
					local position = input.Position;
                    -- snap to grid if left shift held
                    if inputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                        dragPosition = (dragPosition // 3) * 3;
                        position = (position // 3) * 3;
                    end
					
					local x = math.clamp((position.X / library.gui.ScaledFrame.UIScale.Scale) + dragPosition.X, 0, (gui.Parent.AbsoluteSize.X - gui.AbsoluteSize.X) / library.gui.ScaledFrame.UIScale.Scale)
					local y = math.clamp((position.Y / library.gui.ScaledFrame.UIScale.Scale) + dragPosition.Y, 0, (gui.Parent.AbsoluteSize.Y - gui.AbsoluteSize.Y) / library.gui.ScaledFrame.UIScale.Scale)
					
					gui.Position = UDim2.fromOffset(x, y);
                end
            end)

            local ended
			ended = inputObj.Changed:Connect(function()
				if inputObj.UserInputState == Enum.UserInputState.End then
					if gui.Position ~= library.Windows.Draggable[gui].Position then -- if window has been moved then it won"t toggle after moved
						library.Windows.Dragging = nil

						library.Windows.Draggable[gui].Position = gui.Position
						library.Windows.Draggable[gui].CanClick = false

						task.delay(.25, function()
							library.Windows.Draggable[gui].CanClick = true
						end)
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

--|| ||--
AddMaid(library)

-- folder creation
for _, folder in {"Baya", "Baya/UIAssets"} do
	if not isfolder(folder) then
		makefolder(folder)
	end
end

-- update baya library
local _, subbed = pcall(function()
    return game:HttpGet("https://github.com/fisiaque/BayaUILibrary")
end)

local commit = subbed:find("currentOid")
commit = commit and subbed:sub(commit + 13, commit + 52) or nil
commit = commit and #commit == 40 and commit or "main"

if commit == "main" or (isfile("Baya/commit.txt") and readfile("Baya/commit.txt") or "") ~= commit then
    WipeFolder("Baya")
    WipeFolder("Baya/UIAssets")
end

writefile("Baya/commit.txt", commit)

-- gui creation
local gui = Instance.new("ScreenGui");
gui.Name = RandomString();
gui.DisplayOrder = 9999999;
gui.ZIndexBehavior = Enum.ZIndexBehavior.Global;
gui.IgnoreGuiInset = true;
gui.OnTopOfCoreBlur = true

-- if threadidentity exist parent to core gui otherwise player gui
if library.ThreadFix then
    gui.Parent = cloneref(game:GetService("CoreGui"));
else
    gui.Parent = cloneref(game:GetService("Players")).LocalPlayer.PlayerGui;
    gui.ResetOnSpawn = false;
end

-- set a main variable for gui
library.gui = gui

-- create main frame
local scaledFrame = Instance.new("Frame");
scaledFrame.Name = "ScaledFrame";
scaledFrame.Size = UDim2.fromScale(1, 1);
scaledFrame.BackgroundTransparency = 1;
scaledFrame.Parent = gui

-- create UI scale
local scale = Instance.new("UIScale");
scale.Scale = math.max(gui.AbsoluteSize.X / 1920, 0.6);
scale.Parent = scaledFrame;

-- resize scaledFrame
scaledFrame.Size = UDim2.fromScale(1 / scale.Scale, 1 / scale.Scale)

-- create Notifications folder
notifications = Instance.new("Folder")
notifications.Name = "Notifications"
notifications.Parent = scaledFrame

-- create click gui
local clickFrame = Instance.new("Frame");
clickFrame.Name = "ClickFrame";
clickFrame.Size = UDim2.fromScale(1, 1); 
clickFrame.BackgroundTransparency = 1;
clickFrame.Visible = false;
clickFrame.Parent = scaledFrame

-- create tooltip
local tooltip = Instance.new("TextLabel");
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

-- library
function library:CreateGUI()
	local categoryapi = {
		Type = "MainWindow";
		Buttons = {};
		Options = {};
	}

	local window = Instance.new("TextButton");
	window.Name = "GUICategory";
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
	logo.Image = getcustomasset("Baya/UIAssets/GUILogo.png");
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
		button.Text = (categorySettings.Icon and "                                 " or "             ") .. categorySettings.Name;
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
		arrow.Image = getcustomasset("Baya/UIAssets/ExpandRight.png");
		arrow.ImageColor3 = color.Lighten(theme.Main, 0.35);
		arrow.Parent = button;

		optionapi.Name = categorySettings.Name;
		optionapi.Icon = icon;
		optionapi.Object = button;
		
		-- button toggle
		function optionapi:Toggle()
			for _, _button in library.Categories.Main.Buttons do
				if _button ~= library.Categories.Main.Buttons[optionapi.Name] and _button.Enabled then
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

function library:CreateCategory(categorySettings)
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
	arrow.Image = getcustomasset("Baya/UIAssets/ExpandUp.png");
	arrow.ImageColor3 = Color3.fromRGB(150, 150, 150);
	arrow.Rotation = 180;
	arrow.Parent = arrowButton;

	-- scrolling frame
	local children = Instance.new("ScrollingFrame");
	children.Name = "Children";
	children.Size = UDim2.new(1, 0, 1, -41);
	children.Position = UDim2.fromOffset(0, 37);
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

	function categoryapi:CreateModule(modulesettings)

	end

	function categoryapi:Expand()
		self.Expanded = not self.Expanded

		children.Visible = self.Expanded
		arrow.Rotation = self.Expanded and 0 or 180;
		window.Size = UDim2.fromOffset(220, self.Expanded and math.min(41 + windowList.AbsoluteContentSize.Y / scale.Scale, 601) or 41);
		divider.Visible = children.CanvasPosition.Y > 10 and children.Visible
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

function library:Load()
	local saveCheck = true

	-- if downloader exists | delete
	if self.Downloader then
		self.Downloader:Destroy()
		self.Downloader = nil
	end

	self.Loaded = saveCheck

	if inputService.TouchEnabled then -- mobile
		-- create click gui
		local mobileFrame = Instance.new("Frame");
		mobileFrame.Name = "MobileFrame";
		mobileFrame.Size = UDim2.fromScale(1, 1); 
		mobileFrame.BackgroundTransparency = 1;
		mobileFrame.Parent = scaledFrame

		local button = Instance.new("TextButton");
		button.Size = UDim2.fromOffset(32, 32);
		button.BackgroundColor3 = Color3.new();
		button.BackgroundTransparency = 0.5;
		button.Text = "";
		button.Parent = mobileFrame;

		Dragify(button);

		local image = Instance.new("ImageLabel");
		image.Size = UDim2.fromOffset(26, 26);
		image.Position = UDim2.fromOffset(3, 3);
		image.BackgroundTransparency = 1
		image.Image = getcustomasset("Baya/UIAssets/BayaLogo.png");
		image.Parent = button;
		
		local buttoncorner = Instance.new("UICorner");
		buttoncorner.Parent = button;
		
		self.BayaButton = button;
		
		button.MouseButton1Click:Connect(function()
			if library.Windows.Draggable[button].CanClick ~= true then return end -- make sure CanClick true before running

			if self.ThreadFix then
				setthreadidentity(8);
			end

			clickFrame.Visible = not clickFrame.Visible;
			tooltip.Visible = false;
		end)

		library:CreateNotification("Baya Loaded", "Press button to toggle!", 5);

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

		library:CreateNotification("Baya Loaded", "Press " .. concattedKeybinds .. " to toggle!", 5)
	end
end

function library:CreateNotification(title, text, duration, type)
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
		notification.Image = getcustomasset("Baya/UIAssets/Notification.png");
		notification.ScaleType = Enum.ScaleType.Slice;
		notification.SliceCenter = Rect.new(7, 7, 9, 9);
		notification.Parent = notifications;

		local iconShadow = Instance.new("ImageLabel");
		iconShadow.Name = "Icon";
		iconShadow.Size = UDim2.fromOffset(60, 60);
		iconShadow.Position = UDim2.fromOffset(-5, -8);
		iconShadow.ZIndex = 5;
		iconShadow.BackgroundTransparency = 1;
		iconShadow.Image = getcustomasset("Baya/UIAssets/" .. (type or "Info") .. ".png");
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

function library:Remove(obj)
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

function library:Uninject()
	library.Loaded = nil

	for _, v in self.Categories do
		if v.Type == "Overlay" and v.Button.Enabled then
			v.Button:Toggle()
		end
	end

	for _, v in library.Connections do
		pcall(function()
			v:Disconnect()
		end)
	end

	if library.ThreadFix then
		setthreadidentity(8)
		clickFrame.Visible = false
	end

	library.gui:ClearAllChildren()
	library.gui:Destroy()

	table.clear(library.Libraries)

	LoopClean(library)

	shared.library = nil
end

-- clean
library:Clean(gui:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
	scale.Scale = math.max(gui.AbsoluteSize.X / 1920, 0.6);
end))
library:Clean(scale:GetPropertyChangedSignal("Scale"):Connect(function()
	scaledFrame.Size = UDim2.fromScale(1 / scale.Scale, 1 / scale.Scale);
	-- reset scaling
	for _, obj in scaledFrame:GetDescendants() do
		if obj:IsA("GuiObject") and obj.Visible then
			obj.Visible = false
			obj.Visible = true
		end
	end
	-- re-position draggable
	for window, _ in library.Windows.Draggable do
		local x = math.clamp(window.Position.X.Offset, 0, (window.Parent.AbsoluteSize.X - window.AbsoluteSize.X) / library.gui.ScaledFrame.UIScale.Scale)
		local y = math.clamp(window.Position.Y.Offset, 0, (window.Parent.AbsoluteSize.Y - window.AbsoluteSize.Y) / library.gui.ScaledFrame.UIScale.Scale)
					
		window.Position = UDim2.fromOffset(x, y);
	end
end))

-- gui interaction
library:Clean(inputService.InputBegan:Connect(function(inputObj)
	if not inputService:GetFocusedTextBox() and inputObj.KeyCode ~= Enum.KeyCode.Unknown then
		table.insert(library.Keybinds.Held, inputObj.KeyCode.Name);

		-- if gui interact keybind is pressed
		if CheckKeybinds(library.Keybinds.Held, library.Keybinds.Interact, inputObj.KeyCode.Name) then
			if library.ThreadFix then
				setthreadidentity(8);
			end

			clickFrame.Visible = not clickFrame.Visible
			tooltip.Visible = false
		end
	end
end))

library:Clean(inputService.InputEnded:Connect(function(inputObj)
	local index = table.find(library.Keybinds.Held, inputObj.KeyCode.Name)
	if index then
		table.remove(library.Keybinds.Held, index)
	end
end))

return library