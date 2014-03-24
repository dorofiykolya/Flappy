package System.Comparers
{
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author dorofiy
	 */
	public class PointComparer
	{
		public static function Compare(point1:Point, point2:Point):Boolean
		{
			if (point1 == point2)
			{
				return true;
			}
			if (point1 == null && point2 != null || point1 != null && point2 == null)
			{
				return false;
			}
			return point1.equals(point2);
		}
		
		public static function CompareThreshold(point1:Point, point2:Point, threshold:Number = 0):Boolean
		{
			if (point1 == point2)
			{
				return true;
			}
			if (point1 == null && point2 != null || point1 != null && point2 == null)
			{
				return false;
			}
			if (threshold == 0 || threshold != threshold)
			{
				return point1.equals(point2);
			}
			var x:Number = point1.x - point2.x;
			var y:Number = point1.y - point2.y;
			if (x < 0)
			{
				x = -x;
			}
			if (y < 0)
			{
				y = -y;
			}
			return (x <= threshold && y <= threshold);
		}
	}

}