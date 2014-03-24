package System.Application
{
	import flash.events.ProgressEvent;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import System.Application.Action.OrientationAction;
	import System.Application.Activity;
	import System.Application.IActivity;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.system.Security;
	import System.Environment;
	import System.IDisposable;
	import System.Application.Managers.ApplicationManager;
	/**
	 * ...
	 * @author dorofiy
	 */
	[Event(name = "complete", type = "flash.events.Event")]
	[Event(name = "progress", type = "flash.events.ProgressEvent")]
	
	public class Application extends Sprite implements IActivity, IDisposable
	{
		private static var _stage:flash.display.Stage;
		private static var _parameters:Object;
		private static var _applicationManager:ApplicationManager;
		private static var _isActive:Boolean;
		
		private var _toStage:Boolean;
		private var _onComplete:Boolean;
		private var _initialized:Boolean;
		
		public static function get Stage():flash.display.Stage
		{
			return _stage;
		}
		
		public static function get Parameters():Object
		{
			if (_stage == null)
			{
				return null;
			}
			return _stage.loaderInfo.parameters;
		}
		
		public static function get IsActive():Boolean
		{
			return _isActive;
		}
		
		public static function get Managers():ApplicationManager
		{
			return _applicationManager;
		}
		
		public function Application()
		{
			if (Environment.IsDesktop == false)
			{
				if (Object(flash.system.Security).hasOwnProperty("allowDomain"))
				{
					flash.system.Security['allowDomain']("*");
				}
				if (Object(flash.system.Security).hasOwnProperty("allowInsecureDomain"))
				{
					flash.system.Security['allowInsecureDomain']("*");
				}
			}
			addEventListener(Event.ACTIVATE, onActiveApplication);
			addEventListener(Event.DEACTIVATE, onDeactiveApplication);
			
			if (root)
			{
				_root = root;
			}
			else
			{
				_root = this;
			}
			if (stage)
			{
				_stage = stage;
				initialize();
			}
			else
			{
				addEventListener(Event.ADDED_TO_STAGE, initialize);
			}
			
			this.loaderInfo.addEventListener(Event.COMPLETE, initialize);
		}
		
		private function onDeactiveApplication(e:Event):void 
		{
			_isActive = false;
		}
		
		private function onActiveApplication(e:Event):void 
		{
			_isActive = true;
		}
		
		protected function OnProgressLoaderInfo(e:ProgressEvent):void 
		{
			dispatchEvent(e);
		}
		
		private function initialize(e:Event = null):void
		{
			if (e == null)
			{
				_toStage = true;
			}
			if (e)
			{
				switch (e.type)
				{
					case Event.ADDED_TO_STAGE: 
						_toStage = true;
						break;
					case Event.COMPLETE: 
						_onComplete = true;
						break;
				}
			}
			if (_toStage)
			{
				_stage = this.stage;
				_stage.scaleMode = StageScaleMode.NO_SCALE;
				_stage.align = StageAlign.TOP_LEFT;
				_stage.addEventListener(Event.DEACTIVATE, deactivate);
				Activity.initialize(_stage, _isActive);
			}
			else
			{
				return;
			}
			if (_onComplete == false)
			{
				return;
			}
			
			removeEventListener(Event.ADDED_TO_STAGE, initialize);
			Activity.add(this);
			_applicationManager = new ApplicationManager();
			_initialized = true;
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		public function get Initialized():Boolean
		{
			return _initialized;
		}
		
		private function deactivate(e:Event):void
		{
			Activity.exit();
		}
		
		public function OnClose():void
		{
		
		}
		
		public function OnDeactive():void
		{
		
		}
		
		public function OnActive():void
		{
		
		}
		
		public function OnResize():void
		{
		
		}
		
		public function OnOrientationBeginChange(action:OrientationAction):void
		{
			OrientationAction.PoolSet(action);
		}
		
		public function OnOrientationEndChange(action:OrientationAction):void
		{
			OrientationAction.PoolSet(action);
		}
		
		public function Dispose():void
		{
		
		}
	
	}

}