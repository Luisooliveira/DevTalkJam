function StateMachine(statesNumber, defaultState) constructor
{
	State = -1;
	LastState = State;
	DefaultState = defaultState;
	
	Locked = false;
	
	States[statesNumber - 1] = 0;
	
	static Update = function()
	{
		if (!Locked)
		{
			if (State == -1)
			{
				SetState(DefaultState);
			}
			
			//Run the state update script and check for transition
			var func = States[State][1];
			with (other) var stateTransition = func();
			if (stateTransition != undefined)
			{
				SetState(stateTransition);
			}
		}
	}
	
	static AddState = function(stateIndex, updateScript, beginScript = undefined, endScript = undefined)
	{
		States[stateIndex] = [beginScript, updateScript, endScript]
	}
	
	static SetState = function(newState)
	{
		LastState = State;
		State = newState;
		
		if (LastState != State)
		{
			//Run the state begin script
			if (States[State][0] != undefined)
			{
				var func = States[State][0];
				with (other) func();
			}
			
			if (LastState != -1)
			{
				//Run the state end script (if is not undefined)
				if (States[LastState][2] != undefined)
				{
					var func = States[LastState][2];
					with (other) func();
				}
			}
		}
	}
}