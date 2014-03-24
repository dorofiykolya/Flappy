package System.Geom
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import System.ICloneable;
	import System.IEquals;
	
	/**
	 * ...
	 * @author
	 */
	public class Circle implements IEquals
	{
		public var x:Number;
		public var y:Number;
		public var radius:Number;
		
		public function Circle(x:Number = 0, y:Number = 0, radius:Number = 0)
		{
			this.x = x;
			this.y = y;
			this.radius = radius;
		}
		
		public function Equals(object:Object):Boolean
		{
			if (this === object) 
			{
				return true;
			}
			var c:Circle = object as Circle;
			if (c)
			{
				return c.x == x && c.y == y && c.radius == radius;
			}
			return false;
		}
		
		public function Offset(x:Number = 0, y:Number = 0, radius:Number = 0):Circle
		{
			this.x += x;
			this.y += y;
			this.radius += radius;
			return this;
		}
		
		public function Set(x:Number = 0, y:Number = 0, radius:Number = 0):Circle
		{
			this.x = x;
			this.y = y;
			this.radius = radius;
			return this;
		}
		
		public function Clone():Circle
		{
			return new Circle(x, y, radius);
		}
		
		public function Copy():Circle
		{
			return new Circle(x, y, radius);
		}
		
		public function CopyFrom(circle:Circle):void
		{
			this.x = circle.x;
			this.y = circle.y;
			this.radius = circle.radius;
		}
		
		public function ContainsPoint(point:Point):Boolean
		{
			const dx:Number = point.x - x;
			const dy:Number = point.y - y;
			return radius > Math.sqrt(dx * dx + dy * dy);
		}
		
		public function IntersectionPoint(point:Point):Boolean
		{
			const dx:Number = point.x - x;
			const dy:Number = point.y - y;
			return radius > Math.sqrt(dx * dx + dy * dy);
		}
		
		public function IntersectionCircle(circle:Circle):Boolean
		{
			const dx:Number = circle.x - x;
			const dy:Number = circle.y - y;
			return radius + circle.radius > Math.sqrt(dx * dx + dy * dy);
		}
		
		public function IntersectionRectangle(rect:Rectangle):Boolean
		{
			const halfWidth:Number = rect.width * 0.5;
			const halfHeight:Number = rect.height * 0.5;
			var cx:Number = x - rect.x - halfWidth;
			if (cx < 0)
			{
				cx = -cx;
			}
			const xDist:Number = halfWidth + radius;
			if (cx > xDist)
			{
				return false;
			}
			var cy:Number = y - rect.y - halfHeight;
			if (cy < 0)
			{
				cy = -cy;
			}
			const yDist:Number = halfHeight + radius;
			if (cy > yDist)
			{
				return false;
			}
			if (cx <= halfWidth || cy <= halfHeight)
			{
				return true;
			}
			const xCornerDist:Number = cx - halfWidth;
			const yCornerDist:Number = cy - halfHeight;
			const xCornerDistSq:Number = xCornerDist * xCornerDist;
			const yCornerDistSq:Number = yCornerDist * yCornerDist;
			const maxCornerDistSq:Number = radius * radius;
			return xCornerDistSq + yCornerDistSq <= maxCornerDistSq;
		}
		
		public function toString():String
		{
			return "(x:" + x + ", y:" + y + ", radius:" + radius + ")";
		}
	}

}