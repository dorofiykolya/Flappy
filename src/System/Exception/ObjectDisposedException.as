package System.Exception 
{
	/**
	 * ...
	 * @author dorofiy
	 */
	public class ObjectDisposedException extends Error 
	{
		
		public function ObjectDisposedException(message:*="", id:*=0) 
		{
			super(message, id);
		}
		
	}

}