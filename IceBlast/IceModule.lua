local iceSettings = {}
local mainFolder = workspace.iceDebris
local vfxFold = script.Parent.vfx
local ts = game:GetService("TweenService")

local location = game.Workspace.location


local val = -4
local sizeZ = 3
local sizeX = 10
local sideval = .5

function iceSettings.startIce(dummy)
	local extra = math.random(-11,11)/10

	
	local shard = vfxFold.shard:Clone()
	shard.Parent = mainFolder
	
	local side = math.random(-sideval, sideval)
	up = shard.Size.Y/1.5
	local rotate = math.random(0,180)
	
	
	local MRo = math.random(99,100)
	if MRo == 99 then
		local SRo = math.random(8,10)/10
		URo = MRo + SRo
	else
		local SRo = math.random(1,3)/10
		URo = MRo + SRo		
		
	end
	shard.Size = Vector3.new(sizeZ, sizeX, sizeZ)
	shard.CFrame = location.CFrame * CFrame.new(side, -up, val + extra)
	shard.CFrame = shard.CFrame * CFrame.fromEulerAnglesXYZ(URo, rotate, 0.1)
		
	val = val - 2
	sizeZ = sizeZ + 1
	sizeX = sizeX + 1
	sideval = sideval + .5
	
	
	task.spawn(function()
		local goal= {}
		goal.Transparency = 0
		goal.CFrame = shard.CFrame * CFrame.new(0, 2,0)
		local info = TweenInfo.new(0.2, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out, 0, false, 0)
		local tween = ts:Create(shard, info, goal)
		tween:Play()
		print("Starting")
		tween.Completed:Connect(function()
			shard.Material = Enum.Material.Ice
			
			for i,v in pairs(shard:GetDescendants()) do
				if v:IsA("ParticleEmitter") then
					v:Emit(2)
					
				end
				
			end
			
			
			task.wait(2)
			shard.Material = Enum.Material.Glass
			shard.mist.Enabled = false
			shard.mist:Clear()

			local goal1 = {}
			goal1.Transparency = 1
			goal1.CFrame = shard.CFrame * CFrame.new(0, -2,0)
			local info1 = TweenInfo.new(0.3, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0)
			local tween1 = ts:Create(shard, info1, goal1)
			tween1:Play()
			tween1.Completed:Connect(function()
				shard:Destroy()
			
			end)

		end)
		
		
		
	end)
	
end


function iceSettings.clearIce()
	val = -4
	sizeZ = 3
	sizeX = 10
	sideval = .5


	
end






return iceSettings
