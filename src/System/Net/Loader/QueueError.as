package System.Net.Loader 
{
	/**
	 * ...
	 * @author dorofiy
	 */
	public class QueueError extends Error 
	{
		
		public function QueueError() 
		{
			super("current item is load now");
		}
		
	}

}