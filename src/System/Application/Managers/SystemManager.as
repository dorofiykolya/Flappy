package System.Application.Managers
{
	import flash.display.Stage;
	import System.State.StateManager;
	
	/**
	 * ...
	 * @author dorofiy
	 */
	public class SystemManager
	{
		private static var _statesManager:StateManager = new StateManager(null);
		
		public function SystemManager(stage:Stage)
		{
		
		}
		
		public static function get State():StateManager
		{
			return _statesManager;
		}
		
		public function get State():StateManager
		{
			return _statesManager;
		}
	}

}