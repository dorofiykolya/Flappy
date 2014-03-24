package System.Application.Managers
{
	import System.Async.IAsyncResult;
	import System.IDelegate;
	import System.Task.Task;
	import System.Task.TaskQueue;
	
	/**
	 * ...
	 * @author dorofiy
	 */
	public class TaskManager
	{
		private var _taskQueue:TaskQueue = new TaskQueue();
		private var _autoRun:Boolean = true;
		
		public function TaskManager()
		{
			_taskQueue.OnComplete.Add(function():void
				{
					_taskQueue.Reset();
				});
		}
		
		public function get Current():Task
		{
			return _taskQueue.Current;
		}
		
		public function get OnComplete():IDelegate
		{
			return _taskQueue.OnComplete;
		}
		
		public function get OnChange():IDelegate
		{
			return _taskQueue.OnChange;
		}
		
		public function get OnError():IDelegate
		{
			return _taskQueue.OnError;
		}
		
		public function get OnCurrentProgress():IDelegate
		{
			return _taskQueue.OnCurrentProgress;
		}
		
		public function get IsStarted():Boolean
		{
			return _taskQueue.IsStarted;
		}
		
		public function get IsWait():Boolean
		{
			return _taskQueue.IsWait;
		}
		
		public function Add(task:Task):IAsyncResult
		{
			var result:IAsyncResult = _taskQueue.Add(task);
			if (_autoRun && _taskQueue.IsWait == false)
			{
				_taskQueue.Run();
			}
			return result;
		}
		
		public function Run():void
		{
			_taskQueue.Run();
		}
		
		public function Wait():void
		{
			_taskQueue.Wait();
		}
		
		public function get AutoRun():Boolean
		{
			return _autoRun;
		}
		
		public function set AutoRun(value:Boolean):void
		{
			_autoRun = value;
		}
	
	}

}