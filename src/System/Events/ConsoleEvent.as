package System.Events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class ConsoleEvent extends Event 
	{
		public static const READ:String = 'read';
		private var value:String;
		public function ConsoleEvent(type:String, value:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			this.value = value;
		} 
		
		public function get text():String {
			return value;
		}
		
		public override function clone():Event 
		{ 
			return new ConsoleEvent(type, value, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("ConsoleEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}