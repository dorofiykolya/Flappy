package System.Collections.Sort
{
	import System.Collections.Enumerator;
	import System.Collections.List;
	import System.system;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class RandomSort
	{
		public static function Sort(array:Object):void
		{
			if (array is List)
			{
				array = array.system::GetList();
			}
			else if (array is Enumerator)
			{
				array = array.system::GetList();
			}
			var length:* = array.length;
			if (length == undefined)
			{
				return;
			}
			if (length == 0)
			{
				return;
			}
			if (length == 1)
			{
				return;
			}
			if (length == 2)
			{
				if (Math.random() > 0.5)
				{
					var temp:Object = array[1];
					array[1] = array[0];
					array[0] = temp;
				}
				return;
			}
			var n:int = array.length;
			while (n > 1)
			{
				var k:int = int(Math.random() * n);
				n--;
				var temp:Object = array[n];
				array[n] = array[k];
				array[k] = temp;
			}
		}
	}

}