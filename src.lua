local library = {
    Windows = {};
    Categories = {};
    Libraries = {};
    Keybind = "End";
    Loaded = false;
    Place = game.PlaceId;
    ThreadFix = setthreadidentity and true or false; -- checks if executor suppors setthreadidentity
    Version = "0.0.1"
}

-- variables
local color = {};
local theme = {
    Main = Color3.fromRGB(20, 20, 20);
    Text = Color3.fromRGB(200, 200, 200);
    Font = Font.fromEnum(Enum.Font.Arial);
    FontSemiBold = Font.fromEnum(Enum.Font.Arial, Enum.FontWeight.SemiBold)
};
local assets = {
    ["Baya/UIAssets/GUILogo.png"] = "rbxassetid://100130787086109",
}
-- getcustomasset built in-function in exploit executors
local assetfunction = getcustomasset 
local getcustomasset
local marked = "--MARKED: DELETE IF CACHED INCASE BAYA UPDATES.\n"

-- creates a safe reference to a roblox instance object if executor doesn"t already have on pre-built
local cloneref = cloneref or function(obj)
    return obj
end

-- services
local runService = cloneref(game:GetService("RunService"));
local guiService = cloneref(game:GetService("GuiService"));
local inputService = cloneref(game:GetService("UserInputService"));

-- get asset
getcustomasset = not inputService.TouchEnabled and assetfunction and function(path)
	return DownloadFile(path, assetfunction)
end or function(path)
	return assets[path] or ""
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

-- wipe folder
local function WipeFolder(path)
    -- check path
    if not isfolder(path) then return end

    for _, file in listfiles(path) do
        if isfile(file) and select(1, readfile(file):find(marked)) == 1 then
            print("Deleting")
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
    gui.InputBegan:Connect(function(inputObj)
        if window and not window.Visible then return end -- window has to be visible

        if 
            (inputObj.UserInputType == Enum.UserInputType.MouseButton1 or inputObj.UserInputType == Enum.UserInputType.Touch) 
            and (inputObj.Position.Y - gui.AbsolutePosition.Y < 40 or window)
        then
            local dragPosition = Vector2.new(
				gui.AbsolutePosition.X - inputObj.Position.X,
				gui.AbsolutePosition.Y - inputObj.Position.Y + guiService:GetGuiInset().Y
			) / gui.ScaledFrame.UIScale.Scale

            local changed = inputService.InputChanged:Connect(function(input)
				if input.UserInputType == (inputObj.UserInputType == Enum.UserInputType.MouseButton1 and Enum.UserInputType.MouseMovement or Enum.UserInputType.Touch) then
                    local position = input.Position;
                    -- snap to grid if left shift held
                    if inputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                        dragPosition = (dragPosition // 3) * 3;
                        position = (position // 3) * 3;
                    end

                    gui.Position = UDim2.fromOffset((position.X / gui.ScaledFrame.UIScale.Scale) + dragPosition.X, (position.Y / gui.ScaledFrame.UIScale.Scale) + dragPosition.Y);
                end
            end)
        end
    end)
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
			loadingLabel.FontFace = uipallet.Font
			loadingLabel.Parent = library.gui
			library.Downloader = loadingLabel
		end
		loadingLabel.Text = "Downloading " .. text
	end
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
-- 
AddMaid(library)

-- folder creation
for _, folder in {'Baya', 'Baya/UIAssets'} do
	if not isfolder(folder) then
		makefolder(folder)
	end
end

-- update baya library
local _, subbed = pcall(function()
    return game:HttpGet('https://github.com/fisiaque/BayaUILibrary')
end)

local commit = subbed:find('currentOid')
commit = commit and subbed:sub(commit + 13, commit + 52) or nil
commit = commit and #commit == 40 and commit or 'main'

if commit == 'main' or (isfile('Baya/commit.txt') and readfile('Baya/commit.txt') or '') ~= commit then
    wipeFolder('Baya')
    wipeFolder('Baya/UIAssets')
end

writefile('Baya/commit.txt', commit)

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
    local mainCategory = {
        Type = "MainWindow";
        Buttons = {};
        Options = {};
    }

    local window = Instance.new("TextButton");
    window.Name = "GUICategory";
    window.Position = UDim2.fromOffset(6, 60);
    window.BackgroundColor3 = color.Darken(theme.Main, 0.02);
    window.AutoButtonColor = false
    window.text = "";
    window.Parent = clickgui;

    Dragify(window)

    local logo = Instance.new("ImageLabel");
    logo.Name = "BayaLogo";
    logo.Size = UDim2.fromOffset(62, 18);
    logo.Position = UDim2.fromOffset(11, 10);
    logo.BackgroundTransparency = 1;
    logo.Image = GetAsset("Baya/UIAssets/GUILogo.png")
    logo.ImageColor3 = select(3, theme.Main:ToHSV()) > 0.5 and theme.Text or Color3.new(1, 1, 1);
    logo.Parent = window

    mainCategory.Object = window
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
end))