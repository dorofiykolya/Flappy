package System.Application.Managers
{
	import flash.display.Stage;
	
	/**
	 * ...
	 * @author dorofiy
	 */
	public class ApplicationManager
	{
		private static var _hotkeyManager:HotKeyManager;
		private static var _systemManager:SystemManager;
		private static var _keyBoardManager:KeyboardManager;
		private static var _taskManager:TaskManager;
		private static var _qualityManager:QualityManager;
		private static var _nativeManager:NativeManager;
		private static var _displayState:DisplayStateManager;
		
		public function ApplicationManager(stage:Stage):void
		{
			_hotkeyManager = new HotKeyManager();
			_systemManager = new SystemManager();
			_keyBoardManager = new KeyboardManager();
			_nativeManager = new NativeManager();
			_taskManager = new TaskManager();
			_qualityManager = new QualityManager();
			_displayState = new DisplayStateManager();
		}
		
		public function get DisplayState():DisplayStateManager
		{
			return _displayState;
		}
		
		public function get Task():TaskManager
		{
			return _taskManager;
		}
		
		public function get Quality():QualityManager
		{
			return _qualityManager;
		}
		
		public function get Keyboard():KeyboardManager
		{
			return _keyBoardManager;
		}
		
		public function get HotKey():HotKeyManager
		{
			return _hotkeyManager;
		}
		
		public function get System():SystemManager
		{
			return _systemManager;
		}
		
		public function get Native():NativeManager
		{
			return _nativeManager;
		}
	}

}