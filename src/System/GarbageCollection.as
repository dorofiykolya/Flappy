package System
{
	import flash.net.LocalConnection;
	import flash.system.Capabilities;
	import flash.system.System;
	import flash.utils.Dictionary;
	import System.Diagnostics.Debug;
	
	/**
	 * ...
	 * @author dorofiy
	 */
	public class GarbageCollection
	{
		private static var collect:Object;
		private static var dictionary:Dictionary;
		
		public static function InvokeDebug():Boolean
		{
			try
			{
				if (Capabilities.isDebugger || Object(flash.system.System).hasOwnProperty("gc"))
				{
					var isOk:Boolean;
					try
					{
						if (Object(flash.system.System).hasOwnProperty("pauseForGCIfCollectionImminent"))
						{
							flash.system.System["pauseForGCIfCollectionImminent"](0);
						}
						flash.system.System['gc']();
						if (Object(flash.system.System).hasOwnProperty("pauseForGCIfCollectionImminent"))
						{
							flash.system.System["pauseForGCIfCollectionImminent"](0);
						}
						isOk = true;
					}
					catch (e:Error)
					{
						Debug.Exception(e);
					}
					if (isOk)
					{
						Debug.Note("GarbageCollection Success!");
						return true;
					}
					else
					{
						Debug.Note("GarbageCollection Fail!");
						return false;
					}
				}
				return false;
			}
			catch (error:Error)
			{
				Debug.Note("DEBUG GarbageCollection Fail!");
				return false;
			}
			return false;
		}
		
		public static function PauseForGCIfCollectionImminent(imminence:Number = 0.75):void
		{
			if (Object(flash.system.System).hasOwnProperty("pauseForGCIfCollectionImminent"))
			{
				flash.system.System["pauseForGCIfCollectionImminent"](imminence);
			}
		}
		
		public static function TryInvoke():Boolean
		{
			if (InvokeDebug())
			{
				return true;
			}
			try
			{
				test();
				new LocalConnection().connect('foo');
				new LocalConnection().connect('foo');
			}
			catch (e:Error)
			{
				Debug.Exception(e.message);
			}
			return Test();
		}
		
		private static function Test():Boolean
		{
			var cleared:Boolean = true;
			for each (var key:*in dictionary)
			{
				cleared = false;
			}
			if (cleared)
			{
				Debug.Trace("GarbageCollection success!");
			}
			else
			{
				Debug.Trace("GarbageCollection fail!");
			}
			return cleared;
		}
		
		private static function test():void
		{
			collect = {};
			dictionary = new Dictionary(true);
			dictionary[collect] = true;
			collect = null;
		}
	}

}