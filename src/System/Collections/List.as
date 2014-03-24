package System.Collections
{
	import flash.utils.flash_proxy;
	import flash.utils.Proxy;
	import System.IDisposable;
	import System.system;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class List  extends Proxy  implements IDisposable, IEnumerable
	{
		private var list:Vector.<Object>;
		private var strictMode:Boolean;
		
		public function List(strictMode:Boolean = false, fixed:Boolean = false, count:int = 0)
		{
			list = new Vector.<Object>(count);
			list.fixed = fixed;
			this.strictMode = strictMode;
		}
		
		override flash_proxy function setProperty(key:*, value:*):void
		{
			if (key is int || key is uint)
			{
				if (key < 0)
				{
					if (strictMode)
					{
						throw new RangeError("[System.Collections.List] method setProperty, RangeError");
					}
					return;
				}
				if (key > list.length)
				{
					if (strictMode)
					{
						throw new RangeError("[System.Collections.List] method setProperty, RangeError");
					}
					return;
				}
				list[int(key)] = value;
				
			}
			else
			{
				key = list.indexOf(key);
				if (key >= 0)
				{
					list[int(key)] = value;
				}
				if (strictMode)
				{
					throw new ArgumentError("[System.Collections.List] method setProperty, ArgumentError");
				}
				return;
			}
		}
		
		override flash_proxy function hasProperty(name:*):Boolean
		{
			if (name is int || name is uint)
			{
				name = int(name);
				if (name < 0) 
				{
					if (strictMode)
					{
						throw new RangeError("[System.Collections.List] method hasProperty, RangeError");
					}
					return false;
				}
				if (name >= list.length) 
				{
					if (strictMode)
					{
						throw new RangeError("[System.Collections.List] method hasProperty, RangeError");
					}
					return false;
				}
				return true;
			}
			name = list.indexOf(Object(name));
			return name >= 0;
		}
		
		override flash_proxy function getProperty(name:*):*
		{
			if (name is int || name is uint)
			{
				return list[int(name)];
			}
			name = list.indexOf(Object(name));
			if (name >= 0)
			{
				return list[int(name)];
			}
			throw new ArgumentError("get undefined property");
			return null;
		}
		
		override flash_proxy function deleteProperty(key:*):Boolean
		{
			if (key is int || key is uint)
			{
				key = int(key);
				if (key < 0) 
				{
					if (strictMode)
					{
						throw new RangeError("[System.Collections.List] method deleteProperty, RangeError");
					}
					return false;
				}
				if (key >= list.length) 
				{
					if (strictMode)
					{
						throw new RangeError("[System.Collections.List] method deleteProperty, RangeError");
					}
					return false;
				}
				list[key] = null;
				return true;
			}
			key = list.indexOf(Object(key));
			if (int(key) >= 0)
			{
				list[int(key)] = null;
				return true;
			}
			return false;
		}
		
		public function get Fixed():Boolean
		{
			return list.fixed;
		}
		
		public function Set(index:int, value:Object):Object
		{
			if (index < 0 && index >= list.length)
			{
				if (strictMode)
				{
					throw new RangeError("[System.Collections.List] method Get, RangeError");
				}
				return null;
			}
			list[index] = value;
			return value;
		}
		
		public function Get(index:int):Object
		{
			if (index < 0 && index >= list.length)
			{
				if (strictMode)
				{
					throw new RangeError("[System.Collections.List] method Get, RangeError");
				}
				return null;
			}
			return list[index];
		}
		
		public function IndexOf(object:Object):int
		{
			return list.indexOf(object);
		}
		
		public function LastIndexOf(object:Object):int
		{
			return list.lastIndexOf(object);
		}
		
		public function Add(value:Object):Boolean
		{
			var i:int = list.indexOf(value);
			if (i >= 0)
			{
				if (strictMode)
				{
					throw new ArgumentError("[System.Collections.List] method Add, value is exist");
				}
				return false;
			}
			list.push(value);
			return true;
		}
		
		public function Insert(value:Object, index:int = int.MAX_VALUE):Object
		{
			var len:int = list.length;
			if (index > len)
			{
				index = len;
			}
			if (Contains(value))
			{
				SetIndex(value, index);
				return value;
			}
			if (len == index)
			{
				list.push(value);
			}
			else
			{
				list.splice(0, index, value);
			}
			return value;
		}
		
		public function Remove(value:Object):Object
		{
			var i:int = list.indexOf(value);
			if (i != -1)
			{
				if (strictMode)
				{
					throw new ArgumentError("[System.Collections.List] method Remove, value is not exist");
				}
				return null;
			}
			return list.splice(i, 1);
		}
		
		public function GetRandom(min:int = 0, max:int = int.MAX_VALUE):Object
		{
			var len:int = list.length;
			if (len == 0)
			{
				return null;
			}
			if (len == 1)
			{
				return list[0];
			}
			if (min >= max) 
			{
				return list[0];
			}
			if (max > len)
			{
				max = len;
			}
			var r:int = Math.max(min, int(Math.random() * max));
			return list[r];
		}
		
		public function RemoveAt(index:int):Object
		{
			if (strictMode)
			{
				return list.splice(index, 1);
			}
			if (index < 0)
			{
				return null;
			}
			if (index > list.length)
			{
				return null;
			}
			return list.splice(index, 1);
		}
		
		public function RemoveLast():Object
		{
			if (list.length == 0)
			{
				return null;
			}
			return list.pop();
		}
		
		public function RemoveFirst():Object
		{
			if (list.length == 0)
			{
				return null;
			}
			return list.shift();
		}
		
		public function SwapIndex(index1:int, index2:int):void
		{
			var child1:Object = list[index1];
			list[index1] = list[index2];
			list[index2] = child1;
		}
		
		public function SwapObject(object1:Object, object2:Object):void
		{
			var index1:int = list.indexOf(object1);
			var index2:int = list.indexOf(object2);
			if (index1 == -1 || index2 == -1)
			{
				throw new ArgumentError("list does not include the object");
			}
			SwapIndex(index1, index2);
		}
		
		public function SetIndex(value:Object, index:int):Boolean
		{
			var i:int = list.indexOf(value);
			if (i == -1)
			{
				return false;
			}
			if (i == index)
			{
				return true;
			}
			SwapIndex(i, index);
			return true;
		}
		
		public function Contains(value:Object):Boolean
		{
			var i:int = list.indexOf(value);
			return i >= 0;
		}
		
		public function Sort(functionCompare:Function /*(v1:Object, v2:Object):int*/):Vector.<Object>
		{
			return list.sort(functionCompare);
		}
		
		public function get Count():int
		{
			return list.length;
		}
		
		public function Clear():void
		{
			list.length = 0;
		}
		
		public function Dispose():void
		{
			list = null;
		}
		
		public function GetEnumerator():IEnumerator
		{
			return new Enumerator(list);
		}
		
		public function ToArray():Array 
		{
			var len:int = list.length;
			var array:Array = new Array(len);
			for (var i:int = 0; i < len; i++) 
			{
				array[i] = list[i];
			}
			return array;
		}
		
		public function ToVector():Vector.<Object>
		{
			return list.slice();
		}
		
		system function GetList():Vector.<Object>
		{
			return list;
		}
	
	}

}