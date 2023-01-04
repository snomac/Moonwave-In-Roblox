-- Input singleton API
local Types = require(script.Parent.Parent.Types)
type TabbyInputObject = Types.TabbyInputObject

local RuntimeEngine = require(script.Parent.Parent.Internal.Runtime)
local Event = require(script.Parent.Event)
local Common = require(script.Parent.Parent.Internal.Common)
local Input = {}

local Plugin = Common.Plugin
local MouseObject = Plugin:GetMouse()

local InputBeganEvent: Types.Event<TabbyInputObject> = Event()
local InputChangedEvent: Types.Event<TabbyInputObject> = Event()
local InputEndedEvent: Types.Event<TabbyInputObject> = Event()

local Mouse = {
	Active = Plugin:IsActivatedWithExclusiveMouse(),
	Mount = MouseObject
}

local function InputObject()
	return {
		KeyCode = Enum.KeyCode.Unknown,
		Position = Vector2.new(),
		UserInputType = Enum.UserInputType.None,
		UserInputState = Enum.UserInputState.None
	}
end

Input.Mouse = Mouse
Input.InputBegan = InputBeganEvent.Signal
Input.InputChanged = InputChangedEvent.Signal
Input.InputEnded = InputEndedEvent.Signal

function Input:Activate()
	Plugin:Activate(true)
	Mouse.Active = true
	RuntimeEngine:InvokeLifecycleAsync("Activated")
end

function Input:Deactivate()
	Mouse.Active = false
	RuntimeEngine:InvokeLifecycleAsync("Deactivated")
end

Plugin.Deactivation:Connect(function()
	Input:Deactivate()
end)

local function keyboardEvent(key, state, event)
	local key = Common.GetKeyCodeEnumFromChar(key)
	if key then
		local io = InputObject()
		io.KeyCode = key
		io.UserInputType = Enum.UserInputType.Keyboard
		io.UserInputState = state

		table.freeze(io)
		event:Fire(io)
	end
end

local function mouseKeyEvent(type, state, event)
	local io = InputObject()
	io.Position = Vector2.new(MouseObject.X, MouseObject.Y)
	io.UserInputState = state
	io.UserInputType = type

	table.freeze(io)
	event:Fire(io)
end

-- Input Bindings
MouseObject.KeyDown:Connect(function(k)
	keyboardEvent(k, Enum.UserInputState.Begin, InputBeganEvent)
end)

MouseObject.KeyUp:Connect(function(k)
	keyboardEvent(k, Enum.UserInputState.End, InputEndedEvent)
end)

MouseObject.Button1Down:Connect(function()
	mouseKeyEvent(Enum.UserInputType.MouseButton1, Enum.UserInputState.Begin, InputBeganEvent)
end)

MouseObject.Button1Up:Connect(function()
	mouseKeyEvent(Enum.UserInputType.MouseButton1, Enum.UserInputState.End, InputEndedEvent)
end)

MouseObject.Button2Down:Connect(function()
	mouseKeyEvent(Enum.UserInputType.MouseButton2, Enum.UserInputState.Begin, InputBeganEvent)
end)

MouseObject.Button2Up:Connect(function()
	mouseKeyEvent(Enum.UserInputType.MouseButton2, Enum.UserInputState.End, InputEndedEvent)
end)

MouseObject.Move:Connect(function()
	local io = InputObject()
	io.Position = Vector2.new(MouseObject.X, MouseObject.Y)
	io.UserInputState = Enum.UserInputState.Change
	io.UserInputType = Enum.UserInputType.MouseMovement

	table.freeze(io)
	InputChangedEvent:Fire(io)
end)

return Input