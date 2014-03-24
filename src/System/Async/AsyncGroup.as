package System.Async
{
	import System.Collections.IEnumerator;
	import System.Collections.List;
	import System.Delegate;
	import System.IDelegate;
	import System.IDisposable;
	
	/**
	 * ...
	 * @author dorofiy
	 */
	public class AsyncGroup implements IAsyncRunnable, IDisposable
	{
		private var _list:List = new List();
		private var _onComplete:Delegate = new Delegate();
		private var _onError:Delegate = new Delegate();
		private var _isCompleted:Boolean;
		
		public function AsyncGroup()
		{
			// TODO
		}
		
		public function get AsyncState():Object
		{
			return _list.ToVector();
		}
		public function get OnError():IDelegate
		{
			return _onError;
		}
		
		public function Add(async:IAsyncResult):void
		{
			_list.Add(async);
		}
		
		public function Run():void
		{
			var iterator:IEnumerator = _list.GetEnumerator();
			iterator.Reset();
			var current:IAsyncResult;
			while (iterator.MoveNext())
			{
				current = IAsyncResult(iterator.Current);
				current.OnError.Add(_onError.Invoke);
				if (current.IsCompleted == false)
				{
					current.OnComplete.Add(check);
				}
			}
			check();
		}
		
		private function check():void
		{
			var iterator:IEnumerator = _list.GetEnumerator();
			iterator.Reset();
			var current:IAsyncResult;
			while (iterator.MoveNext())
			{
				current = IAsyncResult(iterator.Current);
				current.OnError.Add(_onError.Invoke);
				if (current.IsCompleted == false)
				{
					return;
				}
			}
			if (_isCompleted == false)
			{
				_isCompleted = true;
				_onComplete.Invoke();
			}
		}
		
		public function Reset():void
		{
			_onComplete.RemoveAll();
			_onError.RemoveAll();
			_isCompleted = false;
			_list.Clear();
		}
		
		public function get OnComplete():IDelegate
		{
			return _onComplete;
		}
		
		public function get IsCompleted():Boolean
		{
			return _isCompleted;
		}
		
		public function Dispose():void
		{
			_list.Dispose();
			_onError.Dispose();
			_onComplete.Dispose();
			_list = null;
			_onComplete = null;
		}
	}

}