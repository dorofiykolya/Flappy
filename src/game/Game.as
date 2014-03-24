package game
{
	import flash.display3D.Context3D;
	import flash.geom.Rectangle;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.text.TextFieldAutoSize;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.utils.AssetManager;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class Game extends Sprite
	{
		[Embed(source="../atlas.png")]
		private static const ATLAS:Class;
		[Embed(source="../starling.xml",mimeType="application/octet-stream")]
		private static const ATLAS_XML:Class;
		
		public var lastDistance:int;
		
		private var _context:Context;
		private var _coin:Image;
		private var _tutrorial:Image;
		private var _gameOver:Image;
		private var _getReady:Image;
		private var _distanceText:TextField;
		private var _assets:AssetManager;
		private var _actor:Actor;
		private var _world:World;
		private var _soundManager:SoundManager;
		
		public function Game()
		{
			_soundManager = new SoundManager();
			_assets = new AssetManager();
			_assets.addTextureAtlas("game", new TextureAtlas(Texture.fromEmbeddedAsset(ATLAS), new XML(String(new ATLAS_XML))));
			_coin = new Image(_assets.getTexture(AssetConstant.MEDALS_0));
			_tutrorial = new Image(_assets.getTexture(AssetConstant.TUTORIAL));
			_gameOver = new Image(_assets.getTexture(AssetConstant.TEXT_GAME_OVER));
			_getReady = new Image(_assets.getTexture(AssetConstant.TEXT_READY));
			_context = new Context(this, _assets, _soundManager);
			_context.isTutorial = true;
			_actor = new Actor(_context);
			_world = new World(_context, _actor);
			AddChild(_world);
			
			_distanceText = new TextField(Constant.WIDTH, _coin.height, "0", BitmapFont.MINI, 26, 0xffffff);
			_distanceText.autoSize = TextFieldAutoSize.HORIZONTAL;
			AddChild(_distanceText);
			AddChild(_coin);
			AddChild(_tutrorial);
			
			_context.starling.stage.addEventListener(TouchEvent.TOUCH, onTouch);
			
			lastDistance = _context.loadScore();
			validatePosition();
			
		}
		
		private function onTouch(e:TouchEvent):void 
		{
			var t:Touch = e.getTouch(_context.stage, TouchPhase.BEGAN);
			if (t)
			{
				if (_context.isTutorial)
				{
					_context.isTutorial = false;
					_tutrorial.RemoveFromParent();
					_world.start();
					_actor.up();
					return;
				}
				if (_context.isGameOver)
				{
					_world.reset();
					AddChild(_getReady);
					_gameOver.RemoveFromParent();
				}
				else if (_context.isStart)
				{
					_actor.up();
				}
				else
				{
					_getReady.RemoveFromParent();
					_world.start();
					_actor.up();
				}
			}
		}
		
		public function gameOver():void 
		{
			AddChild(_gameOver);
		}
		
		public function setDistance(value:int):void
		{
			_distanceText.text = value.toString() + "/" + lastDistance;
			if (value < 10)
			{
				_coin.texture = _assets.getTexture(AssetConstant.MEDALS_0);
			}
			else if (value >= 10 && value < 20)
			{
				_coin.texture = _assets.getTexture(AssetConstant.MEDALS_3);
			}
			else if (value >= 20 && value < 30)
			{
				_coin.texture = _assets.getTexture(AssetConstant.MEDALS_2);
			}
			else if (value >= 30)
			{
				_coin.texture = _assets.getTexture(AssetConstant.MEDALS_1);
			}
			validatePosition();
		}
		
		private function validatePosition():void
		{
			var screen:Rectangle = new Rectangle(0, 0, Constant.WIDTH, Constant.HEIGHT);
			AlignSupports.AlignHorizontalCenterItems(screen, new <Object>[_coin, _distanceText],0, 10);
			AlignSupports.AlignHorizontalCenter(screen, _tutrorial);
			AlignSupports.AlignHorizontalCenter(screen, _gameOver);
			AlignSupports.AlignHorizontalCenter(screen, _getReady);
			AlignSupports.AlignVerticalCenter(screen, _tutrorial);
			AlignSupports.AlignVerticalCenter(screen, _gameOver);
			AlignSupports.AlignVerticalCenter(screen, _getReady, -75);
		}
		
		public function get world():World
		{
			return _world;
		}
		
		public function get cotext():Context
		{
			return _context;
		}
	
	}

}