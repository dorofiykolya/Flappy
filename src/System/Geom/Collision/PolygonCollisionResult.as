package System.Geom.Collision 
{
	import flash.geom.Point;
	/**
	 * ...
	 * @author 
	 */
	public class PolygonCollisionResult 
	{
		public var WillIntersect:Boolean; // Are the polygons going to intersect forward in time?
		public var Intersect:Boolean; // Are the polygons currently intersecting
		public var MinimumTranslationVector:Point; // The translation to apply to polygon A to push the polygons appart.
		
		public function PolygonCollisionResult() 
		{
			
		}
		
	}

}