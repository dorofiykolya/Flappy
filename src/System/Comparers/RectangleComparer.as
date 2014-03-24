package System.Comparers 
{
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author dorofiy
	 */
	public class RectangleComparer 
	{
		public static function Compare(rectangle1:Rectangle, rectangle2:Rectangle):Boolean {
			return rectangle1.equals(rectangle2);
		}
		public static function CompareThreshold(rectangle1:Rectangle, rectangle2:Rectangle, threshold:Number = 0):Boolean {
			if (threshold == 0) {
				return rectangle1.equals(rectangle2) == false;
			}
			var x:Number = rectangle1.x - rectangle2.x;
			var y:Number = rectangle1.y - rectangle2.y;
			var w:Number = rectangle1.width - rectangle2.width;
			var h:Number = rectangle1.height - rectangle2.height;
			if (x < 0) {
				x = -x;
			}
			if (y < 0) {
				y = -y;
			}
			if (w < 0) {
				w = -w;
			}
			if (h < 0) {
				h = -h;
			}
			
			return (x <= threshold && y <= threshold && w <= threshold && h <= threshold);
		}
		
	}

}