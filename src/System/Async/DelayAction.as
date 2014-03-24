package System.Async
{
	import flash.events.TimerEvent;
	import flash.utils.clearTimeout;
	import flash.utils.Timer;
	import System.IDisposable;
	
	/**
	 * ...
	 * @author dorofiy
	 */
	public class DelayAction implements IDisposable
	{
		private var _handle:Function;
		private var _params:Array;
		private var _timer:Timer;
		public var started:Boolean;
		public var completed:Boolean;
		
		public function DelayAction(handle:Function = null, ... params)
		{
			_handle = handle;
			_params = params;
		}
		
		public function Start(delay:uint = 1000, count:uint = 1):void
		{
			Stop();
			if (_timer == null)
			{
				_timer = new Timer(delay, count);
			}
			_timer.delay = delay;
			_timer.addEventListener(TimerEvent.TIMER_COMPLETE, onComplete);
			_timer.start();
			started = true;
		}
		
		public function Resume():void
		{
			if (started == false)
			{
				_timer.addEventListener(TimerEvent.TIMER_COMPLETE, onComplete);
				_timer.start();
			}
			started = true;
		}
		
		private function onComplete(e:TimerEvent):void
		{
			if (_handle as Function)
			{
				_handle.apply(null, _params);
			}
			completed = true;
		}
		
		public function Stop():void
		{
			if (_timer)
			{
				_timer.removeEventListener(TimerEvent.TIMER_COMPLETE, onComplete);
				_timer.stop();
			}
			started = false;
		}
		
		public function Dispose():void
		{
			if (_timer)
			{
				_timer.removeEventListener(TimerEvent.TIMER_COMPLETE, onComplete);
				_timer.stop();
			}
			_handle = null;
			_params = null;
			completed = false;
			_timer = null;
			started = false;
		}
	}

}