package game
{
	import game.Game;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import System.Geom.Circle;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class Actor extends MovieClip
	{
		private var _isDown:Boolean;
		
		public var upCoef:Number = Constant.ACTOR_UP_COEF;
		public var gravity:Number = Constant.ACTOR_GRAVITY;
		
		public var context:Context;
		public var target:Obstacle;
		public var collision:Circle;
		public var speed:Number;
		
		public function Actor(context:Context)
		{
			super(context.assets.getTextures(AssetConstant.BIRD));
			this.context = context;
			context.juggler.add(this);
			collision = new Circle(0, 0, width / 3.5);
			alignPivot();
			play();
			speed = 0;
		}
		
		public function up():void
		{
			speed = -upCoef * context.timeScale;
			rotation = -Math.PI / 6;
			_isDown = false;
			context.sound.playJump();
		}
		
		public function update(deltaTime:Number):void
		{
			if (context.isStart || context.isGameOver)
			{
				speed += gravity * deltaTime * context.timeScale;
				y += speed;
				if (y <= 0)
				{
					y = 0;
				}
				else if (y > context.bounds.height - Constant.BOTTOM_HEIGHT + 10)
				{
					y = context.bounds.height - Constant.BOTTOM_HEIGHT + 10;
					speed = 0;
					if (_isDown == false)
					{
						context.sound.playHitDown();
						_isDown = true;
					}
				}
				
				var targetRotation:Number = Math.PI / 2;
				rotation += targetRotation * deltaTime * context.timeScale * 1.5;
				rotation = Math.min(rotation, targetRotation);
			}
		}
		
		public function gameOver():void
		{
			var targetRotation:Number = Math.PI / 2;
			rotation = targetRotation;
		}
	
	}

}