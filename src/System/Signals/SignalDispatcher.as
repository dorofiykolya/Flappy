package System.Signals
{
	import flash.utils.Dictionary;
	import System.IDisposable;
	
	/**
	 * ...
	 * @author dorofiy
	 */
	public class SignalDispatcher implements IDisposable
	{
		private var data:Object = { };
		
		public function SignalDispatcher()
		{
			
		}
		
		public function Dispose():void
		{
			data = null;
		}
		
		public function RemoveAll():void
		{
			data = {};
		}
		
		public function AddListener(type:String, listener:Function):void
		{
			if (data == null)
			{
				data = {};
			}
			var list:Vector.<Function> = data[type];
			if (list == null)
			{
				list = new Vector.<Function>();
				data[type] = list;
			}
			var i:int = list.indexOf(listener);
			if (i == -1)
			{
				list.push(listener);
			}
		}
		
		public function RemoveListener(type:String, listener:Function):void
		{
			if (data == null)
			{
				data = {};
			}
			var v:Vector.<Function> = data[type];
			if (v == null)
			{
				return;
			}
			var i:int = v.indexOf(listener);
			if (i != -1)
			{
				v.splice(i, 1);
				if (v.length == 0)
				{
					delete data[type];
				}
			}
		}
		
		public function Invoke(type:String, ... params):void
		{
			if (data == null)
			{
				data = {};
			}
			var v:Vector.<Function> = data[type];
			if (v == null)
			{
				return;
			}
			for each (var f:Function in v)
			{
				f.apply(null, params);
			}
		}
		
		public function HasListener(type:String):Boolean
		{
			if (data == null)
			{
				data = {};
			}
			return data[type] != undefined;
		}
	
	}

}