package System.Async 
{
	import System.IDelegate;
	
	/**
	 * ...
	 * @author dorofiy
	 */
	public interface IAsyncProgress 
	{
		function get Current():int;
		function get Total():int;
		function get OnProgress():IDelegate;
	}
	
}