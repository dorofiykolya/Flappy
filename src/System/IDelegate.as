package System 
{
	
	/**
	 * ...
	 * @author dorofiy
	 */
	public interface IDelegate 
	{
		function Add(listener:Function/*, index:int = int.MAX_VALUE*/):void;
		function Remove(listener:Function):void;
	}
	
}