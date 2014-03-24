package System.Application.Managers
{
	import System.Delegate;
	import System.IDelegate;
	
	/**
	 * ...
	 * @author dorofiy
	 */
	public class KeyboardDeviceManager
	{
		private static const _OnDeviceBACK:Delegate = new Delegate();
		private static const _OnDeviceMENU:Delegate = new Delegate();
		private static const _OnDeviceSEARCH:Delegate = new Delegate();
		
		public function get OnBack():IDelegate
		{
			return _OnDeviceBACK;
		}
		
		public function get OnMenu():IDelegate
		{
			return _OnDeviceMENU;
		}
		
		public function get OnSearch():IDelegate
		{
			return _OnDeviceSEARCH;
		}
		
		public static function get OnBack():IDelegate
		{
			return _OnDeviceBACK;
		}
		
		public static function get OnMenu():IDelegate
		{
			return _OnDeviceMENU;
		}
		
		public static function get OnSearch():IDelegate
		{
			return _OnDeviceSEARCH;
		}
	
	}

}