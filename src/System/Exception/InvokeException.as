package System.Exception 
{
	/**
	 * ...
	 * @author dorofiy
	 */
	public class InvokeException extends Error 
	{
		
		public function InvokeException(message:String = "invoke error", id:* = 0) 
		{
			super(message, id);
		}
		
	}

}