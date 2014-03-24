package starling.events 
{
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class ExceptionEvent extends Event 
	{
		static public const EXCEPTION:String = "exception";
		private var _name:String;
		private var _message:String;
		private var _stackTrace:String;
		private var _errorId:Object;
		
		
		public function ExceptionEvent(type:String, name:String, message:String, stackTrace:String, errorId:Object, data:Object=null) 
		{
			super(type, true, data);
			this._name = name;
			this._message = message;
			this._stackTrace = stackTrace;
			this._errorId = errorId;
		}
		
		public function get name():String 
		{
			return _name;
		}
		
		public function get message():String 
		{
			return _message;
		}
		
		public function get stackTrace():String 
		{
			return _stackTrace;
		}
		
		public function get errorId():Object 
		{
			return _errorId;
		}
		
		
	}

}