package System.Signals 
{
	import flash.utils.Dictionary;
	import System.Delegate;
	import System.IDelegate;
	import System.IDisposable;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class DelegateDispatcher implements IDisposable 
	{
		
		private var collection:Dictionary = new Dictionary();
		private var disposed:Boolean;
		
		public function DelegateDispatcher() 
		{
			
		}
		
		public function Get(type:Object):IDelegate
		{
			var d:IDelegate = collection[type];
			if (d == null)
			{
				d = new Delegate();
				collection[type] = d;
			}
			return d;
		}
		
		public function Invoke(type:Object, ...params):void
		{
			var d:Delegate = collection[type];
			if (d == null)
			{
				return;
			}
			d.Invoke.apply(null, params);
		}
		
		public function RemoveAll():void
		{
			for each (var item:Delegate in collection) 
			{
				if (item)
				{
					item.RemoveAll();
				}
			}
			collection = new Dictionary();
		}
		
		public function Dispose():void
		{
			if (disposed)
			{
				return;
			}
			disposed = true;
			for each (var item:Delegate in collection) 
			{
				if (item)
				{
					item.Dispose();
				}
			}
			collection = null;
		}
		
	}

}