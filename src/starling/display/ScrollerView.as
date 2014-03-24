package starling.display
{
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class ScrollerView extends DisplayObjectContainer
	{
		private var horizontal:Boolean = true;
		
		private var currentPos:int;
		
		public function ScrollerView()
		{
		
		}
		
		override public function addChild(child:DisplayObject):DisplayObject
		{
			if (horizontal) {
				child.x = currentPos;
			}else {
				child.y = currentPos;
			}
			currentPos += horizontal ? child.width : child.height;
			
			return super.addChild(child);
		}
		
		internal function setHorizontal():void
		{
			horizontal = true;
		}
		
		internal function setVertical():void
		{
			horizontal = false;
		}
		
		public function validateLayout():void
		{
		
		}
		
		public function validateChildren():void
		{
		
		}
		
		public function validateScroll():void
		{
		
		}
	
	}

}