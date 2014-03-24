package System.Pools 
{
	import flash.utils.getQualifiedClassName;
	import System.IDisposable;
	/**
	 * ...
	 * @author dorofiy
	 */
	public class PoolFactory 
	{
		
		private static const pool:Object = { };
		
		public static function Create(type:Class, arg1:* = undefined, arg2:* = undefined, arg3:* = undefined, arg4:* = undefined, arg5:* = undefined):IPoolFactory {
			var key:String = getQualifiedClassName(type);
			var currentClass:Class = type;
			var instance:IPoolFactory;
			var list:Vector.<IPoolFactory> = pool[key];
			if (list == null || list.length == 0) {
				if (arg1 !== undefined && arg2 !== undefined && arg3 !== undefined && arg4 !== undefined && arg5 !== undefined) instance = new currentClass(arg1, arg2, arg3, arg4, arg5);
				else if (arg1 !== undefined && arg2 !== undefined && arg3 !== undefined && arg4 !== undefined) instance = new currentClass(arg1, arg2, arg3, arg4);
				else if (arg1 !== undefined && arg2 !== undefined && arg3 !== undefined) instance = new currentClass(arg1, arg2, arg3);
				else if (arg1 !== undefined && arg2 !== undefined) instance = new currentClass(arg1, arg2);
				else if (arg1 !== undefined) instance = new currentClass(arg1);
				else instance = new currentClass();
				if (instance == null) {
					throw new ArgumentError("instance of type must be implements IPoolFactory");
				}
				return instance.Reinitialize();
			}
			return list.pop().Reinitialize();
		}
		
		public static function Dispose(instance:IPoolFactory):void {
			if (instance == null) {
				throw new ArgumentError("instance cant be null");
			}
			var type:String = getQualifiedClassName(instance);
			var list:Vector.<IPoolFactory> = pool[type];
			if (list == null) {
				list = new Vector.<IPoolFactory>();
				pool[type] = list;
			}
			list.push(instance);
		}
		
	}

}