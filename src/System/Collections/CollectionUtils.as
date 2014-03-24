package System.Collections 
{
	/**
	 * ...
	 * @author dorofiy
	 */
	public class CollectionUtils 
	{
		public static function IndexOf(array:Object, value:Object):int {
			if (array == null) return -1;
			return array.indexOf(value);
		}
	}

}