package System.Application.Managers
{
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import System.Delegate;
	import System.IDelegate;
	/**
	 * ...
	 * @author dorofiy
	 */
	[Event(name="keyDown",type="flash.events.KeyboardEvent")]
	[Event(name="keyUp",type="flash.events.KeyboardEvent")]
	
	public class KeyboardManager
	{
		
		private static var _altKey:Boolean;
		private static var _ctrlKey:Boolean;
		private static var _shiftKey:Boolean;
		
		private static const _onKeyDown:Delegate = new Delegate();
		private static const _onKeyUp:Delegate = new Delegate();
		
		private static const _device:KeyboardDeviceManager = new KeyboardDeviceManager();
		
		private static var _stage:Stage;
		
		public function KeyboardManager(stage:Stage)
		{
			_stage = stage;
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		}
		
		private function onKeyUp(e:KeyboardEvent):void
		{
			_altKey = e.altKey;
			_ctrlKey = e.ctrlKey;
			_shiftKey = e.shiftKey;
			_onKeyUp.Invoke(e);
		}
		
		private function onKeyDown(e:KeyboardEvent):void
		{
			_altKey = e.altKey;
			_ctrlKey = e.ctrlKey;
			_shiftKey = e.shiftKey;
			_onKeyDown.Invoke(e);
			if (Delegate(_device.OnBack).Count > 0 && Object(Keyboard).hasOwnProperty("BACK") && e.keyCode == Keyboard["BACK"])
			{
				e.stopImmediatePropagation();
				e.preventDefault();
				Delegate(_device.OnBack).Invoke();
			}
			
			if (Delegate(_device.OnMenu).Count > 0 && Object(Keyboard).hasOwnProperty("MENU") && e.keyCode == Keyboard["MENU"])
			{
				e.preventDefault();
				Delegate(_device.OnMenu).Invoke();
			}
			
			if (Delegate(_device.OnSearch).Count > 0 && Object(Keyboard).hasOwnProperty("SEARCH") && e.keyCode == Keyboard["SEARCH"])
			{
				e.preventDefault();
				Delegate(_device.OnSearch).Invoke();
			}
		}
		
		public function get Device():KeyboardDeviceManager
		{
			return _device;
		}
		
		public static function get Device():KeyboardDeviceManager
		{
			return _device;
		}
		
		public function get AltKey():Boolean
		{
			return _altKey;
		}
		
		public function get CtrlKey():Boolean
		{
			return _ctrlKey;
		}
		
		public function get ShiftKey():Boolean
		{
			return _shiftKey;
		}
		
		/**
		 * flash.events.KeyboardEvent
		 * function (e:KeyboardEvent):void {}
		 * @param KeyboardEvent
		 */
		public function get OnKeyDown():IDelegate
		{
			return _onKeyDown;
		}
		
		/**
		 * flash.events.KeyboardEvent
		 * function (e:KeyboardEvent):void {}
		 * @param KeyboardEvent
		 */
		public function get OnKeyUp():IDelegate
		{
			return _onKeyUp;
		}
		
		public static function get AltKey():Boolean
		{
			return _altKey;
		}
		
		public static function get CtrlKey():Boolean
		{
			return _ctrlKey;
		}
		
		public static function get ShiftKey():Boolean
		{
			return _shiftKey;
		}
		
		public static function get OnKeyDown():IDelegate
		{
			return _onKeyDown;
		}
		
		public static function get OnKeyUp():IDelegate
		{
			return _onKeyUp;
		}
		
		public static function AddEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
		{
			_stage.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		public static function RemoveEventListener(type:String, listener:Function, useCapture:Boolean = false):void
		{
			_stage.removeEventListener(type, listener, useCapture);
		}
		
		public static function HasEventListener(type:String):Boolean
		{
			return _stage.hasEventListener(type);
		}
		
		public function AddEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
		{
			_stage.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		public function RemoveEventListener(type:String, listener:Function, useCapture:Boolean = false):void
		{
			_stage.removeEventListener(type, listener, useCapture);
		}
		
		public function HasEventListener(type:String):Boolean
		{
			return _stage.hasEventListener(type);
		}
	}

}