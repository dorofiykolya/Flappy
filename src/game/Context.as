package game 
{
	import flash.display3D.Context3D;
	import flash.geom.Rectangle;
	import flash.net.SharedObject;
	import starling.animation.Juggler;
	import starling.core.Starling;
	import starling.display.Stage;
	import starling.utils.AssetManager;
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class Context 
	{
		public var timeScale:Number = 1;
		public var isGameOver:Boolean;
		public var isStart:Boolean;
		public var isTutorial:Boolean;
		public var bounds:Rectangle;
		
		private var _game:Game;
		private var _assets:AssetManager;
		private var _sounds:SoundManager;
		
		public function Context(game:Game, assets:AssetManager, soundManager:SoundManager) 
		{
			_game = game;
			_assets = assets;
			_sounds = soundManager;
		}
		
		public function get game():Game
		{
			return _game;
		}
		
		public function get assets():AssetManager
		{
			return _assets;
		}
		
		public function get sound():SoundManager
		{
			return _sounds;
		}
		
		public function get juggler():Juggler
		{
			return starling.juggler;
		}
		
		public function get stage():Stage
		{
			return starling.stage;
		}
		
		public function get starling():Starling
		{
			return Starling.current;
		}
		
		public function get context():Context3D
		{
			return starling.context;
		}
		
		public function loadScore():int
		{
			var share:SharedObject = SharedObject.getLocal(Constant.GAME_ID);
			if (share)
			{
				return share.data['score'];
			}
			return 0;
		}
		
		public function saveScore(score:int):void
		{
			var share:SharedObject = SharedObject.getLocal(Constant.GAME_ID);
			if (share)
			{
				share.data['score'] = score;
			}
		}
		
	}

}