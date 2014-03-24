package game 
{
	import flash.geom.Rectangle;
	import starling.display.Image;
	import starling.display.Sprite;
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class Obstacle extends Sprite
	{
		public var offset:int = Constant.OBSTACLE_GAP_OFFSET;
		public var part:int = Constant.OBSTACLE_PART;
		public var gap:Number = Constant.OBSTACLE_GAP;
		
		public var up:Image;
		public var down:Image;
		
		private var _min:Number;
		private var _max:Number;
		private var _context:Context;
		private var _bounds:Rectangle;
		
		public function Obstacle(context:Context, bounds:Rectangle) 
		{
			_context = context;
			_bounds = bounds;
			
			up = new Image(context.assets.getTexture(AssetConstant.PIPE_DOWN));
			down = new Image(context.assets.getTexture(AssetConstant.PIPE_UP));
			
			AddChild(up);
			AddChild(down);
			
			update(1);
			
			//_min = bounds.height - Constant.BOTTOM_HEIGHT - 50 - 50 - gap;
			//_max = bounds.height - Constant.BOTTOM_HEIGHT - 50 - 50 - down.height - gap;
		}
		
		public function update(index:int):void
		{
			//var coef:Number = _max - _min;
			//coef /= index;
			//coef += _min;
			//up.y = coef;
			//down.y = coef;
			
			up.y = index * part + offset - gap;
			down.y = _bounds.height - down.height + index * part + offset + gap;
		}
		
	}

}