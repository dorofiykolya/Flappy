package System
{
	import System.Exception.ObjectDisposedException;
	
	/**
	 * ...
	 * @author dorofiy
	 */
	public class Delegate implements IDisposable, ICloneable, IDelegate
	{
		
		public static function Wrap(handler:Function, ... args):Function
		{
			return function(... innerArgs):void
			{
				var handlerArgs:Array = [];
				if (innerArgs != null)
				{
					handlerArgs = innerArgs;
				}
				if (args != null)
				{
					handlerArgs = handlerArgs.concat(args);
				}
				handler.apply(this, handlerArgs);
			};
		}
		
		private var list:Vector.<Function>;
		private var stoped:Boolean;
		protected var count:int;
		
		public function Delegate(list:Vector.<Function> = null)
		{
			if (list)
			{
				this.list = list;
				count = 0;
				for each (var item:Function in list) 
				{
					if (item != null)
					{
						count++;
					}
				}
			}
			else
			{
				this.list = new Vector.<Function>();
			}
		}
		
		public function Add(listener:Function):void
		{
			if (listener == null)
			{
				throw new ArgumentError("listener is null");
			}
			if (list == null)
			{
				throw new ObjectDisposedException("Delegate was disposed");
			}
			
			var index:int = list.indexOf(listener);
			if (index == -1)
			{
				list[list.length] = listener;
				count++;
			}
			else
			{
				if (count == 1)
				{
					return;
				}
				list[index] = null;
				list[list.length] = listener;
			}
		}
		
		public function Has(listener:Function):Boolean
		{
			if (listener == null)
			{
				throw new ArgumentError("listener is null");
			}
			if (list == null)
			{
				throw new ObjectDisposedException("Delegate was disposed");
			}
			return list.indexOf(listener) != -1;
		}
		
		public function Remove(listener:Function):void
		{
			if (listener == null)
			{
				throw new ArgumentError("listener is null");
			}
			if (list == null)
			{
				throw new ObjectDisposedException("Delegate was disposed");
			}
			var i:int = list.indexOf(listener);
			if (i == -1)
			{
				return;
			}
			list[i] = null;
			count--;
		}
		
		public function RemoveAll():void
		{
			if (list == null)
			{
				throw new ObjectDisposedException("Delegate was disposed");
			}
			list.length = 0;
			count = 0;
		}
		
		public function Invoke(... params):void
		{
			if (list == null)
			{
				throw new ObjectDisposedException("Delegate was disposed");
			}
			var len:int = list.length;
			if (len == 0)
			{
				stoped = false;
				return;
			}
			var current:Function;
			var index:int;
			
			for (var i:int = 0; i < len; i++)
			{
				if (count <= 0 || stoped)
				{
					stoped = false;
					return;
				}
				current = list[i];
				if (current as Function)
				{
					if (index != i)
					{
						list[index] = current;
						list[i] = null;
					}
					current.apply(null, params);
					index++;
				}
			}
			if (index != i)
			{
				len = list.length; // count might have changed!
				while (i < len)
				{
					list[index++] = list[i++];
				}
				
				list.length = index;
			}
			stoped = false;
		}
		
		public function Stop():void
		{
			if (list == null)
			{
				throw new ObjectDisposedException("Delegate was disposed");
			}
			stoped = true;
		}
		
		public function get Count():int
		{
			if (list == null)
			{
				throw new ObjectDisposedException("Delegate was disposed");
			}
			return count;
		}
		
		public function Dispose():void
		{
			list = null;
		}
		
		public function Clone():Object
		{
			if (list == null)
			{
				throw new ObjectDisposedException("Delegate was disposed");
			}
			return new Delegate(list.slice());
		}
	
	}

}