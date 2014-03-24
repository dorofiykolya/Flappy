package game
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import starling.animation.IAnimatable;
	import starling.core.RenderSupport;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.QuadBatch;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class Parallax extends Sprite implements IAnimatable
	{
		private static const sHelpRect:Rectangle = new Rectangle();
		private static const sHelpPoint:Point = new Point();
		
		private var _context:Context;
		private var _bounds:Rectangle;
		private var _invalidated:Boolean;
		private var _quads:Vector.<QuadBatch>;
		private var _items:Vector.<DisplayObject>;
		private var _delay:Number
		
		public function Parallax(context:Context, bounds:Rectangle, delay:Number)
		{
			_context = context;
			_bounds = bounds;
			_quads = new Vector.<QuadBatch>();
			_items = new Vector.<DisplayObject>();
			_invalidated = true;
			_delay = delay;
			_context.juggler.add(this);
			
			clipRect = bounds;
		}
		
		public function advanceTime(time:Number):void
		{
			if (_context.isStart)
			{
				time *= _delay * _context.timeScale;
				if (_invalidated)
				{
					return;
				}
				var list:Vector.<DisplayObject> = children;
				var child:DisplayObject;
				var index:int = 1;
				for (var i:int = list.length - 1; i >= 0; i--, index++)
				{
					child = list[i];
					child.x -= (time * (1 / index));
					
					while (child.x + child.width < _bounds.width)
					{
						QuadBatch(child).getQuadBounds(0, null, sHelpRect);
						child.x += int(sHelpRect.width);
					}
				}
			}
		}
		
		override public function AddChild(child:DisplayObject, dispatchAdd:Boolean = false, dispatchAddToStage:Boolean = false):DisplayObject
		{
			_invalidated = true;
			return super.AddChild(child, dispatchAdd, dispatchAddToStage);
		}
		
		override public function render(support:RenderSupport, parentAlpha:Number):void
		{
			if (_invalidated)
			{
				validate();
			}
			super.render(support, parentAlpha);
		}
		
		private function validate():void
		{
			var batch:QuadBatch;
			var index:int;
			for each (var item:DisplayObject in children)
			{
				if (item is Quad)
				{
					item.getBounds(item, sHelpRect);
					batch = new QuadBatch();
					_quads[_quads.length] = batch;
					AddChild(batch);
					index = 0;
					while (batch.width < _bounds.width * 2)
					{
						item.x = index++ * sHelpRect.width;
						if (item is Image)
						{
							batch.addImage(Image(item));
						}
						else
						{
							batch.addQuad(Quad(item));
						}
					}
					batch.x = 0; // _bounds.width - batch.width;
				}
			}
			
			main: while (true)
			{
				inner: for each (var child:DisplayObject in children)
				{
					if ((child is QuadBatch) == false)
					{
						child.RemoveFromParent();
						continue main;
					}
				}
				break main;
			}
			
			_invalidated = false;
		}
	
	}

}