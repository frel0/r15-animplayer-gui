-- anim player made by reestart! (https://raw.githubusercontent.com/restarrt/r15-anim-player/main/r15animplayer.lua)
-- decided to make a gui for this because why not.

-- warning: this fuck$ up for ragdolls and other dumb bs so dont blame the script, blame the anim.

-- the anim player is frame based so lets cap our fps to 44 so it wont be speeded up like minecraft speedruns
setfpscap(44) -- (this can be also used as a speed changer, for example:value 24 = normal,value 45 = kinda speeded up, value 120 = fast)

loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/rodus", true))() -- put this first above everything (important!)

CreateMain("Anim Player")

CreateTab("R15")

CreateTextBox(tabs['R15'], "Play Animation", "Anim ID",function(arg)
-- here we go the anim player.
local animation = arg -- gets the anim id from the textbox
local getanim = game:GetObjects("rbxassetid://"..animation)[1]
local keyframes = {}
local motors = {}
for i,v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
    if v.ClassName == "Motor6D" and v.Name ~= "Neck" then
        v.Name = v.Parent.Name
        v.Parent = nil
        table.insert(motors, v)
    end
end
local function getmethod(limbname, maincframe)
    local whattoreturn = CFrame.new(0, 0, 0)
    for i,v in pairs(motors) do
        if limbname == v.Name then
        whattoreturn = v.Part0.CFrame * (v.Part0.CFrame * v.C0 * maincframe * v.C1:inverse()):ToObjectSpace(v.Part0.CFrame):inverse()
       end
    end
    return whattoreturn
end
for i,v in pairs(getanim:GetDescendants()) do
    if v.ClassName == "Keyframe" then
        table.insert(keyframes, v)
    end
end
game.RunService.Heartbeat:connect(function()
    local character = workspace[game.Players.LocalPlayer.Name]
    if character ~= nil then
        character.HumanoidRootPart.CanCollide = false
        for i,v in pairs(character:GetDescendants()) do
            if v.ClassName == "MeshPart" then
                v.Velocity = Vector3.new(100, 100, 100)
                v.CanCollide = false
            end
        end
    end
end)
repeat
for i,v in pairs(keyframes) do
        game.RunService.Heartbeat:wait()
    for i,m in pairs(v:GetDescendants()) do
    if m.ClassName == "Pose" and m.Name ~= "HumanoidRootPart" then
    game.Players.LocalPlayer.Character[m.Name].CFrame = getmethod(m.Name, m.CFrame)
    end
    print(v)
    end
end
until game.Players.LocalPlayer.Character.Humanoid.Health == 0
end)
