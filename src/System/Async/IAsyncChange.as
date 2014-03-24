package System.Async 
{
	import System.Delegate;
	
	/**
	 * ...
	 * @author dorofiy
	 */
	public interface IAsyncChange 
	{
		function get OnChange():Delegate;
		function get AsyncResult():Object;
	}
	
}