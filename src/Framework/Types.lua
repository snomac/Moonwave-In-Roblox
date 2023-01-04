-- Begin writing export types here

--@internal/Common.lua
export type TypedRBXScriptSignal<T...> = {
	Connect: (TypedRBXScriptSignal<T...>, func: (T...) -> ()) -> RBXScriptConnection,
	ConnectParallel: (TypedRBXScriptSignal<T...>, func: (T...) -> ()) -> RBXScriptConnection,
	Once: (TypedRBXScriptSignal<T...>, func: (T...) -> ()) -> RBXScriptConnection,
	Wait: (TypedRBXScriptSignal<T...>) -> T...,
}

--@exports/Action.lua
export type Action<I..., O...> = {
	_signal: (I...) -> O...,
	Name: string,
	ShowWarnings: boolean,
	await: (Action<I..., O...>, I...) -> (boolean, O...),
	handleAsync: (Action<I..., O...>, func: (boolean, O...) -> (), I...) -> (optMsg: string?) -> boolean
}

--@exports/Event.lua
export type Signal<A...> = {
	Connect: (Signal<A...>, func: (A...) -> ()) -> () -> (),
	ConnectedFunctions: {(A...) -> ()},
	Wait: (Signal<A...>) -> A...,
	WaitingThreads: {thread}
}

export type Event<A...> = {
	Signal: Signal<A...>,
	Fire: (Event<A...>, A...) -> (),

	--DEPRECATED, Remove by v0.3 release
	Connect: (Event<A...>, func: (A...) -> ()) -> () -> (),
	Wait: (Event<A...>) -> A...,
}

--@exports/Form.lua
export type Form<O..., C...> = {
	Name: string,
	DockWidget: any, --would cast this but Roblox is "cute"
	IsLoaded: boolean,

	Open: (Form<O..., C...>, O...) -> (),
	Close: (Form<O..., C...>, C...) -> (),

	Loading: (Form<O..., C...>) -> ()?,
	Opening: (Form<O..., C...>, O...) -> ()?,
	Closing: (Form<O..., C...>, C...) -> ()?,

	--Additional bindings for external forms
	[string]: any
}

export type DockWidgetPluginGuiBindings = {
	Archivable: boolean?,
	AutoLocalize: boolean?,
	Enabled: boolean?,
	HostWidgetWasRestored: boolean?,
	Name: string?,
	ResetOnSpawn: boolean?,
	RootLocalizationTable: LocalizationTable?,
	SelectionBehaviorDown: Enum.SelectionBehavior?,
	SelectionBehaviorLeft: Enum.SelectionBehavior?,
	SelectionBehaviorRight: Enum.SelectionBehavior?,
	SelectionBehaviorUp: Enum.SelectionBehavior?,
	SelectionGroup: boolean?,
	Title: string?,
	ZIndexBehavior: Enum.ZIndexBehavior?,
	[string]: any
}

--@exports/Input.lua
export type TabbyInputObject = {
	KeyCode: Enum.KeyCode,
	Position: Vector2,
	UserInputType: Enum.UserInputType,
	UserInputState: Enum.UserInputState
}

--@QtInterface
export type QtInterface<T,M> = {
	ID: string,
	Type: T,
	Mount: M?,
	GetMount: (QtInterface<T,M>) -> M,
	IsA: (QtInterface<T,M>, typeName: string) -> boolean
}

type ButtonConfig = {
	ID: string,
	Name: string,
	Description: string,
	Icon: string?,
	ClickableWhenViewportHidden: boolean?,
	Callback: (button: PluginToolbarButton, toolbar: QtToolbar) -> ()?
}

export type QtMenu = QtInterface<"PluginMenu", PluginMenu> & {
	initialise: (
		QtMenu,
		title: string?,
		icon: string?
	) -> QtMenu,
	Clear: (QtMenu) -> (),
	ShowAsync: (QtMenu) -> (),
	
	--
	AddMenu: (QtMenu, menu: QtMenu) -> QtMenu,
	AddAction: (QtMenu, action: QtAction) -> QtMenu,
	AddNewAction: (QtMenu, id: string, title: string?, icon: string?, callback: () -> ()?) -> QtMenu,

	-- Children API
	Children: {QtAction|QtMenu}, -- Ordered list of children based on how they're rendered
	ChildActions: {[string]: QtAction}, -- Actions indexed by ID
	ChildMenus: {[string]: QtMenu}, -- Menus indexed by ID
	GetFullTree: (QtMenu) -> {QtAction|QtMenu}, -- returns everything as a list of objects. This is useful if you want to iterate over actions/menus to change stuff around

	-- Icon API
	SetActionIcon: (QtMenu, iconID: string) -> (), --UNIMPLEMENTED, DO NOT USE
	SetIcon: (QtMenu, iconID: string) -> ()
}

export type QtAction = QtInterface<"PluginAction", PluginAction> & {
	initialise: (
		QtAction, 
		name: string?, 
		description: string?,
		icon: string?,
		allowBinding: boolean?,
		callback: () -> ()?
	) -> QtAction,
	IsTemporaryAction: boolean,
	SetIcon: (QtAction, iconID: string) -> never --Unimplemented.
}

export type QtToolbar = QtInterface<"PluginToolbar", PluginToolbar> & {
	initialise: (
		QtToolbar
	) -> QtToolbar,
	AddButton: (QtToolbar, buttonConfig: ButtonConfig) -> QtToolbar,
	SetIcon: (QtToolbar, buttonID: string, iconID: string?) -> (),
	Buttons: {
		[string]: PluginToolbarButton
	}
}

--@Internal/RuntimeScript
type DataModelSessionType = "Edit"|"PlayServer"|"PlayClient"|"Standalone"

export type RuntimeScript = {
	Name: string,
	Priority: number,
	DataModelSessionType: DataModelSessionType,
	DataModelSessionFilter: {"*"|DataModelSessionType},

	-- more lifecycle hooks?
	Init: (RuntimeScript) -> ()?,
	Activated: (RuntimeScript) -> ()?,
	Deactivated: (RuntimeScript) -> ()?,
	Unloading: (RuntimeScript) -> ()?
}

return nil