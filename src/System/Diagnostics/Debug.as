package System.Diagnostics
{
	import System.Text.StringUtil;
	import System.Type.Type;
	
	/**
	 * ...
	 * @author dorofiy
	 */
	public class Debug
	{
		private static var removeAt:RegExp = /^\s*at\s*/i;
		private static var matchFile:RegExp = /[(][)][\[][^:]*?:[0-9]+[\]]\s*$/i;
		private static var trimFile:RegExp = /[()\[\]\s]*/ig;
		private static var tempText:String = '';
		
		public static function Write(text:String, ... params):void
		{
			params.unshift(text);
			tempText += StringUtil.Format.apply(null, params);
		}
		
		public static function Flush():void
		{
			trace(tempText);
			tempText = "";
		}
		
		public static function WriteLine(text:String, ... params):void
		{
			params.unshift(text);
			trace(StringUtil.Format.apply(null, params));
		}
		
		public static function Trace(... params):void
		{
			params.unshift(null);
			params.unshift(true);
			params.unshift(true);
			var message:String = getStack.apply(null, params);
			trace(message);
		}
		
		public static function Inspect(... params):String
		{
			var result:String = System.Type.Type.Inspect.apply(null, params);
			trace(result);
			return result;
		}
		
		public static function Alert(message:Object, inspect:Boolean = false, line:Boolean = false):void
		{
			if (line)
			{
				trace("4:" + getStack(true, inspect, null, message));
			}
			else
			{
				if (inspect)
				{
					trace("4:" + Type.Inspect(message));
				}
				else
				{
					trace("4:" + message);
				}
			}
		}
		
		public static function Warning(message:Object, inspect:Boolean = false, line:Boolean = false):void
		{
			if (line)
			{
				trace("2:" + getStack(true, inspect, null, message));
			}
			else
			{
				if (inspect)
				{
					trace("2:" + Type.Inspect(message));
				}
				else
				{
					trace("2:" + message);
				}
			}
		}
		
		public static function Bug(message:Object, inspect:Boolean = false, line:Boolean = false):void
		{
			if (line)
			{
				trace("3:" + getStack(true, inspect, null, message));
			}
			else
			{
				if (inspect)
				{
					trace("3:" + Type.Inspect(message));
				}
				else
				{
					trace("3:" + message);
				}
			}
		}
		
		public static function Note(message:Object, inspect:Boolean = false, line:Boolean = false):void
		{
			if (line)
			{
				trace("0:" + getStack(true, inspect, null, message));
			}
			else
			{
				if (inspect)
				{
					trace("0:" + Type.Inspect(message));
				}
				else
				{
					trace("0:" + message);
				}
			}
		}
		
		public static function Exception(error:Error, stackTrace:Boolean = true):void
		{
			if (stackTrace)
			{
				trace("3: Exception BEGIN");
				trace("3: " + getStack(true, false, null, error + " name:" + error.name + ", message:" + error.message + ", errorID:" + error.errorID + ", stackTrace:"));
				var s:String = error.getStackTrace();
				var arr:Array = s.split("\n");
				for (var i:int = 0; i < arr.length; i++) 
				{
					trace("3: " + arr[i]);
				}
				trace("3: Exception END");
			}
			else
			{
				trace("3: " + getStack(true, false, null, "Exception => " + error + " name:" + error.name + ", message:" + error.message + ", errorID:" + error.errorID));
			}
		}
		
		private static function removePath(value:String):String
		{
			var fi:int = value.indexOf('[');
			var li:int = value.indexOf(']', fi);
			var temp:String = value;
			value = value.substring(0, fi);
			value += temp.substring(li, temp.length - 1);
			return value;
		}
		
		private static function formatToString(val:*, inspect:Boolean):String
		{
			if (val == null)
				return "null";
			if (val == undefined)
				return "undefined";
			if (inspect)
			{
				return System.Type.Type.Inspect(val);
			}
			return val.toString();
		}
		
		public static function getStack(removePathFile:Boolean = true, inspect:Boolean = false, error:Error = null, ... params):String
		{
			var s:String = error ? error.getStackTrace() : new Error().getStackTrace();
			var func:String = "_func_";
			var args:String = null;
			var line:String = '_line_';
			if (s)
			{
				var arr:Array = s.split("\n");
				if (arr && arr.length)
				{
					func = arr[arr.length - 1];
					func = func.replace(removeAt, "");
					func = func.replace(matchFile, "");
					var l:int = func.search(/\d{0,5}]/);
					if (l != -1)
					{
						line = (func.substring(l, func.indexOf(']', l)));
						while (line.length < 4)
						{
							line = " " + line;
						}
						if (removePathFile)
						{
							func = removePath(func);
						}
					}
				}
			}
			for each (var param:*in params)
			{
				args = (args == null ? "" : args.concat(", "));
				args = args.concat(formatToString(param, inspect));
			}
			return line + " " + func + " trace:" + (args == null ? "" : args);
		}
	
	}

}