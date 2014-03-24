package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import game.Game;
	import starling.core.Starling;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class Main extends Sprite 
	{
		private var starling:Starling;
		
		public function Main():void 
		{
			if (stage)
			{
				toStage();
			}
			else
			{
				addEventListener(Event.ADDED_TO_STAGE, toStage);
			}
			addEventListener(Event.ACTIVATE, onActive);
			addEventListener(Event.DEACTIVATE, onDeactive);
		}
		
		private function onDeactive(e:Event):void 
		{
			if (starling)
			{
				starling.stop();
			}
		}
		
		private function onActive(e:Event):void 
		{
			if (starling)
			{
				starling.start();
			}
		}
		
		private function toStage(e:Event = null):void 
		{
			stage.frameRate = 60;
			removeEventListener(Event.ADDED_TO_STAGE, toStage);
			stage.addEventListener(Event.RESIZE, onResize);
			
			Starling.multitouchEnabled = true;
			Starling.handleLostContext = true;
			starling = new Starling(Game, stage, new Rectangle(0, 0, Constant.WIDTH, Constant.HEIGHT));
			starling.showStats = true;
			starling.showStatsAt();
			starling.simulateMultitouch = true;
			starling.start();
			
			onResize();
		}
		
		private function onResize(e:Event = null):void 
		{
			if (starling)
			{
				starling.viewPort.width = stage.stageWidth;
				starling.viewPort.height = stage.stageHeight;
				starling.viewPort = starling.viewPort;
			}
		}
		
	}
	
}