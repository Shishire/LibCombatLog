local CallbackHandler = LibStub("CallbackHandler-1.0")

local MAJOR, MINOR = "LibCombatLog-1.0", 0
local LibCombatLog = LibStub:NewLibrary(MAJOR, MINOR)

if not LibCombatLog then return end

local tremove = table.remove

LibCombatLog.frame = LibCombatLog.frame or CreateFrame("Frame", "LibCombatLog10Frame")
LibCombatLog.embeds = LibCombatLog.embeds or {}


if not LibCombatLog.events then
	LibCombatLog.events = CallbackHandler:New(LibCombatLog,
		"RegisterCombatEvent", "UnregisterCombatEvent", "UnregisterAllCombatEvents")
end

local mixins = {
	"RegisterCombatEvent", "UnregisterCombatEvent",	"UnregisterAllCombatEvents",
}

LibCombatLog.events.registerCount = 0

function LibCombatLog.events:OnUsed(target, eventname)
	if not LibCombatLog.frame:IsEventRegistered("COMBAT_LOG_EVENT_UNFILTERED") then
		LibCombatLog.frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	end
	self.registerCount = self.registerCount + 1
end

function LibCombatLog.events:OnUnused(target, eventname)
	self.registerCount = self.registerCount - 1
	if self.registerCount <= 0 then
		LibCombatLog.frame:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	end
end

function LibCombatLog:Embed(target)
	for k, v in pairs(mixins) do
		target[v] = self[v]
	end
	self.embeds[target] = true
	return target
end

function LibCombatLog:OnEmbedDisable(target)
	target:UnregisterAllCombatEvents()
end

local events = LibCombatLog.events
LibCombatLog.frame:SetScript("OnEvent", function(self, event)
	args = { CombatLogGetCurrentEventInfo() }
	local eventType = tremove(args,2)
	events:Fire(eventType, unpack(args))
end)

for target, v in pairs(LibCombatLog.embeds) do
	LibCombatLog:Embed(target)
end

