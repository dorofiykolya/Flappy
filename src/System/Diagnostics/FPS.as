package System.Diagnostics 
{
	import flash.display.Shape;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.utils.getTimer;
	/**
	 * ...
	 * @author dorofiy
	 */
	public class FPS 
	{
		private static var _shape:Shape = new Shape();
		private static var _fps:Number;
		private static var _lastTime:uint = getTimer();
		private static var _frame:uint;
		public static function Start():void {
			_shape.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		public static function Stop():void {
			if (_shape) {
				_shape.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			}
		}
		public static function get fps():Number {
			return _fps;
		}
		private static function onEnterFrame(e:Event):void 
		{
			_frame++;
            var now:uint = getTimer();
            var delta:uint = now - _lastTime;
            if (delta >= 1000) {
                _fps = _frame / delta * 1000;
                _frame = 0;
                _lastTime = now;
            }
		}
	}

}