package System.Application.Managers 
{
	import core.Application;
	import flash.display.Stage;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import System.Delegate;
	import System.IDelegate;
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class DisplayStateManager 
	{
		private static var fullScreenInteractiveAccepted:Delegate = new Delegate();
		
		public function DisplayStateManager() 
		{
			Application.stage.addEventListener("fullScreenInteractiveAccepted", onFullScreenInteractiveAcceptedHandler);
		}
		
		private function onFullScreenInteractiveAcceptedHandler(e:Event):void 
		{
			fullScreenInteractiveAccepted.Invoke();
		}
		
		public function get OnFullScreenInteractiveAccepted():IDelegate
		{
			return fullScreenInteractiveAccepted;
		}
		
		public function get CurrentState():String
		{
			return Application.stage.displayState;
		}
		
		public function get IsNormal():Boolean
		{
			return Application.stage.displayState == StageDisplayState.NORMAL;
		}
		
		public function get IsFullScreen():Boolean
		{
			return Application.stage.displayState == StageDisplayState.FULL_SCREEN;
		}
		
		public function get IsFullScreenInteractive():Boolean
		{
			return Application.stage.displayState == StageDisplayState.FULL_SCREEN_INTERACTIVE;
		}
		
		public function get IsFullScreenOrFullScreenInteractive():Boolean
		{
			return Application.stage.displayState == StageDisplayState.FULL_SCREEN_INTERACTIVE || Application.stage.displayState == StageDisplayState.FULL_SCREEN;
		}
		
		public function Normal():void
		{
			Application.stage.displayState = StageDisplayState.NORMAL;
		}
		
		public function FullScreen():void
		{
			Application.stage.displayState = StageDisplayState.FULL_SCREEN;
		}
		
		public function FullScreenInteractive():void
		{
			Application.stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
		}
		
		////////////////////
		
		public static function get OnFullScreenInteractiveAccepted():IDelegate
		{
			return fullScreenInteractiveAccepted;
		}
		
		public static function get CurrentState():String
		{
			return Application.stage.displayState;
		}
		
		public static function get IsNormal():Boolean
		{
			return Application.stage.displayState == StageDisplayState.NORMAL;
		}
		
		public static function get IsFullScreen():Boolean
		{
			return Application.stage.displayState == StageDisplayState.FULL_SCREEN;
		}
		
		public static function get IsFullScreenInteractive():Boolean
		{
			return Application.stage.displayState == StageDisplayState.FULL_SCREEN_INTERACTIVE;
		}
		
		public static function get IsFullScreenOrFullScreenInteractive():Boolean
		{
			return Application.stage.displayState == StageDisplayState.FULL_SCREEN_INTERACTIVE || Application.stage.displayState == StageDisplayState.FULL_SCREEN;
		}
		
		public static function Normal():void
		{
			Application.stage.displayState = StageDisplayState.NORMAL;
		}
		
		public static function FullScreen():void
		{
			Application.stage.displayState = StageDisplayState.FULL_SCREEN;
		}
		
		public static function FullScreenInteractive():void
		{
			Application.stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
		}
		
	}

}