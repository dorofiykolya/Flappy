package System.Collections 
{
	/**
	 * ...
	 * @author ...
	 */
	public class CompareUtil 
	{
		
		/**
		 * 
		 * @param	property String or Array (properties of Object) example: 
		 * 
		 * var sortFunction:Function = Create("first_name,last_name", false);
		 * var sortFunction:Function = Create(["first_name","last_name"], false);
		 * 
		 * var o1:Object = {first_name:"Bob", last_name:"Job"}
		 * var o2:Object = {first_name:"Bob", last_name:"Job2"}
		 * trace( sort(o1, o2) ) // 1
		 * 
		 * var arr:Array = [o1,o2];
		 * arr.sort(sortFunction);
		 * 
		 * @param	increase
		 * @return
		 */
		public static function Create(property:Object, increase:Boolean = true):Function {
			if (property is String) return new CompareUtil().CreateFunctionString(String(property), increase);
			if (property is Array) return new CompareUtil().CreateFunctionArray((property as Array), increase);
			return null;
		}
		
		
		
		private function CreateFunctionString(property:String, increase:Boolean = true):Function {
			var sort:Function = function (p1:Object, p2:Object):int {
                var p:String = property;
                var split:Array = property.split(",");
                var prop:String = split.shift();
                property = split.join(",");
                p = property;
                if (p1[prop] > p2[prop]) return increase ? 1 : -1;
                if (p1[prop] < p2[prop]) return increase ? -1 : 1;
                if (split.length == 0) return 0;
                return sort(p1, p2);
                return 0;
            };
			return sort;
		}
		
		
		private function CreateFunctionArray(properties:/* type of String*/Array, increase:Boolean = true):Function 
		{
			var source:Array = properties.concat();
			var sort:Function = function (p1:Object, p2:Object):int {
                var prop:String = properties.shift();
                if (p1[prop] > p2[prop]) {
                    properties = source;
                    return increase ? 1 : -1;
                }
                if (p1[prop] < p2[prop]) {
                    properties = source;
                    return increase ? -1 : 1;
                }
                if (properties.length == 0) {
                    properties = source;
                    return 0;
                }
                return sort(p1, p2);
                return 0;
            };
			return sort;
		}
		
	}

}