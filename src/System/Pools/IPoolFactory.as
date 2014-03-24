package System.Pools 
{
	import System.IDisposable;
	
	/**
	 * ...
	 * @author dorofiy
	 */
	public interface IPoolFactory extends IDisposable
	{
		function Reinitialize():IPoolFactory;
	}
	
}