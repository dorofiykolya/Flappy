package starling.display
{
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import starling.core.RenderSupport;
	import starling.core.Starling;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.filters.FragmentFilter;
	import starling.utils.MatrixUtil;
	import starling.utils.scroller.Orientation;
	import starling.utils.scroller.Scroller;
	import starling.utils.ScrollRectManager;
	import starling.core.starling_internal;
	/**
	 * ...
	 * @author dorofiy.com
	 */
	use namespace starling_internal;
	
	public class ScrollerDisplayObjectContainer extends DisplayObjectContainer
	{
		public static const LAYOUT_HORIZONTAL:String = "layout_horizontal";
		public static const LAYOUT_VERTICAL:String = "layout_vertical";
		
		private static var sHelperRect:Rectangle = new Rectangle();
		private static var sHelperMatrix:Matrix = new Matrix();
		private static var sHelperPoint:Point = new Point();
		private static var sBroadcastListeners:Vector.<DisplayObject> = new <DisplayObject>[];
		
		private var mScaledScrollRectXY:Point;
		private var mScissorRect:Rectangle;
		private var mChildren:Vector.<DisplayObject> = new Vector.<DisplayObject>();
		private var mScrollRect:Rectangle = new Rectangle();
		
		private var invalidateLayout:Boolean = false;
		private var invalidateChildren:Boolean = false;
		private var invalidateScroll:Boolean = false;
		
		private var mLayout:String = LAYOUT_HORIZONTAL;
		private var mSize:Rectangle = new Rectangle();
		
		private var mScroller:Scroller = new Scroller();
		private var view:ScrollerView = new ScrollerView();
		
		public function ScrollerDisplayObjectContainer(width:int = 500, height:int = 500)
		{
			addEventListener(TouchEvent.TOUCH, onTouch);
			mScroller.boundWidth = width; // set boundWidth according to the mask width
			mScroller.boundHeight = height; // set boundHeight according to the mask height
		    mScroller.content = view; // you MUST set scroller content before doing anything else
		  
		    mScroller.orientation = Orientation.VERTICAL; // accepted values: Orientation.AUTO, Orientation.VERTICAL, Orientation.HORIZONTAL
		   //mScroller.easeType = Easing.Expo_easeOut;
		    mScroller.duration = .5;
		    mScroller.holdArea = 10;
		    mScroller.isStickTouch = false;
			AddChild(view);
			this.scrollRect = new Rectangle(0, 0, width, height);
			this.width = width;
			this.height = height;
		}
		
		override public function get height():Number 
		{
			return mSize.height;
		}
		
		override public function set height(value:Number):void 
		{
			mScrollRect.height = value;
			mScroller.boundHeight = value;
			mSize.height = height;
		}
		
		override public function get width():Number 
		{
			return mSize.width;
		}
		
		override public function set width(value:Number):void 
		{
			mScrollRect.width = value;
			mScroller.boundWidth = value;
			mSize.width = value;
		}
		
		private function onTouch(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(stage);
			var pos:Point = touch.getLocation(stage);
			
			if (touch.phase == TouchPhase.BEGAN)
			{
				mScroller.startScroll(pos); // on touch begin
			}
			else if (touch.phase == TouchPhase.MOVED)
			{
				mScroller.startScroll(pos); // on touch move
			}
			else if (touch.phase == TouchPhase.ENDED)
			{
				mScroller.fling(); // on touch ended
			}
		}
		
		public function get layout():String
		{
			return mLayout;
		}
		
		public function set layout(value:String):void
		{
			if (value == LAYOUT_HORIZONTAL || value == LAYOUT_VERTICAL)
			{
				switch(value) {
					case LAYOUT_HORIZONTAL:
						mScroller.orientation = Orientation.HORIZONTAL;
						view.setHorizontal();
						break;
					case LAYOUT_VERTICAL:
						mScroller.orientation = Orientation.VERTICAL;
						view.setVertical();
						break;
				}
				mLayout = value;
				invalidateLayout = true;
			}
		}
		
		public function get scrollRect():Rectangle
		{
			return this.mScrollRect;
		}
		
		public function set scrollRect(value:Rectangle):void
		{
			this.mScrollRect = value;
			if (this.mScrollRect)
			{
				if (!this.mScaledScrollRectXY)
				{
					this.mScaledScrollRectXY = new Point();
				}
				if (!this.mScissorRect)
				{
					this.mScissorRect = new Rectangle();
				}
			}
			else
			{
				this.mScaledScrollRectXY = null;
				this.mScissorRect = null;
			}
		}
		
		override public function addChild(child:DisplayObject):DisplayObject
		{
			return view.addChild(child);
		}
		
		override public function addChildAt(child:DisplayObject, index:int):DisplayObject
		{
			return view.addChildAt(child, index);
		}
		
		override public function removeChild(child:DisplayObject, dispose:Boolean = false):DisplayObject
		{
			return view.removeChild(child, dispose);
		}
		
		override public function removeChildAt(index:int, dispose:Boolean = false):DisplayObject
		{
			return view.removeChildAt(index, dispose);
		}
		
		override public function removeChildren(beginIndex:int = 0, endIndex:int = -1, dispose:Boolean = false):void
		{
			view.removeChildren(beginIndex, endIndex, dispose);
		}
		
		override public function getChildAt(index:int):DisplayObject
		{
			return view.getChildAt(index);
		}
		
		override public function getChildByName(name:String):DisplayObject
		{
			return view.getChildByName(name);
		}
		
		override public function getChildIndex(child:DisplayObject):int
		{
			return view.getChildIndex(child);
		}
		
		override public function setChildIndex(child:DisplayObject, index:int):void
		{
			view.setChildIndex(child, index);
		}
		
		override public function swapChildren(child1:DisplayObject, child2:DisplayObject):void
		{
			view.swapChildren(child1, child2);
		}
		
		override public function swapChildrenAt(index1:int, index2:int):void
		{
			view.swapChildrenAt(index1, index2);
		}
		
		override public function sortChildren(compareFunction:Function):void
		{
			view.sortChildren(compareFunction);
		}
		
		override public function contains(child:DisplayObject):Boolean
		{
			return view.contains(child);
		}
		
		override public function getBounds(targetSpace:DisplayObject, resultRect:Rectangle = null):Rectangle
		{
			if (this.mScrollRect)
			{
				if (!resultRect)
				{
					resultRect = new Rectangle();
				}
				if (targetSpace == this)
				{
					resultRect.x = 0;
					resultRect.y = 0;
					resultRect.width = this.mScrollRect.width;
					resultRect.height = this.mScrollRect.height;
				}
				else
				{
					this.getTransformationMatrix(targetSpace, sHelperMatrix);
					MatrixUtil.transformCoords(sHelperMatrix, 0, 0, sHelperPoint);
					resultRect.x = sHelperPoint.x;
					resultRect.y = sHelperPoint.y;
					resultRect.width = sHelperMatrix.a * this.mScrollRect.width + sHelperMatrix.c * this.mScrollRect.height;
					resultRect.height = sHelperMatrix.d * this.mScrollRect.height + sHelperMatrix.b * this.mScrollRect.width;
				}
				return resultRect;
			}
			
			return super.getBounds(targetSpace, resultRect);
		}
		
		override public function render(support:RenderSupport, alpha:Number):void
		{
			if (invalidateLayout) {
				view.validateLayout();
				invalidateLayout = false;
			}
			if (invalidateChildren) {
				view.validateChildren();
				invalidateChildren = false;
			}
			if (invalidateScroll) {
				view.validateScroll();
				invalidateScroll = false;
			}
			
			if (this.mScrollRect)
			{
				const scale:Number = Starling.contentScaleFactor;
				this.getBounds(this.stage, this.mScissorRect);
				this.mScissorRect.x *= scale;
				this.mScissorRect.y *= scale;
				this.mScissorRect.width *= scale;
				this.mScissorRect.height *= scale;
				
				this.getTransformationMatrix(this.stage, sHelperMatrix);
				this.mScaledScrollRectXY.x = this.mScrollRect.x * sHelperMatrix.a;
				this.mScaledScrollRectXY.y = this.mScrollRect.y * sHelperMatrix.d;
				
				const oldRect:Rectangle = ScrollRectManager.currentScissorRect;
				if (oldRect)
				{
					this.mScissorRect.x += ScrollRectManager.scrollRectOffsetX * scale;
					this.mScissorRect.y += ScrollRectManager.scrollRectOffsetY * scale;
					this.mScissorRect = this.mScissorRect.intersection(oldRect);
				}
				//isEmpty() && <= 0 don't work here for some reason
				if (this.mScissorRect.width < 1 || this.mScissorRect.height < 1 || this.mScissorRect.x >= Starling.current.nativeStage.stageWidth || this.mScissorRect.y >= Starling.current.nativeStage.stageHeight || (this.mScissorRect.x + this.mScissorRect.width) <= 0 || (this.mScissorRect.y + this.mScissorRect.height) <= 0)
				{
					return;
				}
				support.finishQuadBatch();
				Starling.context.setScissorRectangle(this.mScissorRect);
				ScrollRectManager.currentScissorRect = this.mScissorRect;
				ScrollRectManager.scrollRectOffsetX -= this.mScaledScrollRectXY.x;
				ScrollRectManager.scrollRectOffsetY -= this.mScaledScrollRectXY.y;
				support.translateMatrix(-this.mScrollRect.x, -this.mScrollRect.y);
			}
			view.render(support, alpha);
			if (this.mScrollRect)
			{
				support.finishQuadBatch();
				support.translateMatrix(this.mScrollRect.x, this.mScrollRect.y);
				ScrollRectManager.scrollRectOffsetX += this.mScaledScrollRectXY.x;
				ScrollRectManager.scrollRectOffsetY += this.mScaledScrollRectXY.y;
				ScrollRectManager.currentScissorRect = oldRect;
				Starling.context.setScissorRectangle(oldRect);
			}
		}
		
		/**
		 * @inheritDoc
		 */
		override public function hitTest(localPoint:Point, forTouch:Boolean = false):DisplayObject
		{
			if (this.mScrollRect)
			{
				//make sure we're in the bounds of this sprite first
				if (this.getBounds(this, sHelperRect).containsPoint(localPoint))
				{
					localPoint.x += this.mScrollRect.x;
					localPoint.y += this.mScrollRect.y;
					var result:DisplayObject = view.hitTest(localPoint, forTouch);
					localPoint.x -= this.mScrollRect.x;
					localPoint.y -= this.mScrollRect.y;
					return result;
				}
				return null;
			}
			return view.hitTest(localPoint, forTouch);
		}
		
		protected function _hitTest(localPoint:Point, forTouch:Boolean = false):DisplayObject
		{
			if (forTouch && (!visible || !touchable))
				return null;
			
			var localX:Number = localPoint.x;
			var localY:Number = localPoint.y;
			
			var numChildren:int = mChildren.length;
			for (var i:int = numChildren - 1; i >= 0; --i) // front to back!
			{
				var child:DisplayObject = mChildren[i];
				getTransformationMatrix(child, sHelperMatrix);
				
				MatrixUtil.transformCoords(sHelperMatrix, localX, localY, sHelperPoint);
				var target:DisplayObject = child.hitTest(sHelperPoint, forTouch);
				
				if (target)
					return target;
			}
			
			return null;
		}
		
		protected function _render(support:RenderSupport, parentAlpha:Number):void
		{
			var alpha:Number = parentAlpha * this.alpha;
			var numChildren:int = mChildren.length;
			var blendMode:String = support.blendMode;
			
			for (var i:int = 0; i < numChildren; ++i)
			{
				var child:DisplayObject = mChildren[i];
				
				if (child.hasVisibleArea)
				{
					var filter:FragmentFilter = child.filter;
					
					support.pushMatrix();
					support.transformMatrix(child);
					support.blendMode = child.blendMode;
					
					if (filter)
						filter.render(child, support, alpha);
					else
						child.render(support, alpha);
					
					support.blendMode = blendMode;
					support.popMatrix();
				}
			}
		}
		
		override public function broadcastEvent(event:Event):void
		{
			view.broadcastEvent(event);
		}
		
		override public function broadcastEventWith(type:String, data:Object = null):void
		{
			view.broadcastEventWith(type, data);
		}
		
		private function getChildEventListeners(object:DisplayObject, eventType:String, listeners:Vector.<DisplayObject>):void
		{
			var container:DisplayObjectContainer = object as DisplayObjectContainer;
			
			if (object.hasEventListener(eventType))
				listeners.push(object);
			
			if (container)
			{
				var children:Vector.<DisplayObject> = container.children;
				var numChildren:int = children.length;
				
				for (var i:int = 0; i < numChildren; ++i)
					getChildEventListeners(children[i], eventType, listeners);
			}
		}
		
		override public function get numChildren():int
		{
			return view.numChildren;
		}
		
		override public function get children():Vector.<DisplayObject>
		{
			return view.children;
		}
		
		override public function set children(v:Vector.<DisplayObject>):void
		{
			if (v == null)
			{
				view.children = new Vector.<DisplayObject>();
			}
			else
			{
				view.children = v;
			}
		}
	}

}