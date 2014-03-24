package System.Net.Loader 
{
	import flash.events.Event;
	import System.Delegate;
	import System.IDelegate;
	import System.IDisposable;
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class LoaderThread implements IDisposable
	{
		private var _threads:int;
		private var _loaders:Vector.<LoaderQueue> = new Vector.<LoaderQueue>();
		private var _onComplete:Delegate = new Delegate();
		
		public function LoaderThread(threads:int = 1) 
		{
			if (threads < 1)
			{
				threads = 1;
			}
			_threads = threads;
			
			var loader:LoaderQueue;
			for (var i:int = 0; i < _threads; i++) 
			{
				loader = new LoaderQueue();
				loader.addEventListener(Event.COMPLETE, onComplete);
				_loaders[i] = loader;
			}
		}
		
		private function onComplete(e:Event):void 
		{
			var loader:LoaderQueue = e.currentTarget as LoaderQueue;
			for (var i:int = 0; i < _threads; i++) 
			{
				if (_loaders[i].IsCompleted == false)
				{
					return;
				}
			}
			_onComplete.Invoke();
		}
		
		public function get Threads():int
		{
			return _threads;
		}
		
		public function Load(item:LoaderItem, useObservers:Boolean = false):ILoaderResult
		{
			_loaders.sort(sortLoaders);
			var loader:LoaderQueue = _loaders[0];
			var result:ILoaderResult = loader.Add(item, useObservers);
			if (loader.IsCompleted || loader.Current == null)
			{
				loader.Open();
			}
			return result;
		}
		
		public function get BytesLoaded():int 
		{
			var result:int;
			for (var i:int = 0; i < _threads; i++) 
			{
				result += _loaders[i].BytesLoaded;
			}
			return result;
		}
		
		public function get BytesLoadedTotal():int 
		{
			var result:int;
			for (var i:int = 0; i < _threads; i++) 
			{
				result += _loaders[i].BytesLoadedTotal;
			}
			return result;
		}
		
		public function get BytesTotal():int
		{
			var result:int;
			for (var i:int = 0; i < _threads; i++) 
			{
				result += _loaders[i].BytesTotal;
			}
			return result;
		}
		
		public function get Count():int
		{
			var result:int;
			for (var i:int = 0; i < _threads; i++) 
			{
				result += _loaders[i].Count;
			}
			return result;
		}
		
		private function sortLoaders(i1:LoaderQueue, i2:LoaderQueue):int
		{
			if (i1.Count > i2.Count) 
			{
				return 1;
			}
			if (i1.Count < i2.Count) 
			{
				return -1;
			}
			return 0;
		}
		
		public function Get(index:int):LoaderQueue
		{
			return _loaders[index];
		}
		
		public function get OnComplete():IDelegate
		{
			return _onComplete;
		}
		
		public function Dispose():void
		{
			for (var i:int = 0; i < _loaders.length; i++) 
			{
				_loaders[i].Dispose();
			}
			_loaders.length = 0;
			_onComplete.Dispose();
		}
		
	}

}