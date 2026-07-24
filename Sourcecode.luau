local Players = game:GetService("Players")

local function setupChar(char)
	local humanoid = char:WaitForChild("Humanoid")
	humanoid.BreakJointsOnDeath = false

	local function ragdoll()
		for _, track in ipairs(humanoid.Animator:GetPlayingAnimationTracks()) do
			track:Stop()
		end

		for _, motor in ipairs(char:GetDescendants()) do
			if motor:IsA("Motor6D") then
				local part0, part1 = motor.Part0, motor.Part1
				if part0 and part1 then
					local att0 = Instance.new("Attachment")
					att0.CFrame = motor.C0
					att0.Parent = part0

					local att1 = Instance.new("Attachment")
					att1.CFrame = motor.C1
					att1.Parent = part1

					local ball = Instance.new("BallSocketConstraint")
					ball.Attachment0 = att0
					ball.Attachment1 = att1
					ball.LimitsEnabled = true
					ball.TwistLimitsEnabled = true
					ball.Parent = part0
				end
				motor:Destroy()
			end
		end
	end

	humanoid.Died:Connect(ragdoll)
end

Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(setupChar)
end)
