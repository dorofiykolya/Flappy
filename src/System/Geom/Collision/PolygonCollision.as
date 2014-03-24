package System.Geom.Collision
{
	import flash.geom.Point;
	import System.Geom.Polygon;
	
	/**
	 * ...
	 * @author
	 */
	public class PolygonCollision
	{
		public static function Test(polygonA:Polygon, polygonB:Polygon, velocity:Point):PolygonCollisionResult
		{
			var result:PolygonCollisionResult = new PolygonCollisionResult();
			result.Intersect = true;
			result.WillIntersect = true;
			
			var edgeCountA:int = polygonA.Edges.length;
			var edgeCountB:int = polygonB.Edges.length;
			var minIntervalDistance:Number = Number.MAX_VALUE;
			var translationAxis:Point = new Point();
			var edge:Point;
			
			// Loop through all the edges of both polygons
			for (var edgeIndex:int = 0; edgeIndex < edgeCountA + edgeCountB; edgeIndex++)
			{
				if (edgeIndex < edgeCountA)
				{
					edge = polygonA.Edges[edgeIndex];
				}
				else
				{
					edge = polygonB.Edges[edgeIndex - edgeCountA];
				}
				
				// ===== 1. Find if the polygons are currently intersecting =====
				
				// Find the axis perpendicular to the current edge
				var axis:Point = new Point(-edge.y, edge.x);
				NormalizePoint(axis);
				
				// Find the projection of the polygon on the current axis
				var minA:Number = 0;
				var minB:Number = 0;
				var maxA:Number = 0;
				var maxB:Number = 0;
				
				var ap:Point = new Point(minA, maxA);
				var bp:Point = new Point(minB, maxB);
				
				ProjectPolygon(axis, polygonA, ap);
				ProjectPolygon(axis, polygonB, bp);
				
				minA = ap.x;
				maxA = ap.y;
				
				minB = bp.x;
				maxB = bp.y;
				
				// Check if the polygon projections are currentlty intersecting
				if (IntervalDistance(minA, maxA, minB, maxB) > 0)
				{
					result.Intersect = false;
				}
				
				// ===== 2. Now find if the polygons *will* intersect =====
				
				// Project the velocity on the current axis
				var velocityProjection:Number = DotProduct(axis, velocity);
				
				// Get the projection of polygon A during the movement
				if (velocityProjection < 0)
				{
					minA += velocityProjection;
				}
				else
				{
					maxA += velocityProjection;
				}
				
				// Do the same test as above for the new projection
				var intervalDistance:Number = IntervalDistance(minA, maxA, minB, maxB);
				if (intervalDistance > 0)
				{
					result.WillIntersect = false;
				}
				
				// If the polygons are not intersecting and won't intersect, exit the loop
				if (!result.Intersect && !result.WillIntersect)
				{
					break;
				}
				
				// Check if the current interval distance is the minimum one. If so store
				// the interval distance and the current distance.
				// This will be used to calculate the minimum translation vector
				intervalDistance = Math.abs(intervalDistance);
				if (intervalDistance < minIntervalDistance)
				{
					minIntervalDistance = intervalDistance;
					translationAxis = axis;
					
					var centerA:Point = polygonA.Center;
					var centerB:Point = polygonB.Center;
					var d:Point = new Point(centerA.x - centerB.x, centerA.y - centerB.y);
					if (DotProduct(d, translationAxis) < 0)
					{
						translationAxis.x = -translationAxis.x;
						translationAxis.y = -translationAxis.y;
					}
				}
			}
			
			// The minimum translation vector can be used to push the polygons appart.
			// First moves the polygons by their velocity
			// then move polygonA by MinimumTranslationVector.
			if (result.WillIntersect)
			{
				result.MinimumTranslationVector = new Point(translationAxis.x * minIntervalDistance, translationAxis.y * minIntervalDistance);
			}
			
			return result;
		}
		
		private static function ProjectPolygon(axis:Point, polygon:Polygon, minXMaxY:Point):void
		{
			// To project a point on an axis use the dot product
			var d:Number = DotProduct(axis, polygon.Points[0]);
			var min:Number = d;
			var max:Number = d;
			for (var i:int = 0; i < polygon.Points.length; i++)
			{
				d = DotProduct(polygon.Points[i], axis);
				if (d < min)
				{
					min = d;
				}
				else
				{
					if (d > max)
					{
						max = d;
					}
				}
			}
			minXMaxY.x = min;
			minXMaxY.y = max;
		}
		
		public static function IntervalDistance(minA:Number, maxA:Number, minB:Number, maxB:Number):Number
		{
			if (minA < minB)
			{
				return minB - maxA;
			}
			return minA - maxB;
		}
		
		private static function DotProduct(point:Point, vector:Point):Number
		{
			return point.x * vector.x + point.y * vector.y;
		}
		
		private static function MagnitudePoint(point:Point):Number
		{
			return Math.sqrt(point.x * point.x + point.y * point.y);
		}
		
		public static function NormalizePoint(point:Point):void
		{
			var magnitude:Number = MagnitudePoint(point);
			point.x /= magnitude;
			point.y /= magnitude;
		}
	
	}

}