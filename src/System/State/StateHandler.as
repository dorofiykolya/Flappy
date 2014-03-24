package System.State
{
	import System.IDisposable;
	import System.Signals.SignalDispatcher;
	
	/**
	 * ...
	 * @author dorofiy
	 */
	public class StateHandler implements IDisposable
	{
		private var _signal:SignalDispatcher = new SignalDispatcher();
		private var _stateHandler:Function;
		
		public function StateHandler(stateHandler:Function /*():void*/)
		{
			_stateHandler = stateHandler;
		}
		
		/**
		 * add listener
		 * @param	state
		 * @param	listener Function - listener on state change, Object - apply property from listener object to IStateObserver
		 */
		public function AddListener(state:String, listener:Function /*():void*/):void
		{
			if (listener == null)
				return;
			if (listener as Function)
			{
				_signal.AddListener(state, listener);
			}
		}
		
		/**
		 * remove listener
		 * @param	state
		 * @param	listener Function - listener on state change, Object - apply property from listener object to IStateObserver
		 */
		public function RemoveListener(state:String, listener:Function /*():void*/):void
		{
			if (listener == null)
				return;
			if (listener as Function)
			{
				_signal.RemoveListener(state, listener);
			}
		}
		
		internal function Invoke(state:String):void
		{
			_signal.Invoke(state);
		}
		
		public function Dispose():void
		{
			_signal.Dispose();
		}
	
	}

}