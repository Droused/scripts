local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "DrousedHub",
    LoadingTitle = "Full Verison",
    LoadingSubtitle = "by droused",
    ConfigurationSaving = {
       Enabled = true,
       FolderName = nil, -- Create a custom folder for your hub/game
       FileName = "Big Hub"
    },
    Discord = {
       Enabled = false,
       Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ABCD would be ABCD
       RememberJoins = true -- Set this to false to make them join the discord every time they load it up
    },
    KeySystem = true, -- Set this to true to use our key system
    KeySettings = {
       Title = "TooColdHub Key",
       Subtitle = "Key System",
       Note = "https://pastebin.com/raw/YYtR5GLv",
       FileName = "Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
       SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
       GrabKeyFromSite = true, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
       Key = {"https://pastebin.com/raw/YYtR5GLv", "key123"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
    }
 })

 local MainTab = Window:CreateTab("Home", nil) -- Title, Image
 local MainSection = MainTab:CreateSection("Main")

Rayfield:Notify({
    Title = "Welcome To Droused's Hub",
    Content = "welcome",
    Duration = 5,
    Image = nil,
    Actions = { -- Notification Buttons
       Ignore = {
          Name = "Okay!",
          Callback = function()
       end
    },
 },
 })
 
 local function create(class, properties)
	local drawing = Drawing.new(class)
	for property, value in pairs(properties) do
		drawing[property] = value;
	end
	return drawing
end
 local RunService = game:GetService("RunService")


 local Button = MainTab:CreateButton({
    Name = "Preset MS",
    Callback = function()
        local plr = game.Players.LocalPlayer
        local rs = game:GetService("RunService")
         
        function magBall(ball)
           if ball and plr.Character then
               firetouchinterest(plr.Character["Left Arm"], ball, 0)
               task.wait()
               firetouchinterest(plr.Character["Left Arm"], ball, 1)
           end
        end
         
        rs.Stepped:Connect(function()
           for i,v in pairs(workspace:GetChildren()) do
               if v.Name == "Football" and v:IsA("BasePart") then
                   local mag = (plr.Character.Torso.Position - v.Position).Magnitude
                   magBall(v)
               end
           end
        end)
    end,
 })

local player = game.Players.LocalPlayer

local function floor2(v)
	return Vector2.new(math.floor(v.X), math.floor(v.Y))
end

 local Button = MainTab:CreateButton({
    Name = "Ball ESP",
    Callback = function()

local ball = Workspace.Egirl_Kendal.Football

local ballESP = {}

-- Functions
local function createBallEsp()
	local BOX_OUTLINE_COLOR = Color3.new(1,0,0)
 
    ballESP.circleOutline = create("Circle", {
        Color = BOX_OUTLINE_COLOR,
        Thickness = 3,
        Filled = false
    });
end

local function removeBallEsp()
    for _, drawing in pairs(ballESP) do
        drawing:Remove();
    end

    ballESP = {};
end


workspace.ChildRemoved:Connect(function(child)
	if child == ball then
		removeBallEsp()
		ball = nil
	end
end)


local function updateBallEsp()
	local camera = workspace.CurrentCamera


	if not ball or not ball:IsA('BasePart') then return end
	
	local success, result = pcall(function()
		return camera:WorldToViewportPoint(ball.Position)
	end)
	
	if not success then
		warn("Error while getting WorldToViewportPoint: ", result)
		return
	end
	
    local screen, onScreen = camera:WorldToViewportPoint(ball.Position)

    if onScreen then
    	local distance = (ball.Position - camera.CFrame.Position).Magnitude
    	local scale = 200 / distance
        local size = Vector2.new(10, 10)  -- adjust this value to fit the size of the ball
        local position = Vector2.new(screen.X, screen.Y);
	    
	    ballESP.circleOutline.Position = Vector2.new(screen.X, screen.Y)
	    ballESP.circleOutline.Radius = scale
	    
    end

    for _, drawing in pairs(ballESP) do
        drawing.Visible = onScreen;
    end
end

-- Event Connection
ball.AncestryChanged:Connect(function(child, parent)
    if not parent then
        removeBallEsp()
    end
end)

-- Initialize and update functions
createBallEsp()
RunService.RenderStepped:Connect(updateBallEsp);
    end,
 })

 local MainTab = Window:CreateTab("Player", nil) -- Title, Image
 local MainSection = MainTab:CreateSection("Main")

 local Slider = MainTab:CreateSlider({
    Name = "WalkSpeed",
    Range = {0, 300},
    Increment = 1,
    Suffix = "Speed",
    CurrentValue = 16,
    Flag = "Slider1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Value)
    getgenv().WalkSpeedValue = Value
	player.Character.Humanoid:GetPropertyChangedSignal'WalkSpeed':Connect(function()
	player.Character.Humanoid.WalkSpeed = getgenv().WalkSpeedValue;
	end)
	player.Character.Humanoid.WalkSpeed = getgenv().WalkSpeedValue;
    end,
 })
 
local Slider = MainTab:CreateSlider({
    Name = "JumpPower",
    Range = {0, 300},
    Increment = 1,
    Suffix = "JP",
    CurrentValue = 16,
    Flag = "Slider1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Value)
   	game.Players.LocalPlayer.Character:WaitForChild("Humanoid").JumpHeight = 20
    end,
 })

 local MainTab = Window:CreateTab("Break Script", nil) -- Title, Image
 local MainSection = MainTab:CreateSection("Main")


-- utils
workspace.ChildAdded:Connect(function(child)
	if child.Name == "Football" and child:IsA('BasePart') then
		ball = child
		createBallEsp()
	end
end)

local inititalBall = workspace:FindFirstChild("Football")
if initialBall and initialBall:IsA("BasePart") then
	ball = initialBall
	createBallEsp()
end

local function searchByName(parent, namePart)
	for _, child in pairs(parent:GetChildren()) do 
		if string.find(child.Name, namePart) then
			print("Found object named", child.Name, "under", parent:GetFullName())
		end
		searchByName(child, namePart)
	end
end
searchByName(workspace, "ball")