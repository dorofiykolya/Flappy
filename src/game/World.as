package game
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import starling.animation.IAnimatable;
	import starling.animation.Tween;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class World extends Sprite implements IAnimatable
	{
		private static const sHelpRect:Rectangle = new Rectangle();
		private static const sHelpPoint:Point = new Point();
		
		public var distance:int;
		
		private var _context:Context;
		private var _actor:Actor;
		private var _parallax:Parallax;
		private var _obstacles:Sprite;
		private var _background:Image;
		private var _land:Image;
		private var _bounds:Rectangle;
		private var _index:int;
		private var _worldObjects:Vector.<Obstacle>;
		private var _shake:Tween;
		private var _generator:Array = [1, 1, 1, 1, 5, 5, 5, 5, 1, 2, 3, 2, 1, 1, 2, 1, 3, 4, 5, 4, 5, 4, 5, 3, 2, 3, 4, 5, 4, 5, 4, 3, 2, 1, 1, 2, 2, 3, 1, 2, 3, 1, 2, 1, 2, 3, 4, 5, 4, 3, 2, 1, 2, 1, 3, 3, 4, 5, 4, 2, 4, 5, 4, 3, 2, 1, 2, 3, 4, 5, 4, 3, 2, 5, 1, 2, 4, 4, 3, 4, 3, 4, 2, 1, 4, 5, 4, 3, 2, 3, 5, 3, 1, 2, 3, 4, 5, 4, 2, 4, 2, 3, 1];
		private var _generatorIndex:int;
		
		public function World(context:Context, actor:Actor)
		{
			super();
			_context = context;
			_actor = actor;
			_bounds = new Rectangle();
			_obstacles = new Sprite();
			_worldObjects = new Vector.<Obstacle>();
			
			_background = new Image(context.assets.getTexture(AssetConstant.BG));
			_background.getBounds(_background, sHelpRect);
			_bounds.copyFrom(sHelpRect);
			context.bounds = _bounds;
			
			_land = new Image(context.assets.getTexture(AssetConstant.LAND));
			_land.y = _background.height - _land.height;
			_parallax = new Parallax(context, _bounds, Constant.SPEED);
			_parallax.AddChild(_background);
			_parallax.AddChild(_land);
			
			_obstacles.clipRect = new Rectangle();
			_obstacles.clipRect.copyFrom(_bounds);
			_obstacles.clipRect.height -= _land.height;
			
			AddChild(_parallax);
			AddChild(_obstacles);
			AddChild(_actor);
			
			_context.juggler.add(this);
			clipRect = _bounds;
			_shake = new Tween(this, 1);
			
			generate();
			reset();
			_shake.reset(this, 0);
		}
		
		public function reset():void
		{
			_context.isStart = false;
			_context.isGameOver = false;
			_context.timeScale = 0.0;
			_actor.x = 100;
			_actor.y = _bounds.height / 2;
			_actor.rotation = 0;
			_shake.reset(this, 0);
			distance = 0;
			x = y = 0;
			
			for each (var item:Obstacle in _worldObjects)
			{
				item.x += _bounds.width;
			}
			
			_actor.target = _worldObjects[0];
		}
		
		public function start():void
		{
			_context.isStart = true;
			_context.isGameOver = false;
			_actor.play();
			_context.timeScale = 1.0;
			_actor.x = 100;
			_actor.y = _bounds.height / 2;
			_actor.rotation = 0;
			_shake.reset(this, 0);
			distance = 0;
			x = y = 0;
			
			_actor.target = _worldObjects[0];
		}
		
		public function gameOver():void
		{
			if (_context.isGameOver == false)
			{
				_context.game.lastDistance = Math.max(distance, _context.game.lastDistance);
				_context.saveScore(_context.game.lastDistance);
				_context.game.gameOver();
				_actor.speed = 0;
				_actor.stop();
				_actor.gameOver();
				_context.timeScale = 1.0;
				_context.isGameOver = true;
				_context.isStart = false;
				_context.sound.playHit();
				shake();
			}
		}
		
		public function shake():void
		{
			_shake.reset(this, 1.5);
			_shake.onUpdate = function():void
			{
				x = int(Math.random() * 8 - 4);
				y = int(Math.random() * 8 - 4);
			}
			_shake.onComplete = function():void
			{
				x = y = 0;
			}
			_context.juggler.add(_shake);
		}
		
		public function advanceTime(time:Number):void
		{
			_actor.update(time);
			
			if (_context.isStart)
			{
				for each (var item:Obstacle in _worldObjects)
				{
					item.x -= time * Constant.SPEED * _context.timeScale;
				}
				for each (item in _worldObjects)
				{
					_actor.collision.x = _actor.x;
					_actor.collision.y = _actor.y;
					
					if (_actor.collision.IntersectionRectangle(item.up.getBounds(_obstacles, sHelpRect)))
					{
						gameOver();
					}
					else if (_actor.collision.IntersectionRectangle(item.down.getBounds(_obstacles, sHelpRect)))
					{
						gameOver();
					}
				}
				if (_actor.y > _bounds.height - Constant.BOTTOM_HEIGHT)
				{
					gameOver();
				}
			}
			if (_context.isStart)
			{
				update();
			}
			
			if (_actor.target.x + _actor.target.width < _actor.x)
			{
				distance++;
				if (distance % 10 == 0)
				{
					_context.sound.playCoin10();
				}
				else
				{
					_context.sound.playCoin();
				}
				if (_actor.target == _worldObjects[1])
				{
					_actor.target = _worldObjects[2];
				}
				else
				{
					_actor.target = _worldObjects[1];
				}
				
			}
			_context.game.setDistance(distance);
		}
		
		private function update():void
		{
			var obstacle:Obstacle = _worldObjects[0];
			var last:Obstacle;
			while (obstacle.x + obstacle.width < 0)
			{
				_worldObjects.shift();
				last = _worldObjects[_worldObjects.length - 1];
				_worldObjects[_worldObjects.length] = obstacle;
				obstacle.x = (last.x + last.width) + Constant.OBSTACLE_OFFSET;
				_generatorIndex++;
				if (_generatorIndex >= _generator.length)
				{
					_generatorIndex = 0;
				}
				obstacle.update(_generator[_generatorIndex]);
			}
		}
		
		private function generate():void
		{
			var obstacle:Obstacle;
			var pos:Number = 0;
			while (pos < _bounds.width * 2)
			{
				obstacle = new Obstacle(_context, _bounds);
				obstacle.x = pos;
				pos += obstacle.width + Constant.OBSTACLE_OFFSET;
				_worldObjects[_worldObjects.length] = obstacle;
				_generatorIndex++;
				if (_generatorIndex >= _generator.length)
				{
					_generatorIndex = 0;
				}
				obstacle.update(_generatorIndex);
				_obstacles.AddChild(obstacle);
			}
		}
	}
}