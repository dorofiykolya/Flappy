package System.Async
{
	import System.IDelegate;
	import System.IDisposable;
	
	/**
	 * ...
	 * @author dorofiy
	 */
	public interface IAsyncResult extends IDisposable
	{
		function get AsyncState():Object;
		function get IsCompleted():Boolean;
		function get OnError():IDelegate;
		function get OnComplete():IDelegate;
	}

}