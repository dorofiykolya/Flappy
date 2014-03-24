package System.Pools
{
	import System.IDisposable;
	
	/**
	 * ...
	 * @author dorofiy
	 */
	public class Pool implements IDisposable
	{
		/** Maximum size of the pool. */
		private var _maxSize:int;
		private var _minSize:int;
		
		/** Current size of the pool (list). */
		private var _size:int = 0;
		
		/** Function to be called when the object is to be created. */
		private var _create:Function;
		
		/** Function to be called when the object is to be cleaned. */
		private var _clean:Function;
		
		/** Checked in objects count. */
		private var _length:int = 0;
		
		/** Objects in the pool. */
		private var _list:Vector.<Object> = new Vector.<Object>();
		
		/** If this pool has been disposed. */
		private var _disposed:Boolean = false;
		
		/**
		 * @param create This is the Function which should return a new Object to populate the Object pool
		 * @param clean This Function will recieve the Object as a param and is used for cleaning the Object ready for reuse
		 * @param minSize The initial size of the pool on Pool construction
		 * @param maxSize The maximum possible size for the Pool
		 *
		 */
		public function Pool(create:Function/*():Object*/, clean:Function = null, minSize:int = 1, maxSize:int = 1)
		{
			if (create == null || minSize < 0 || maxSize < 0)
			{
				throw new ArgumentError("cretae function should not be null. minimum value should not be less than zero. maximum value should not be less than zero");
			}
			
			_create = create;
			_clean = clean;
			_minSize = minSize;
			_maxSize = maxSize;
			
			for (var i:int = 0; i < minSize; i++)
				add();
		}
		
		private function add():void
		{
			_list[_length++] = create();
			_size++;
		}
		
		/**
		 * Sets the minimum size for the Pool.
		 *
		 */
		public function set Min(num:int):void
		{
			_minSize = num;
			if (_minSize > _maxSize)
				_maxSize = _minSize;
			if (_maxSize < _list.length)
				_list.splice(_maxSize, 1);
			_size = _list.length;
		}
		
		/**
		 * Gets the minimum size for the Pool.
		 *
		 */
		public function get Min():int
		{
			return _minSize;
		}
		
		/**
		 * Sets the maximum size for the Pool.
		 *
		 */
		public function set Max(num:int):void
		{
			_maxSize = num;
			if (_maxSize < _list.length)
				_list.splice(_maxSize, 1);
			_size = _list.length;
			if (_maxSize < _minSize)
				_minSize = _maxSize;
		}
		
		/**
		 * Returns the maximum size for the Pool.
		 *
		 */
		public function get Max():int
		{
			return _maxSize;
		}
		
		/**
		 * Checks the Object back into the Pool.
		 * @param item The Object you wish to check back into the Object Pool.
		 *
		 */
		public function CheckIn(instance:Object):void
		{
			if (clean != null)
				clean(instance);
			_list[_length++] = instance;
		}
		
		/**
		 * Checks out an Object from the pool.
		 *
		 */
		public function CheckOut():Object
		{
			if (_length == 0)
			{
				if (_size < maxSize)
				{
					_size++;
					return create();
				}
				else
				{
					return null;
				}
			}
			
			return _list[--_length];
		}
		
		public function Dispose():void
		{
			if (_disposed)
				return;
			
			_disposed = true;
			
			_create = null;
			_clean = null;
			_list = null;
		}
	
	}

}