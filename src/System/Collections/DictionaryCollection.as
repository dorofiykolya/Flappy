package System.Collections
{
	import flash.utils.Dictionary;
	import flash.utils.Proxy;
	import System.IDisposable;
	import flash.utils.flash_proxy;
	/**
	 * ...
	 * @author dorofiy.com
	 */
	use namespace flash_proxy;
	
	public dynamic class DictionaryCollection extends Proxy implements IDisposable, IEnumerable
	{
		private var dictionary:Dictionary;
		private var dictionaryValue:Dictionary;
		private var count:int;
		
		private var iterator:Array;
		
		public function DictionaryCollection(collection:Object = null)
		{
			dictionary = new Dictionary();
			dictionaryValue = new Dictionary();
		}
		
		public function Clear():void
		{
			dictionary = new Dictionary();
			dictionaryValue = new Dictionary();
			count = 0;
		}
		
		override flash_proxy function nextNameIndex(index:int):int
		{
			if (index == 0)
			{
				iterator = [];
				for (var key:String in dictionary) 
				{
					iterator.push(key);
				}
			}
			if (index < iterator.length)
			{
				return index + 1;
			}
			return 0;
		}
		
		override flash_proxy function nextName(index:int):String
		{
			return iterator[index - 1];
		}
		override flash_proxy function nextValue(index:int):*
		{
			return dictionary[iterator[index - 1]];
		}
		
		override flash_proxy function setProperty(key:*, value:*):void
		{
			var old:* = dictionary[key];
			dictionary[key] = value;
			if (old != undefined)
			{
				delete dictionaryValue[old];
				count--;
			}
			dictionaryValue[value] = key;
			count++;
		}
		
		override flash_proxy function hasProperty(name:*):Boolean
		{
			return dictionary[name] != undefined;
		}
		
		override flash_proxy function getProperty(name:*):*
		{
			return dictionary[name];
		}
		
		override flash_proxy function deleteProperty(name:*):Boolean
		{
			var value:* = dictionary[key];
			if (value === undefined)
				return false;
			delete dictionaryValue[value];
			delete dictionary[key];
			count--;
			return true;
		}
		
		public function ContainsKey(key:Object):Boolean
		{
			return dictionary[key] != undefined;
		}
		
		public function ContainsValue(value:Object):Boolean
		{
			return dictionaryValue[value] != undefined;
		}
		
		public function GetValue(key:Object):Object
		{
			return dictionary[key];
		}
		
		public function GetKey(value:Object):Object
		{
			return dictionaryValue[value];
		}
		
		public function SetValue(key:Object, value:Object):void
		{
			var old:* = dictionary[key];
			dictionary[key] = value;
			if (old != undefined)
			{
				delete dictionaryValue[old];
				count--;
			}
			dictionaryValue[value] = key;
			count++;
		}
		
		public function Add(key:Object, value:Object, replace:Boolean = false):void
		{
			if (strictMode && dictionary[key] != undefined && replace == false)
			{
				throw new Error("[DictionaryList] method Add, key is exist: " + key);
			}
			var old:* = dictionary[key];
			dictionary[key] = value;
			if (old != undefined)
			{
				delete dictionaryValue[old];
				count--;
			}
			dictionaryValue[value] = key;
			count++;
		}
		
		public function Remove(key:Object):void
		{
			var value:* = dictionary[key];
			if (value === undefined)
				return;
			delete dictionaryValue[value];
			delete dictionary[key];
			count--;
		}
		
		public function RemoveValue(value:Object):void
		{
			var key:* = dictionaryValue[value];
			if (key == undefined)
				return;
			delete dictionary[key];
			delete dictionaryValue[value];
			count--;
		}
		
		public function get Count():int
		{
			return count;
		}
		
		public function GetEnumerator():IEnumerator
		{
			return new Enumerator(dictionary);
		}
		
		public function Dispose():void
		{
			dictionary = null;
			dictionaryValue = null;
			count = null;
		}
	}

}