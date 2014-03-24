package System.Async 
{
	
	/**
	 * ...
	 * @author dorofiy
	 */
	public interface IAsyncHandler
	{
		function Reset():void;
		function Update():void;
		function get Total():Number;
		function get Current():Number;
		function get IsCompleted():Boolean;
	}
	
}