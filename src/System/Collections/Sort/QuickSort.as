package System.Collections.Sort
{
	
	import System.Collections.Enumerator;
	import System.Collections.List;
	import System.system;
	
	/**
	 * ...
	 * @author dorofiy
	 */
	public final class QuickSort
	{
		/**
		 * Quick Sort
		 * @param	array
		 * - Array,
		 * - Vector,
		 * - System.Collections.List,
		 * - System.Collections.SortedList
		 * - System.Collections.Enumerator
		 * @param	left low index of array
		 * @param	right hight index of array
		 * @param	propepty if (property == null) { compare array[i] } else { compare array[i][property]}
		 */
		public static function Sort(array:Object, left:int = 0, right:int = int.MAX_VALUE, propepty:String = null, reverse:Boolean = false):void
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
				return;
			if (length == 0)
				return;
			if (length == 1)
				return;
			if (length == 2)
			{
				var o1:Object = array[0];
				var o2:Object = array[1];
				if (propepty)
				{
					if (o1[propepty] > o2[propepty])
					{
						if (reverse)
						{
							array[1] = o2;
							array[0] = o1;
						}
						else
						{
							array[0] = o2;
							array[1] = o1;
						}
					}
				}
				else
				{
					if (o1 > o2)
					{
						if (reverse)
						{
							array[1] = o2;
							array[0] = o1;
						}
						else
						{
							array[0] = o2;
							array[1] = o1;
						}
					}
				}
				return;
			}
			if (right >= length)
			{
				right = length - 1;
			}
			if (propepty)
			{
				sortProperty(array, left, right, propepty, reverse);
			}
			else
			{
				sort(array, left, right, reverse);
			}
		}
		
		private static function sort(array:Object, left:int, right:int, reverse:Boolean = false):void
		{
			var i:int = left;
			var j:int = right;
			var x:* = array[int((left + right) >> 1)];
			do
			{
				if (reverse)
				{
					while (array[i] > x)
					i++;
					while (array[j] < x)
						j--;
				}
				else
				{
					while (array[i] < x)
					i++;
					while (array[j] > x)
						j--;
				}
				
				if (i <= j)
				{
					var temp:* = array[i];
					array[i] = array[j];
					array[j] = temp;
					i++;
					j--;
				}
			} while (i < j);
			if (left < j)
				sort(array, left, j, reverse);
			if (i < right)
				sort(array, i, right, reverse);
		}
		
		private static function sortProperty(array:Object, left:int, right:int, property:String, reverse:Boolean = false):void
		{
			var i:int = left;
			var j:int = right;
			// x - опорный элемент посредине между left и right
			var x:* = array[left + right >> 1][property];
			do
			{
				if (reverse)
				{
					// поиск элемента для переноса в старшую часть
					while (array[i][property] > x)
					{
						++i;
					}
					// поиск элемента для переноса в младшую часть
					while (array[j][property] < x)
					{
						--j;
					}
				}
				else
				{
					// поиск элемента для переноса в старшую часть
					while (array[i][property] < x)
					{
						++i;
					}
					// поиск элемента для переноса в младшую часть
					while (array[j][property] > x)
					{
						--j;
					}
				}
				
				if (i <= j)
				{
					// обмен элементов местами:
					var temp:* = array[i];
					array[i] = array[j];
					array[j] = temp;
					// переход к следующим элементам:
					i++;
					j--;
				}
			} while (i < j);
			
			if (left < j)
			{
				sortProperty(array, left, j, property, reverse);
			}
			if (i < right)
			{
				sortProperty(array, i, right, property, reverse);
			}
		}
	}

}