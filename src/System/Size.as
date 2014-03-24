package System
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class Size implements ICloneable, IEquals
	{
		public var width:Number;
		public var height:Number;
		
		public function Size(width:Number = 0, height:Number = 0)
		{
			this.width = width;
			this.height = height;
		}
		
		public function Add(width:Number = 0, height:Number = 0):Size
		{
			this.width += width;
			this.height += height;
			return this;
		}
		
		public function Set(width:Number, height:Number):Size
		{
			this.width = width;
			this.height = height;
			return this;
		}
		
		public function Equals(v:Object):Boolean
		{
			if (v == this) 
			{
				return true;
			}
			if (v == null || v is Size == false)
			{
				return false;
			}
			return width == v.width && height == v.height;
		}
		
		public function Clone():Object
		{
			return new Size(width, height);
		}
		
		public function toString():String
		{
			return "[Size width=" + width + ", height=" + height + " ]";
		}
		
		public function CopyFrom(size:Size):Size
		{
			width = size.width;
			height = size.height;
			return this;
		}
		
		public function ToRectangle(x:Number = 0, y:Number = 0):Rectangle
		{
			return new Rectangle(x, y, width, height);
		}
		
		public function ToPoint():Point
		{
			return new Point(width, height);
		}
		
		public function HasPoint(localPoint:Point):Boolean
		{
			return localPoint.x >= 0 && localPoint.x <= width && localPoint.y >= 0 && localPoint.y <= height;
		}
	
	}

}