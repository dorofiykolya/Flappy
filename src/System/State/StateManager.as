package System.State
{
	import System.Delegate;
	import System.IDelegate;
	import System.IDisposable;
	
	/**
	 * ...
	 * @author dorofiy
	 */
	public class StateManager implements IDisposable
	{
		private var _previousState:String;
		private var _currentState:String;
		private var _onChangeState:Delegate = new Delegate();
		private var _enterState:StateHandler;
		private var _exitState:StateHandler;
		
		private var _defaultProperty:Object = {};
		
		public function StateManager(instance:IStateObserver = null)
		{
			_enterState = new StateHandler(OnEnterStateHandler);
			_exitState = new StateHandler(OnExitStateHandler);
		}
		
		internal function OnExitStateHandler():void
		{
		
		}
		
		internal function OnEnterStateHandler():void
		{
		
		}
		
		public function ChangeState(state:String):void
		{
			if (state == null)
			{
				throw new ArgumentError("[System.State.StateManager][ChangeState] state == null");
			}
			if (_currentState == state)
			{
				return;
			}
			_previousState = _currentState;
			if (_currentState == null)
			{
				_previousState = state;
			}
			_currentState = state;
			_exitState.Invoke(_previousState);
			_enterState.Invoke(_currentState);
			_onChangeState.Invoke();
		}
		
		public function get PreviousState():String
		{
			return _previousState;
		}
		
		public function get CurrentState():String
		{
			return _currentState;
		}
		
		public function set CurrentState(value:String):void
		{
			ChangeState(value);
		}
		
		public function get OnStateChanged():IDelegate
		{
			return _onChangeState;
		}
		
		public function get OnEnterState():StateHandler
		{
			return _enterState;
		}
		
		public function get OnExitState():StateHandler
		{
			return _exitState;
		}
		
		public function Dispose():void
		{
			_onChangeState.Dispose();
			_enterState.Dispose();
			_exitState.Dispose();
		}
	}

}