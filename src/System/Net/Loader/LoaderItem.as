package System.Net.Loader
{
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import System.Async.IAsyncResult;
	import System.Delegate;
	import System.Exception.ObjectDisposedException;
	import System.IDelegate;
	import System.system;
	
	/**
	 * ...
	 * @author dorofiy
	 */
	public class LoaderItem implements ILoaderResult
	{
		
		private static var _pool:Vector.<LoaderItem> = new Vector.<LoaderItem>();
		
		public static function Create(uri:String, type:LoaderType, context:LoaderContext = null, result:Object = null):LoaderItem
		{
			if (_pool.length > 0)
				_pool.pop().initialize(uri, type, context, result);
			return new LoaderItem(uri, type, context, result);
		}
		
		protected var _onIOError:Delegate = new Delegate();
		protected var _onProgress:Delegate = new Delegate();
		protected var _onOpen:Delegate = new Delegate();
		protected var _onInit:Delegate = new Delegate();
		protected var _onComplete:Delegate = new Delegate();
		
		internal var current:int;
		internal var total:int;
		internal var result:Object;
		internal var isCompleted:Boolean;
		internal var type:LoaderType;
		internal var observers:Vector.<LoaderItem>;
		
		internal var disposed:Boolean;
		
		protected var _url:URLRequest;
		protected var _uri:String;
		protected var _loaderContext:LoaderContext;
		
		public var id:int;
		
		public function LoaderItem(uri:String, type:LoaderType, context:LoaderContext = null, result:Object = null)
		{
			if (result == null)
			{
				switch (type)
				{
					case LoaderType.DISPLAYOBJECT: 
					case LoaderType.TEXT: 
					case LoaderType.BINARY: 
					case LoaderType.VARIABLES: 
						break;
					default: 
						throw new ArgumentError("unknown type: " + type);
				}
			}
			initialize(uri, type, context, result);
		}
		
		protected function initialize(uri:String, type:LoaderType, context:LoaderContext = null, result:Object = null):LoaderItem
		{
			disposed = false;
			_uri = uri;
			this.type = type;
			_loaderContext = context;
			this._url = new URLRequest(uri);
			if (result)
			{
				this.result = result;
				isCompleted = true;
			}
			return this;
		}
		
		protected function setResult(value:Object):LoaderItem
		{
			result = value;
			isCompleted = true;
			return this;
		}
		
		protected function removeResult():LoaderItem
		{
			result = null;
			isCompleted = false;
			return this;
		}
		
		internal function addObserver(item:LoaderItem):void
		{
			if (observers == null)
				observers = new Vector.<LoaderItem>();
			var i:int = observers.indexOf(item);
			if (i == -1)
			{
				observers.push(item);
			}
		}
		
		internal function observersComplete(result:Object, ... params):void
		{
			if (observers == null)
				return;
			var current:LoaderItem;
			for (var i:int = 0; i < observers.length; i++)
			{
				current = observers[i];
				if (current)
				{
					current.result = result;
					current.isCompleted = true
				}
				current._onComplete.Invoke.apply(null, params);
			}
		}
		
		internal function observersIOError(... params):void
		{
			if (observers == null)
				return;
			for (var i:int = 0; i < observers.length; i++)
			{
				observers[i]._onIOError.Invoke.apply(null, params);
			}
		}
		
		internal function observersInit(... params):void
		{
			if (observers == null)
				return;
			for (var i:int = 0; i < observers.length; i++)
			{
				observers[i]._onInit.Invoke.apply(null, params);
			}
		}
		
		internal function observersProgress(... params):void
		{
			if (observers == null)
				return;
			for (var i:int = 0; i < observers.length; i++)
			{
				observers[i]._onProgress.Invoke.apply(null, params);
			}
		}
		
		internal function observersOpen(... params):void
		{
			if (observers == null)
				return;
			for (var i:int = 0; i < observers.length; i++)
			{
				observers[i]._onOpen.Invoke.apply(null, params);
			}
		}
		
		public function get URI():String
		{
			return _uri;
		}
		
		public function get URL():URLRequest
		{
			return _url;
		}
		
		public function get Current():int
		{
			if (disposed)
				throw new ObjectDisposedException();
			return current;
		}
		
		public function get Total():int
		{
			if (disposed)
				throw new ObjectDisposedException();
			return total;
		}
		
		public function get OnIOError():IDelegate
		{
			if (disposed)
				throw new ObjectDisposedException();
			return _onIOError;
		}
		
		public function get OnProgress():IDelegate
		{
			if (disposed)
				throw new ObjectDisposedException();
			return _onProgress;
		}
		
		public function get OnOpen():IDelegate
		{
			if (disposed)
				throw new ObjectDisposedException();
			return _onOpen;
		}
		
		public function get OnInit():IDelegate
		{
			if (disposed)
				throw new ObjectDisposedException();
			return _onInit;
		}
		
		public function get AsyncState():Object
		{
			if (disposed)
				throw new ObjectDisposedException();
			return result;
		}
		
		public function get OnError():IDelegate
		{
			if (disposed)
				throw new ObjectDisposedException();
			return _onIOError;
		}
		
		public function get IsCompleted():Boolean
		{
			if (disposed)
				throw new ObjectDisposedException();
			return isCompleted;
		}
		
		public function get OnComplete():IDelegate
		{
			if (disposed)
				throw new ObjectDisposedException();
			return _onComplete;
		}
		
		public function get Context():LoaderContext
		{
			return _loaderContext;
		}
		
		public function Dispose():void
		{
			if (disposed == false)
			{
				_onComplete.RemoveAll();
				_onInit.RemoveAll();
				_onIOError.RemoveAll();
				_onOpen.RemoveAll();
				_onProgress.RemoveAll();
				result = null;
				if (observers)
				{
					for (var i:int = 0; i < observers.length; i++)
					{
						observers[i].Dispose();
					}
				}
				_pool.push(this);
			}
			disposed = true;
		}
	
	}

}