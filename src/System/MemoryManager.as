package System 
{
	import flash.system.System;
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class MemoryManager 
	{
		private static var list:Vector.<Object> = new Vector.<Object>(10000);
		private static var index:int;
		private static var max:int;
		
		public function MemoryManager() 
		{
			
		}
		
		public static function get MaxCapacity():int
		{
			return max;
		}
		
		public static function set MaxCapacity(value:int):void
		{
			max = value;
		}
		
		public static function get FreeMemory():Number
		{
			return System.freeMemory;
		}
		
		public static function get TotalMemory():Number
		{
			return System.totalMemoryNumber;
		}
		
		public static function get PrivateMemory():Number
		{
			return System.privateMemory;
		}
		
		public static function Put(value:Object):void
		{
			list[index++] = value;
			
			if (index >= max || FreeMemory <= 10 * 1000 * 1000)
			{
				Free();
			}
		}
		
		public static function GC():void
		{
			GarbageCollection.TryInvoke();
		}
		
		public static function SetMaxCollectionImminent():void
		{
			System.pauseForGCIfCollectionImminent(1);
		}
		
		public static function Free():void
		{
			index = 0;
			list.length = index;
			GarbageCollection.TryInvoke();
		}
		
	}

}