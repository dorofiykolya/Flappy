package System.Application.Managers
{
	import core.Application;
	import flash.utils.getDefinitionByName;
	import flash.display.Stage;
	
	/**
	 * ...
	 * @author dorofiy
	 */
	public class NativeManager
	{
		private var stage:Stage;
		private var isSupport:Boolean;
		private var nativeWindow:Object;
		private var isSupportNotification:Boolean;
		
		public function NativeManager()
		{
			stage = Application.stage;
			var result:Object;
			var window:Class;
			try
			{
				window = Class(getDefinitionByName('flash.display.NativeWindow'));
				if (window)
				{
					isSupportNotification = Boolean(window.supportsNotification);
					result = Object(stage).hasOwnProperty('nativeWindow')? stage['nativeWindow'] : null;
				}
			}
			catch (e:Error)
			{
				
			}
			isSupport = result != null;
			
			if (result == null)
			{
				result = { };
				result.minimize = function():void { };
				result.maximize = function():void { };
				result.restore = function():void { };
				result.activate = function():void { };
				result.notifyUser = function(type:String = null):void { };
			}
			
			nativeWindow = result;
		}
		
		public function get IsSupport():Boolean
		{
			return isSupport;
		}
		
		public function get IsSupportNotification():Boolean
		{
			return isSupportNotification;
		}
		
		public function Minimize():void
		{
			nativeWindow.minimize();
		}
		
		public function Maximize():void
		{
			nativeWindow.maximize();
		}
		
		public function Restore():void
		{
			nativeWindow.restore();
		}
		
		public function Activate():void
		{
			nativeWindow.activate();
		}
		
		public function NotifyUserCritical():void
		{
			if (isSupportNotification == false)
			{
				return;
			}
			nativeWindow.notifyUser('critical');
		}
		
		public function NotifyUserInformational():void
		{
			if (isSupportNotification == false)
			{
				return;
			}
			nativeWindow.notifyUser('informational');  
		}
		
		public function Exit(errorCode:int = 0):void
		{
			try
			{
				getDefinitionByName("flash.desktop.NativeApplication").nativeApplication.exit(errorCode);
			}
			catch (e:Error)
			{
				trace(e.message, e.getStackTrace());
			}
		}
	
	}

}