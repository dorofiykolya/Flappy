package System.Task
{
	import System.Async.IAsyncProgress;
	import System.Async.IAsyncResult;
	import System.Async.IAsyncRunnable;
	import System.Delegate;
	import System.IDelegate;
	import System.IDisposable;
	import System.system;
	/**
	 * ...
	 * @author dorofiy
	 */
	public class Task implements IDisposable
	{
		private var _queue:TaskQueue;
		private var _delay:uint;
		
		private var _currentProgress:int;
		private var _totalProgress:int;
		
		private var _run:IAsyncRunnable;
		
		private var _onProgress:IDelegate;
		
		private var _name:String;
		
		private var _description:String;
		private var _isDisposed:Boolean;
		
		public function Task(name:String, run:IAsyncRunnable, description:String = "")
		{
			_name = name;
			_description = description;
			_run = run;
			if (_run is IAsyncProgress) {
				_onProgress = IAsyncProgress(_run).OnProgress;
			}else {
				_onProgress = new Delegate();
			}
		}
		
		internal function Run():void {
			_run.Run();
		}
		
		public function get OnComplete():IDelegate
		{
			return _run.OnComplete;
		}
		
		public function get OnError():IDelegate
		{
			return _run.OnError;
		}
		
		public function get OnProgress():IDelegate
		{
			return _onProgress;
		}
		
		public function get State():IAsyncResult
		{
			return _run;
		}	
		
		public function get Delay():uint
		{
			return _delay;
		}
		
		public function set Delay(value:uint):void
		{
			_delay = value;
		}
		
		public function get Queue():TaskQueue
		{
			return _queue;
		}
		
		system function set Queue(value:TaskQueue):void
		{
			_queue = value;
		}
		
		public function get Name():String 
		{
			return _name;
		}
		
		public function get Description():String 
		{
			return _description;
		}
		
		public function get IsDisposed():Boolean {
			return _isDisposed;
		}
		
		public function Dispose():void
		{
			IDisposable(this._onProgress).Dispose();
			IDisposable(this._queue).Dispose();
			IDisposable(this._run).Dispose();
			_onProgress = null;
			_queue = null;
			_run = null;
			_isDisposed = true;
		}
		
	}

}