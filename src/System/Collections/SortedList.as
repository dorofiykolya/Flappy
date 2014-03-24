package System.Collections 
{
	import System.IDisposable;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class SortedList extends List
	{
		private var _sort:Function;
		public function SortedList(sort:Function/*(v1:Object, v2:Object):int*/, strictMode:Boolean=false, fixed:Boolean=false, maxCount:int=32) 
		{
			super(strictMode, fixed, maxCount);
			_sort = sort;
		}
		override public function Add(value:Object):Boolean
		{
			super.Add(value);
			if (_sort != null) {
				Sort(_sort);
			}
		}
		
		public function get SortFunction():Function /*(v1:Object, v2:Object):int*/
		{
			return _sort;
		}
		
		public function set SortFunction(value:Function/*(v1:Object, v2:Object):int*/):void 
		{
			if (_sort === value) return;
			_sort = value;
			if (_sort != null) {
				Sort(_sort);
			}
		}
		
		public override function Dispose():void {
			_sort = null;
			super.Dispose();
		}
    }

}