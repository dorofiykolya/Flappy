package System.Async
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author dorofiy
	 */
	public class AsyncCall
	{
		private var _timer:Timer = new Timer(10, 1);
		private var _func:Function;
		private var _params:Array;
		
		public function AsyncCall(handle:Function, ... params)
		{
			if (handle == null)
			{
				throw new ArgumentError("handle");
			}
			_func = handle;
			_params = params;
			_timer.addEventListener(TimerEvent.TIMER_COMPLETE, onComplete);
			_timer.start();
		}
		
		private function onComplete(e:TimerEvent):void
		{
			_timer.removeEventListener(TimerEvent.TIMER_COMPLETE, onComplete);
			_timer.stop();
			_timer = null;
			if (_func as Function)
			{
				_func.apply(null, _params);
			}
		}
	
	}

}