package System.Diagnostics 
{
	import flash.display.DisplayObjectContainer;
	/**
	 * ...
	 * @author dorofiy
	 */
	public class Profiler 
	{
		private static var inst:Profiler;
		private static var _container:DisplayObjectContainer;
		public function Profiler() 
		{
			
		}
		
		public static function get Instance():Profiler {
			if (inst == null) inst = new Profiler();
			return inst;
		}
		public static function Show(container:DisplayObjectContainer = null):void {
			if (container) {
				_container = container;
			}

		}
		public static function Hide():void {
			
		}
		
	}

}