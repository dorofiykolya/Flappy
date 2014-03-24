package System.Async
{
	import flash.utils.Dictionary;
	import System.IDisposable;
	import System.IEquals;
	
	/**
	 * ...
	 * @author dorofiy
	 */
	public class AsyncInvoker implements IDisposable, IEquals
	{
		
		private static var _globalTimeStep:int = 5;
		private static var dictionary:Dictionary = new Dictionary(true);
		
		static public function get GlobalTimeStep():int
		{
			return _globalTimeStep;
		}
		
		static public function set GlobalTimeStep(value:int):void
		{
			_globalTimeStep = value;
		}
		
		/**
		 * Return Thread
		 * @param	name
		 * @return
		 */
		public static function GetByName(name:String):AsyncInvoker
		{
			return dictionary[name];
		}
		
		public static function GetAll():Vector.<AsyncInvoker>
		{
			var vec:Vector.<AsyncInvoker> = new Vector.<AsyncInvoker>();
			for each (var th:AsyncInvoker in dictionary)
			{
				if (th == null)
					continue;
				vec.push(th);
			}
			return vec;
		}
		
		public static function Create(runnable:IAsyncHandler, name:String = null, runnableParameters:Array = null):AsyncInvoker
		{
			return new AsyncInvoker(runnable, name, runnableParameters);
		}
		private static var countThreads:int = 0;
		
		private var _name:String;
		private var _globalTimer:Boolean;
		private var _timeStep:int = 5;
		
		public function AsyncInvoker(runnable:IAsyncHandler, name:String = null, runnableParameters:Array = null, useGlobalTimeStep:Boolean = true, timeStep:int = 5)
		{
			countThreads++;
			if (name == null)
			{
				name = "#" + countThreads;
				while (dictionary[name] != undefined)
				{
					countThreads++;
					name = "#" + countThreads;
				}
			}
			else if (dictionary[name] != undefined)
			{
				throw new ArgumentError("AsyncInvoker, name: \"" + name + "\" is exist");
			}
			dictionary[name] = this;
			_name = name;
			_globalTimer = useGlobalTimeStep;
			_timeStep = 5;
		}
		
		public function Resume():void
		{
		
		}
		
		public function Pause():void
		{
		
		}
		
		public function Reset():void
		{
		
		}
		
		public function get Name():String
		{
			return _name;
		}
		
		public function Dispose():void
		{
			_name = null;
		}
		
		public function Equals(v:Object):Boolean
		{
			return this == v;
		}
	}

}

