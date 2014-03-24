package System.Async
{
	import System.Delegate;
	import System.IDelegate;
	import System.IDisposable;
	
	/**
	 * ...
	 * @author dorofiy
	 */
	public class AsyncStackInvoker implements IDisposable
	{
		private var _onComplete:Delegate = new Delegate();
		private var _stack:Vector.<StackItem> = new Vector.<StackItem>();
		
		public function AsyncStackInvoker()
		{
		
		}
		
		public function get OnComplete():IDelegate
		{
			return _onComplete;
		}
		
		public function Dispose():void
		{
			_onComplete.Dispose();
		}
		
		public function get Count():int
		{
			return _stack.length;
		}
		
		public function Add(handler:Function, ... params):void
		{
			_stack.push(new StackItem(handler, params));
		}
		
		public function Invoke(... params):void
		{
			if (_stack.length == 0)
			{
				_onComplete.Invoke();
				return;
			}
			var cur:StackItem = _stack.pop();
			cur.handler.apply(null, cur.args);
			if (_stack.length == 0)
			{
				_onComplete.Invoke();
			}
		}
		
		public function Reset():void
		{
			_stack = new Vector.<StackItem>();
		}
	}
}

class StackItem
{
	public var handler:Function;
	public var args:Array;
	
	public function StackItem(handler:Function, args:Array)
	{
		this.handler = handler;
		this.args = args;
	}
}