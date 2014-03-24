package System.Async
{
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	import System.IDisposable;
	
	/**
	 * ...
	 * @author dorofiy
	 */
	public class DelayTimeAction implements IDisposable
	{
		private var time:int;
		private var func:Function;
		private var arr:Array;
		public var completed:Boolean;
		
		public function DelayTimeAction(handle:Function, delay:int = 1000, ... params)
		{
			func = handle;
			arr = params;
			time = setTimeout(onTime, delay);
		}
		
		private function onTime():void
		{
			clearTimeout(time);
			if (func != null)
			{
				func.apply(null, arr);
			}
			func = null;
			arr = null;
			completed = true;
		}
		
		public function Dispose():void
		{
			clearTimeout(time);
			func = null;
			arr = null;
		}
	
	}

}