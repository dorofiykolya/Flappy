
package System.Utils
{
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;
	import System.Delegate;
	
	public dynamic class PropertyProxy extends Proxy
	{
		public static function Create(source:Object, onChangeListener:Function = null):PropertyProxy
		{
			const newValue:PropertyProxy = new PropertyProxy(onChangeListener);
			for (var propertyName:String in source)
			{
				newValue[propertyName] = source[propertyName];
			}
			return newValue;
		}
		
		public function PropertyProxy(onChange:Function = null)
		{
			if (onChange != null)
			{
				this._onChange.Add(onChange);
			}
		}
		
		private var _names:Array = [];
		
		private var _storage:Object = {};
		
		private var _onChange:Delegate = new Delegate();
		
		public function get onChange():Delegate
		{
			return this._onChange;
		}
		
		override flash_proxy function hasProperty(name:*):Boolean
		{
			return this._storage.hasOwnProperty(name);
		}
		
		override flash_proxy function getProperty(name:*):*
		{
			if (this.flash_proxy::isAttribute(name))
			{
				const nameAsString:String = name is QName ? QName(name).localName : name.toString();
				if (!this._storage.hasOwnProperty(nameAsString))
				{
					this._storage[nameAsString] = new PropertyProxy();
					this._names.push(nameAsString);
					this._onChange.Invoke(this, nameAsString);
				}
				return this._storage[nameAsString];
			}
			return this._storage[name];
		}
		
		override flash_proxy function setProperty(name:*, value:*):void
		{
			this._storage[name] = value;
			if (this._names.indexOf(name) < 0)
			{
				this._names.push(name);
			}
			this._onChange.Invoke(this, name);
		}
		
		override flash_proxy function deleteProperty(name:*):Boolean
		{
			const index:int = this._names.indexOf(name);
			if (index >= 0)
			{
				this._names.splice(index, 1);
			}
			const result:Boolean = delete this._storage[name];
			if (result)
			{
				this._onChange.Invoke(this, name);
			}
			return result;
		}
		
		override flash_proxy function nextNameIndex(index:int):int
		{
			if (index < this._names.length)
			{
				return index + 1;
			}
			return 0;
		}
		
		override flash_proxy function nextName(index:int):String
		{
			return this._names[index - 1];
		}
		
		override flash_proxy function nextValue(index:int):*
		{
			const name:* = this._names[index - 1];
			return this._storage[name];
		}
	}
}
