-- Main file,


local iceModule = require(script.iceModule)

local rs = game:GetService("RunService")
local ts = game:GetService("TweenService")

local vfx = script.vfx

local dummy = game:GetService("Workspace").dummy
local charge = dummy.charge

local explosionPart = vfx.Part.Attachment:Clone()


wait(3)
num = 15

while true do
	
	local dummyPos1 = CFrame.new(8.78, 7.278, -14.572)
	local dummyPos2 = CFrame.new(8.78, 1.01, -14.572)
	local dummyEnd = CFrame.new(8.78, 5, -14.572)
	
	
	task.spawn(function()
		for i,v in pairs(charge:GetChildren()) do
			task.spawn(function()
				v.Enabled = true

			end)

		end
	end)
	local goal= {}
	goal.CFrame = dummyPos1
	local info = TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0)
	local tween = ts:Create(dummy, info, goal)
	tween:Play()
	
	tween.Completed:Connect(function()
		task.spawn(function()
			for i,v in pairs(charge:GetChildren()) do
				task.spawn(function()
					v.Enabled = false

				end)

			end
		end)
		task.wait(0.35)
		local goal= {}
		goal.CFrame = dummyPos2
		local info = TweenInfo.new(0.2, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out, 0, false, 0)
		local tween = ts:Create(dummy, info, goal)
		tween:Play()
		
		

			explosionPart.Parent = workspace.explosionPart
			for i,v in pairs(explosionPart:GetChildren()) do
				v:Emit(v:GetAttribute("EmitCount"))
	
			end
	

		
		task.spawn(function()
			task.wait(0.15)
			local goal= {}
			goal.CFrame = dummyEnd
			local info = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0)
			local tween = ts:Create(dummy, info, goal)
			tween:Play()

			
			
		end)
	
		
		
		for i = 1,num do
			iceModule.startIce(dummy)
			wait(0.02)
		end	

		
		iceModule.clearIce()
		

	end)
	
	
	wait(5)
end
