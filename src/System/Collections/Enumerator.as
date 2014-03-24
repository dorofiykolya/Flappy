package System.Collections
{
	import System.system;
	
	/**
	 * ...
	 * @author lena
	 */
	public class Enumerator implements IEnumerator
	{
		private var list:Array = [];
		private var position:int = -1;
		
		public function Enumerator(array:Object)
		{
			if (array is Array)
			{
				list = array as Array;
			}
			else
			{
				for each (var o:Object in array)
				{
					list.push(o);
				}
			}
		}
		
		public function get Current():Object
		{
			if (position == -1)
				return null;
			return list[position];
		}
		
		public function MoveNext():Boolean
		{
			position++;
			if (list.length == 0)
			{
				position--;
				return false;
			}
			if (position >= list.length)
			{
				position--;
				return false;
			}
			return true;
		}
		
		public function Reset():void
		{
			position = -1;
		}
		
		system function GetList():Array
		{
			return list;
		}
	}

}