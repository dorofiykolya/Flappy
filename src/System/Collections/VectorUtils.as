package System.Collections 
{
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class VectorUtils 
	{
		public static function Concate(source:Object, values:Object):Object
		{
			var len:int = values.length;
			var index:int = source.length;
			for (var i:int = 0; i < len; i++, index++) 
			{
				source[index] = values[i];
			}
			return source;
		}
	}

}