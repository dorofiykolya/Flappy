package System.Utils
{
	import flash.events.ErrorEvent;
	import flash.events.EventDispatcher;
	import flash.system.Capabilities;
	import System.Diagnostics.Debug;
	
	/**
	 * ...
	 * @author dorofiy
	 */
	
	[Event(name="error", type="flash.events.ErrorEvent")]
	
	public class SafeInvoke
	{
		private static var event:EventDispatcher = new EventDispatcher();
		
		public static function TryInvoke(method:Function, ... params):*
		{
			if (Capabilities.isDebugger == false)
			{
				try
				{
					return method.apply(null, params);
				}
				catch (e:Error)
				{
					if (event.hasEventListener(ErrorEvent.ERROR))
					{
						event.dispatchEvent(new ErrorEvent(ErrorEvent.ERROR, false, false, formatToString("Exception: name:{0}, message:{1}, stackTrace:{2}, errorId:{3}", e.name, e.message, e.getStackTrace(), e.errorID)));
					}
					Debug.Exception(e);
					return undefined;
				}
			}
			else
			{
				return method.apply(null, params);
			}
		}
		
		public static function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
		{
			event.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		public static function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void
		{
			event.removeEventListener(type, listener, useCapture);
		}
		
		private static function formatToString(text:String, ... params):String
		{
			var len:uint = params.length;
			var args:Array;
			if (len == 1 && params[0] is Array)
			{
				args = params[0];
				len = args.length;
			}
			else
			{
				args = params;
			}
			
			for (var i:int = 0; i < len; i++)
			{
				text = text.split("{" + i + "}").join(args[i]);
			}
			return text;
		}
	}

}