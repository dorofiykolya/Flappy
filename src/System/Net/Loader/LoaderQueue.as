package System.Net.Loader
{
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.system.LoaderContext;
	import System.Async.IAsyncResult;
	import System.Collections.List;
	import System.Delegate;
	import System.Diagnostics.Debug;
	import System.Exception.ObjectDisposedException;
	import System.IDisposable;
	import System.Text.StringUtil;
	
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author dorofiy
	 */
	[Event(name = 'change', type = 'flash.events.Event')]
	[Event(name = 'complete', type = 'flash.events.Event')]
	[Event(name = 'open', type = 'flash.events.Event')]
	[Event(name = 'ioError', type = 'flash.events.IOErrorEvent')]
	[Event(name = 'progress', type = 'flash.events.ProgressEvent')]
	[Event(name = 'select', type = 'flash.events.Event')]
	[Event(name = 'securityError', type = 'flash.events.SecurityErrorEvent')] 
	
	public class LoaderQueue extends EventDispatcher implements IDisposable
	{
		private var queue:List = new List();
		private var queueUri:List = new List();
		private var current:LoaderItem;
		private var loader:Loader = new Loader();
		private var urlLoader:URLLoader = new URLLoader();
		private var total:int;
		private var lastResult:*;
		
		private var bytesTotal:Number = 0;
		private var bytesLoaded:Number = 0;
		private var totalBytesLoaded:Number = 0;
		
		private var disposed:Boolean;
		
		private var completed:Boolean;
		
		private var _loaderType:Boolean;
		
		public function LoaderQueue()
		{
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoaderComplete);
			loader.contentLoaderInfo.addEventListener(Event.INIT, onLoaderInit);
			loader.contentLoaderInfo.addEventListener(Event.OPEN, onLoaderOpen);
			loader.contentLoaderInfo.addEventListener(Event.UNLOAD, onLoaderUnload);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onLoaderIOError);
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onLoaderProgressEvent);
			
			urlLoader.addEventListener(Event.COMPLETE, onLoaderComplete);
			urlLoader.addEventListener(Event.OPEN, onLoaderOpen);
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR, onLoaderIOError);
			urlLoader.addEventListener(ProgressEvent.PROGRESS, onLoaderProgressEvent);
			urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
		}
		
		private function onSecurityError(e:SecurityErrorEvent):void
		{
			if (current)
			{
				current.result = e;
				current.isCompleted = true;
				//Delegate(current.OnIOError).Invoke(e);
				Delegate(current.OnError).Invoke(e);
				current.observersIOError(e);
			}
			queue.RemoveFirst();
			queueUri.RemoveFirst();
			if (hasEventListener(SecurityErrorEvent.SECURITY_ERROR))
			{
				dispatchEvent(e);
			}
		}
		
		public function get IsCompleted():Boolean
		{
			return completed;
		}
		
		private function onLoaderProgressEvent(e:ProgressEvent):void
		{
			bytesLoaded = e.bytesLoaded;
			bytesTotal = e.bytesTotal;
			totalBytesLoaded += e.bytesLoaded;
			if (current)
			{
				current.current = e.bytesLoaded;
				current.total = e.bytesTotal;
				Delegate(current.OnProgress).Invoke();
				current.observersProgress();
			}
			if (hasEventListener(ProgressEvent.PROGRESS))
			{
				dispatchEvent(e);
			}
		}
		
		private function onLoaderIOError(e:IOErrorEvent):void
		{
			if (current)
			{
				Debug.Alert(e, true);
				current.result = e;
				current.isCompleted = true;
				//Delegate(current.OnIOError).Invoke();
				Delegate(current.OnError).Invoke();
				current.observersIOError();
			}
			queue.RemoveFirst();
			queueUri.RemoveFirst();
			if (hasEventListener(IOErrorEvent.IO_ERROR))
			{
				dispatchEvent(e);
			}
		}
		
		private function onLoaderUnload(e:Event):void
		{
			if (hasEventListener(Event.UNLOAD))
			{
				dispatchEvent(e);
			}
		}
		
		private function onLoaderOpen(e:Event):void
		{
			if (current)
			{
				Delegate(current.OnOpen).Invoke();
				current.observersOpen();
			}
			if (hasEventListener(Event.OPEN))
			{
				dispatchEvent(e);
			}
		}
		
		private function onLoaderInit(e:Event):void
		{
			if (current)
			{
				Delegate(current.OnInit).Invoke();
				current.observersInit();
			}
			if (hasEventListener(Event.INIT))
			{
				dispatchEvent(e);
			}
		}
		
		private function onLoaderComplete(event:Event):void
		{
			if (_loaderType)
			{
				try 
				{
					lastResult = loader.content;
				}
				catch (e:SecurityError)
				{
					var resultMessage:String = StringUtil.Format("[SecurityError] name:{0}, message:{1}, errorID:{2}, getStackTrace:{3}", e.name, e.message, e.errorID, e.getStackTrace());
					lastResult = new Error( resultMessage );
					if (hasEventListener(SecurityErrorEvent.SECURITY_ERROR))
					{
						Debug.Bug("[System.Net.Loader.LoaderQueue][onLoaderComplete] " + resultMessage);
						dispatchEvent(new SecurityErrorEvent(SecurityErrorEvent.SECURITY_ERROR, false, false, resultMessage, e.errorID));
					}
				}
			}
			else
			{
				lastResult = urlLoader.data;
			}
			var current:LoaderItem = queue.Get(0) as LoaderItem;
			current.result = lastResult;
			current.isCompleted = true;
			Delegate(current.OnComplete).Invoke();
			current.observersComplete(lastResult);
			queue.RemoveFirst();
			queueUri.RemoveFirst();
			total--;
			if (hasEventListener(Event.CHANGE))
			{
				dispatchEvent(new Event(Event.CHANGE));
			}
			loadNext();
		}
		
		protected function loadNext():void
		{
			if (queue.Count == 0)
			{
				current = null;
				completed = true;
				if (hasEventListener(Event.COMPLETE))
				{
					dispatchEvent(new Event(Event.COMPLETE));
				}
				return;
			}
			current = queue.Get(0) as LoaderItem;
			if (current.IsCompleted)
			{
				Delegate(current.OnComplete).Invoke();
				queue.RemoveFirst();
				queueUri.RemoveFirst();
				total--;
				if (hasEventListener(Event.CHANGE))
				{
					dispatchEvent(new Event(Event.CHANGE));
				}
				loadNext();
				return;
			}
			if (current)
			{
				switch (current.type)
				{
					case LoaderType.DISPLAYOBJECT: 
						_loaderType = true;
						loader.unload();
						if (hasEventListener(Event.SELECT))
						{
							dispatchEvent(new Event(Event.SELECT));
						}
						loader.load(current.URL, current.Context);
						break;
					case LoaderType.TEXT: 
					case LoaderType.BINARY: 
					case LoaderType.VARIABLES: 
						_loaderType = false;
						urlLoader.dataFormat = current.type.Value;
						if (hasEventListener(Event.SELECT))
						{
							dispatchEvent(new Event(Event.SELECT));
						}
						urlLoader.load(current.URL);
						break;
					default: 
						throw new ArgumentError("unknown type: " + current.type);
				}
			}
		}
		
		public function Add(item:LoaderItem, useObservers:Boolean = false):ILoaderResult
		{
			if (item == null)
			{
				throw new ArgumentError("item == null");
				return null;
			}
			if (disposed)
			{
				throw new ObjectDisposedException();
				return null;
			}
			
			var uri:String = item.URI;
			if (useObservers)
			{
				var i:int = queueUri.IndexOf(uri);
				if (i != -1)
				{
					LoaderItem(queue.Get(i)).addObserver(item);
					return item;
				}
			}
			queueUri.Add(uri);
			queue.Add(item);
			return item;
		}
		
		public function Remove(item:LoaderItem):ILoaderResult
		{
			if (disposed)
				throw new ObjectDisposedException();
			if (queue.Contains(item))
			{
				if (current == item)
				{
					throw new QueueError();
				}
				else
				{
					queueUri.Remove(item.URI);
					queue.Remove(item);
				}
				
				return item;
			}
			return null;
		}
		
		public function get Count():int
		{
			if (disposed)
				throw new ObjectDisposedException();
			return queue.Count;
		}
		
		public function get Current():LoaderItem
		{
			if (disposed)
				throw new ObjectDisposedException();
			return current;
		}
		
		public function Open():void
		{
			if (disposed)
				throw new ObjectDisposedException();
			completed = false;
			total = queue.Count;
			totalBytesLoaded = 0;
			if (hasEventListener(Event.OPEN))
			{
				dispatchEvent(new Event(Event.OPEN));
			}
			loadNext();
		}
		
		public function Close():void
		{
			if (disposed)
				throw new ObjectDisposedException();
			loader.close();
		}
		
		public function CloseAndLoadNext():void
		{
			if (disposed)
				throw new ObjectDisposedException();
			loader.close();
			queue.RemoveFirst();
			queueUri.RemoveFirst();
			loadNext();
		}
		
		public function get BytesLoadedTotal():int
		{
			return totalBytesLoaded;
		}
		
		public function get BytesLoaded():int
		{
			return bytesLoaded;
		}
		
		public function get BytesTotal():int
		{
			return bytesTotal;
		}
		
		public function Dispose():void
		{
			if (disposed == false)
			{
				loader.unloadAndStop();
				loader = null;
				current = null;
				queue.Dispose();
				queueUri.Dispose();
			}
			disposed = true;
		}
	}

}