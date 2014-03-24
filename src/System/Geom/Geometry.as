package System.Geom 
{
	import flash.geom.Point;
	/**
	 * ...
	 * @author 
	 */
	public class Geometry 
	{
		public static function Distance(ax:Number, ay:Number, bx:Number, by:Number):Number
		{
			var a:Number = ax - bx;
			if (a < 0) 
			{
				a = -a;
			}
			var b:Number = ay - by;
			if (b < 0)
			{
				b = -b;
			}
			return Math.sqrt(a * a + b * b);
		}
	}

}