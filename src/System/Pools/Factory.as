package System.Pools
{
	import flash.utils.getQualifiedClassName;
	import System.IDisposable;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class Factory
	{
		
		private static var pool:Object = {};
		
		public static function Create(type:Class, arg1:* = null, arg2:* = null, arg3:* = null, arg4:* = null, arg5:* = null):Object
		{
			var key:String = getQualifiedClassName(type);
			var currentClass:Class = type;
			var instance:Object;
			var list:Vector.<Object> = pool[key];
			if (list == null || list.length == 0)
			{
				if (arg1 != undefined)
				{
					if (arg2 != undefined)
					{
						if (arg3 != undefined)
						{
							if (arg4 != undefined)
							{
								if (arg5 != undefined)
								{
									instance = new currentClass(arg1, arg2, arg3, arg4, arg5);
									return instance;
								}
								instance = new currentClass(arg1, arg2, arg3, arg4);
								return instance;
							}
							instance = new currentClass(arg1, arg2, arg3);
							return instance;
						}
						instance = new currentClass(arg1, arg2);
						return instance;
					}
					instance = new currentClass(arg1)
					return instance;
				}
				instance = new currentClass();
				return instance;
			}
			return list.pop();
		}
		
		public static function Dispose(object:Object, checkOnInclude:Boolean = false):void
		{
			if (object == null)
			{
				throw new ArgumentError("object can't be null");
			}
			var type:String = getQualifiedClassName(object);
			var list:Vector.<Object> = pool[type];
			if (list == null)
			{
				list = new Vector.<Object>();
				pool[type] = list;
				checkOnInclude = false;
			}
			if (checkOnInclude)
			{
				if (list.indexOf(object) != -1)
				{
					return;
				}
			}
			list.push(object);
		}
	}

}