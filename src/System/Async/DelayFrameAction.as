package System.Async
{
	import flash.display.Shape;
	import flash.events.Event;
	
	import System.IDisposable;
	
	public class DelayFrameAction implements IDisposable
	{
		private static const _shape:Shape = new Shape();
		
		private var delayHandle:Function;
		private var parameters:Array;
		private var delay:int;
		
		public var completed:Boolean;
		public var started:Boolean;
		
		public function DelayFrameAction(handle:Function, delayFrame:uint = 1, ... params)
		{
			delay = delayFrame;
			delayHandle = handle;
			parameters = params;
			_shape.addEventListener(Event.ENTER_FRAME, onDelayActionEnterFrame);
		}
		
		private function onDelayActionEnterFrame(e:Event):void
		{
			if (--delay > 0)
			{
				return;
			}
			_shape.removeEventListener(Event.ENTER_FRAME, onDelayActionEnterFrame);
			if(delayHandle as Function)
			{
				delayHandle.apply(null, parameters);
			}
			delayHandle = null;
			parameters = null;
		}
		
		public function Dispose():void
		{
			_shape.removeEventListener(Event.ENTER_FRAME, onDelayActionEnterFrame);
			delayHandle = null;
			parameters = null;
		}
	}
}