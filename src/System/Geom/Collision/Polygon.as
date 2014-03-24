package System.Geom.Collision
{
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author
	 */
	public class Polygon
	{
		protected var points:Vector.<Point>;
		protected var edges:Vector.<Point> = new Vector.<Point>();
		
		public function Polygon(points:Vector.<Point> = null)
		{
			if (points)
			{
				this.points = points;
			}
			else
			{
				this.points = new Vector.<Point>();
			}
		}
		
		public function BuildEdges():void
		{
			var p1:Point;
			var p2:Point;
			edges.length = 0;
			for (var i:int = 0; i < points.length; i++)
			{
				p1 = points[i];
				if (i + 1 >= points.length)
				{
					p2 = points[0];
				}
				else
				{
					p2 = points[i + 1];
				}
				var p:Point = new Point(p2.x - p1.x, p2.y - p1.y);
				edges.push(p);
			}
		}
		
		public function AddPoint(point:Point):void
		{
			points.push(point);
		}
		
		public function get Edges():Vector.<Point>
		{
			return edges;
		}
		
		public function get Points():Vector.<Point>
		{
			return points;
		}
		
		public function get Center():Point
		{
			var totalX:Number = 0;
			var totalY:Number = 0;
			for (var i:int = 0; i < points.length; i++)
			{
				totalX += points[i].x;
				totalY += points[i].y;
			}
			return new Point(totalX / points.length, totalY / points.length);
		}
		
		public function OffsetPoint(p:Point):void
		{
			Offset(p.x, p.y);
		}
		
		public function Offset(x:Number, y:Number):void
		{
			for (var i:int = 0; i < points.length; i++)
			{
				var p:Point = points[i];
				points[i] = new Point(p.x + x, p.y + y);
			}
		}
		
		public function toString():String
		{
			var result:String = "";
			
			for (var i:int = 0; i < points.length; i++)
			{
				if (result != "")
				{
					result += " ";
				}
				result += "{" + points[i].toString() + "}";
			}
			return result;
		}
	}
}