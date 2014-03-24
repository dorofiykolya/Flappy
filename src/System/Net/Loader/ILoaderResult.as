package System.Net.Loader 
{
	import System.Async.IAsyncResult;
	import System.Async.IAsyncProgress;
	import System.IDelegate;
	
	/**
	 * ...
	 * @author dorofiy
	 */
	public interface ILoaderResult extends IAsyncResult, IAsyncProgress
	{
		function get OnIOError():IDelegate;
		function get OnOpen():IDelegate;
		function get OnInit():IDelegate;
	}
	
}