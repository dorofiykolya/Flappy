package System.Pools
{
	import flash.utils.getQualifiedClassName;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class PoolFactoryItem implements IPoolFactory
	{
		protected var disposed:Boolean;
		
		public function PoolFactoryItem()
		{
			
		}
		
		public function Reinitialize():IPoolFactory
		{
			disposed = false;
			return this;
		}
		
		public function Dispose():void
		{
			if (disposed)
			{
				return;
			}
			disposed = true;
			PoolFactory.Dispose(this);
		}
	
	}

}