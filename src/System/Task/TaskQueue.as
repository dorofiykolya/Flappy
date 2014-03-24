package System.Task
{
	import System.Async.AsyncCall;
	import System.Async.DelayTimeAction;
	import System.Async.IAsyncProgress;
	import System.Async.IAsyncResult;
	import System.Collections.List;
	import System.Delegate;
	import System.Exception.InvokeException;
	import System.IDelegate;
	import System.IDisposable;
	import System.system;
	
	/**
	 * ...
	 * @author dorofiy
	 */
	public class TaskQueue implements IDisposable
	{
		
		private var _list:List = new List();
		private var _isStarted:Boolean;
		private var _onComplete:Delegate = new Delegate();
		private var _onChange:Delegate = new Delegate;
		private var _onError:Delegate = new Delegate();
		private var _currentProgress:Delegate = new Delegate();
		private var _currentAsyncProgress:IAsyncProgress;
		private var _current:Task;
		private var _position:int;
		private var _isWait:Boolean;
		
		public function TaskQueue()
		{
		
		}
		
		public function get OnComplete():IDelegate
		{
			return _onComplete;
		}
		
		public function get OnChange():IDelegate
		{
			return _onChange;
		}
		
		/**
		 * function(current:int, total:int):void {}
		 */
		public function get OnCurrentProgress():IDelegate
		{
			return _currentProgress;
		}
		
		public function get OnError():IDelegate
		{
			return _onError;
		}
		
		public function Add(task:Task, index:int = int.MAX_VALUE):IAsyncResult
		{
			if (_list.Contains(task))
			{
				if (_isStarted && task == _current)
				{
					throw new InvokeException();
					return null;
				}
			}
			task.system::Queue = this;
			return _list.Insert(task, index).State as IAsyncResult;
		}
		
		public function Remove(task:Task):IAsyncResult
		{
			if (_isStarted && _current == task)
			{
				throw new InvokeException();
				return null;
			}
			return _list.Remove(task).State as IAsyncResult;
		}
		
		public function RemoveAt(index:int):IAsyncResult
		{
			if (_isStarted && _current == _list.Get(index) as Task)
			{
				throw new InvokeException();
				return null;
			}
			return _list.RemoveAt(index).State as IAsyncResult;
		}
		
		public function Swap(task1:Task, task2:Task):void
		{
			if (_isStarted)
			{
				if (task1 == _current || task2 == _current)
				{
					throw new InvokeException();
					return;
				}
			}
			_list.SwapObject(task1, task2);
		}
		
		public function SwapIndex(index1:int, index2:int):void
		{
			if (_isStarted)
			{
				throw new InvokeException();
				return;
			}
			_list.SwapIndex(index1, index2);
		}
		
		public function get Current():Task
		{
			return _current;
		}
		
		public function Run(delay:int = 0):void
		{
			if (delay <= 0)
			{
				onRun(false);
			}
			else
			{
				new DelayTimeAction(onRun, delay, false);
			}
		}
		
		private function onRun(inner:Boolean):void
		{
			if (_isStarted && inner == false)
				return;
			if (_list.Count == 0)
			{
				Delegate(_onComplete).Invoke();
				_isStarted = false;
				return;
			}
			_isStarted = true;
			_isWait = false;
			_current = _list.Get(_position) as Task;
			if (_current.IsDisposed)
			{
				onCompleteHandler();
				return;
			}
			_current.OnComplete.Add(onCompleteHandler);
			_current.OnError.Add(onErrorHandler);
			_current.OnProgress.Add(onProgressHandler);
			if (_current.Delay > 0)
			{
				new System.Async.DelayTimeAction(_current.Run, _current.Delay);
			}
			else
			{
				_current.Run();
			}
		}
		
		private function onProgressHandler():void
		{
			_currentAsyncProgress = _current.State as IAsyncProgress;
			if (_currentAsyncProgress)
			{
				_currentProgress.Invoke(_currentAsyncProgress.Current, _currentAsyncProgress.Total);
			}
			else
			{
				_currentProgress.Invoke(0, 1);
			}
		}
		
		private function onErrorHandler(e:Object = null):void
		{
			_onError.Invoke();
			onCompleteHandler();
		}
		
		private function onCompleteHandler():void
		{
			if (_current)
			{
				if (_current.OnComplete)
				{
					Delegate(_current.OnComplete).Remove(onCompleteHandler);
				}
				if (_current.OnError)
				{
					Delegate(_current.OnError).Remove(onErrorHandler);
				}
				if (_current.OnProgress)
				{
					Delegate(_current.OnProgress).Remove(onProgressHandler);
				}
			}
			_position++;
			_onChange.Invoke();
			if (_position >= _list.Count)
			{
				_onComplete.Invoke();
				Stop();
				_current = null;
				return;
			}
			if (_isWait)
				return;
			onRun(true);
		}
		
		public function Wait():void
		{
			_isWait = true;
		}
		
		public function Stop():void
		{
			_position = 0;
			_isStarted = false;
			_isWait = false;
		}
		
		public function get Position():int
		{
			return _position;
		}
		
		public function get IsStarted():Boolean
		{
			return _isStarted;
		}
		
		public function get IsWait():Boolean
		{
			return _isWait;
		}
		
		public function get Count():int
		{
			return _list.Count;
		}
		
		public function Reset():void
		{
			_list.Clear();
			_position = 0;
			_current = null;
			_isStarted = false;
			_isWait = false;
			_onComplete.RemoveAll();
			_onChange.RemoveAll();
			_onError.RemoveAll();
			_currentProgress.RemoveAll();
			_currentAsyncProgress = null;
		}
		
		public function Dispose():void
		{
			_list.Dispose();
			_isStarted = false;
			_onComplete.Dispose();
			_onChange.Dispose();
			_onError.Dispose();
			_currentProgress.Dispose();
			_currentAsyncProgress = null;
			_current = null;
			_position = 0;
			_isWait = false;
			_onChange = null;
			_onComplete = null;
			_onError = null;
			_currentProgress = null;
		}
	}

}