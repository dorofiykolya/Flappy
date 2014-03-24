package System.Geom
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author
	 */
	public class Intersection
	{
		/**
		 * 
		 * @param	rect
		 * @param	centerRectRotation - radian
		 * @param	point
		 * @return
		 */
		public static function RectangleToPoint(rect:Rectangle, centerRectRotation:Number, point:Point):Boolean
		{
			if (centerRectRotation == 0)
			{
				return rect.containsPoint(point);
			}
			
			const halfWidth:Number = rect.width / 2;
			const halfHeight:Number = rect.height / 2;
			
			const rectCenterX:Number = rect.x + halfWidth;
			const rectCenterY:Number = rect.y + halfHeight;
			
			const sinR:Number = Math.sin(centerRectRotation);
			const cosR:Number = Math.cos(centerRectRotation);
			
			const tx:Number = cosR * point.x - sinR * point.y;
			const ty:Number = cosR * point.y + sinR * point.x;
			
			const cx:Number = cosR * rectCenterX - sinR * rectCenterY;
			const cy:Number = cosR * rectCenterY + sinR * rectCenterX;
			
			return Math.abs(cx - tx) < halfWidth && Math.abs(cy - ty) < halfHeight;
		}
		
		public static function TestRectangleToPoint(rectWidth:Number, rectHeight:Number, rectRotation:Number, rectCenterX:Number, rectCenterY:Number, pointX:Number, pointY:Number):Boolean
		{
			if (rectRotation == 0)
			{
				return Math.abs(rectCenterX - pointX) < rectWidth / 2 && Math.abs(rectCenterY - pointY) < rectHeight / 2;
			}
			
			const tx = Math.cos(rectRotation) * pointX - Math.sin(rectRotation) * pointY;
			const ty = Math.cos(rectRotation) * pointY + Math.sin(rectRotation) * pointX;
			
			const cx = Math.cos(rectRotation) * rectCenterX - Math.sin(rectRotation) * rectCenterY;
			const cy = Math.cos(rectRotation) * rectCenterY + Math.sin(rectRotation) * rectCenterX;
			
			return Math.abs(cx - tx) < rectWidth / 2 && Math.abs(cy - ty) < rectHeight / 2;
		}
		
		/** Circle To Segment. */
		public static function TestCircleToSegment(circleCenterX:Number, circleCenterY:Number, circleRadius:Number, lineAX:Number, lineAY:Number, lineBX:Number, lineBY:Number):Boolean
		{
			const lineSize:Number = Math.sqrt(Math.pow(lineAX - lineBX, 2) + Math.pow(lineAY - lineBY, 2));
			var distance:Number;
			
			if (lineSize == 0)
			{
				distance = Math.sqrt(Math.pow(circleCenterX - lineAX, 2) + Math.pow(circleCenterY - lineAY, 2));
				return distance < circleRadius;
			}
			
			var u:Number = ((circleCenterX - lineAX) * (lineBX - lineAX) + (circleCenterY - lineAY) * (lineBY - lineAY)) / (lineSize * lineSize);
			
			if (u < 0)
			{
				distance = Math.sqrt(Math.pow(circleCenterX - lineAX, 2) + Math.pow(circleCenterY - lineAY, 2));
			}
			else if (u > 1)
			{
				distance = Math.sqrt(Math.pow(circleCenterX - lineBX, 2) + Math.pow(circleCenterY - lineBY, 2));
			}
			else
			{
				var ix:Number = lineAX + u * (lineBX - lineAX);
				var iy:Number = lineAY + u * (lineBY - lineAY);
				distance = Math.sqrt(Math.pow(circleCenterX - ix, 2) + Math.pow(circleCenterY - iy, 2));
			}
			
			return distance < circleRadius;
		}
		
		/** Rectangle To Circle. */
		public static function TestRectangleToCircle(rectWidth:Number, rectHeight:Number, rectRotation:Number, rectCenterX:Number, rectCenterY:Number, circleCenterX:Number, circleCenterY:Number, circleRadius:Number):Boolean
		{
			var tx:Number, ty:Number, cx:Number, cy:Number;
			
			if (rectRotation == 0)
			{ // Higher Efficiency for Rectangles with 0 rotation.
				tx = circleCenterX;
				ty = circleCenterY;
				
				cx = rectCenterX;
				cy = rectCenterY;
			}
			else
			{
				tx = Math.cos(rectRotation) * circleCenterX - Math.sin(rectRotation) * circleCenterY;
				ty = Math.cos(rectRotation) * circleCenterY + Math.sin(rectRotation) * circleCenterX;
				
				cx = Math.cos(rectRotation) * rectCenterX - Math.sin(rectRotation) * rectCenterY;
				cy = Math.cos(rectRotation) * rectCenterY + Math.sin(rectRotation) * rectCenterX;
			}
			
			return TestRectangleToPoint(rectWidth, rectHeight, rectRotation, rectCenterX, rectCenterY, circleCenterX, circleCenterY) || 
			TestCircleToSegment(tx, ty, circleRadius, cx - rectWidth / 2, cy + rectHeight / 2, cx + rectWidth / 2, cy + rectHeight / 2) || 
			TestCircleToSegment(tx, ty, circleRadius, cx + rectWidth / 2, cy + rectHeight / 2, cx + rectWidth / 2, cy - rectHeight / 2) || 
			TestCircleToSegment(tx, ty, circleRadius, cx + rectWidth / 2, cy - rectHeight / 2, cx - rectWidth / 2, cy - rectHeight / 2) || 
			TestCircleToSegment(tx, ty, circleRadius, cx - rectWidth / 2, cy - rectHeight / 2, cx - rectWidth / 2, cy + rectHeight / 2);
		}
	}

}