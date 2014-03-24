package System.Diagnostics
{
	/**
	 * ...
	 * @author dorofiy
	 */
	import flash.trace.Trace;
	
	public class Trace
	{
		
		private static var isInit:Boolean;
		private static var linesExecuted:uint = 0;
		private static var isStarted:Boolean;
		private static var list:Vector.<Function> = new Vector.<Function>();
		
		/**
		 * Start Trace Application
		 */
		public static function Start():void
		{
			if (isInit == false)
			{
				flash.trace.Trace.setListener(traceListener);
				isInit = true;
			}
			flash.trace.Trace.setLevel(flash.trace.Trace.METHODS_AND_LINES_WITH_ARGS, flash.trace.Trace.LISTENER);
			isStarted = true;
		}
		
		/**
		 * Stop Trace Application
		 */
		public static function Stop():void
		{
			flash.trace.Trace.setLevel(flash.trace.Trace.OFF, flash.trace.Trace.LISTENER);
			invoke('Total lines executed: ' + linesExecuted);
			linesExecuted = 0;
			isStarted = false;
		}
		
		/**
		 * Is Started Trace Application
		 */
		public static function get IsStarted():Boolean
		{
			return isStarted;
		}
		
		/**
		 * add function with one parameter typeof String
		 * example: function onTraceHandler(message:String):void{ trace(message); };
		 * @param	listener
		 */
		public static function AddListener(listener:Function):void
		{
			var i:int = list.indexOf(listener);
			if (i == -1)
			{
				list.push(listener);
			}
		}
		
		/**
		 * remove function with one parameter typeof String
		 * example: function onTraceHandler(message:String):void{ trace(message); };
		 * @param	listener
		 */
		public static function RemoveListener(listener:Function):void
		{
			var i:int = list.indexOf(listener);
			if (i != -1)
			{
				list.splice(i, 1);
			}
		}
		
		private static function invoke(message:String):void
		{
			trace(message);
			for each (var l:Function in list)
			{
				l(message);
			}
		}
		
		private static function traceListener(fileInfo:String, lineNumber:String, classAndMethod:String, methodArguments:String):void
		{
			linesExecuted++;
			while (lineNumber.length <= 5)
			{
				lineNumber = ' ' + lineNumber;
			}
			var message:String = lineNumber + " [" + classAndMethod + '](' + methodArguments + ')';
			invoke(message);
		}
	
	}

}