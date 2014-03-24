package System.Collections 
{
	import System.IDisposable;
	/**
	 * ...
	 * @author dorofiy
	 */
	public class ObjectPool implements IDisposable
	{
		private var _pool:Vector.<Object> = new Vector.<Object>();
		private var _createFunction:Function;
		/**
		 * 
		 * @param	functionCreate create current object, when pool lenght = 0. Example: function():string{return "";}
		 */
		public function ObjectPool(functionCreate:Function) 
		{
			if (functionCreate == null) {
				throw new ArgumentError("functionCreate");
			}
			_createFunction = functionCreate;
		}
		
		public function Put(value:Object):void {
			var i:int = _pool.indexOf(value);
			if (i == -1) {
				_pool.push(value);
			}
		}
		
		public function Get():Object {
			if (_pool.length == 0) return _createFunction();
			return _pool.pop();
		}
		
		public function Dispose():void {
			_pool = null;
			_createFunction = null;
		}
	}

}