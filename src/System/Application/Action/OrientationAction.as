package System.Application.Action 
{
	/**
	 * ...
	 * @author dorofiy
	 */
	public class OrientationAction 
	{
		public static const ORIENTATION_CHANGE : String = "orientationChange";
		public static const ORIENTATION_CHANGING : String = "orientationChanging";
		
		private static var pool:Vector.<OrientationAction> = new Vector.<OrientationAction>();
		
		public static function PoolGet(type:String, beforeOrientation:String=null, afterOrientation:String=null):OrientationAction {
			if (pool.length == 0) return new OrientationAction(type, beforeOrientation, afterOrientation);
			return pool.pop().Set(type, beforeOrientation, afterOrientation);
		}
		
		public static function PoolSet(action:OrientationAction):void {
			pool.push(action);
		}
		
		
		public var type:String;
		public var beforeOrientation:String;
		public var afterOrientation:String;
		public function OrientationAction(type:String, beforeOrientation:String=null, afterOrientation:String=null) 
		{
			this.type = type;
			this.beforeOrientation = beforeOrientation;
			this.afterOrientation = afterOrientation;
		}
		
		public function Set(type:String, beforeOrientation:String = null, afterOrientation:String = null):OrientationAction {
			this.type = type;
			this.beforeOrientation = beforeOrientation;
			this.afterOrientation = afterOrientation;
			return this;
		}
		
	}

}