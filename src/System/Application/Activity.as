package System.Application
{
	import System.Delegate;
	import System.Diagnostics.Debug;
	import System.Environment;
	import System.IDisposable;
	import System.IEquals;
	import System.Signals.SignalDispatcher;
	
	import System.Application.Action.OrientationAction;
	
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.system.Capabilities;
	
	/**
	 * ...
	 * @author dorofiy
	 */
	public class Activity implements IDisposable, IEquals, IActivity
	{
		private static var _stage:Stage;
		private static var _isActive:Boolean;
		private static var _signal:SignalDispatcher = new SignalDispatcher();
		private static var _list:Vector.<IActivity> = new Vector.<IActivity>();
		private static var _OnActive:Delegate = new Delegate();
		private static var _OnDeactive:Delegate = new Delegate();
		private static var _OnResize:Delegate = new Delegate();
		private static var _OnOrientationBeginChange:Delegate = new Delegate();
		private static var _OnOrientationEndChange:Delegate = new Delegate();
		
		internal static function add(a:IActivity):void
		{
			_list.push(a);
		}
		
		internal static function initialize(stage:Stage, isActive:Boolean):void
		{
			_stage = stage;
			_isActive = isActive;
			_stage.addEventListener(Event.RESIZE, onResize);
			if (Environment.IsDesktop)
			{
				_stage.addEventListener(OrientationAction.ORIENTATION_CHANGE, onOrientationChange);
				_stage.addEventListener(OrientationAction.ORIENTATION_CHANGING, onOrientationChanging);
			}
			else
			{
				_stage.addEventListener(Event.DEACTIVATE, onDeactive);
			}
		}
		
		public static function get IsActive():Boolean
		{
			return _isActive;
		}
		
		private static function onResize(e:Event):void
		{
			var len:int = _list.length;
			for (var i:int = 0; i < len; i++)
			{
				_list[i].OnResize();
			}
			_signal.Invoke(e.type);
			_OnResize.Invoke();
		}
		
		private static function onOrientationChanging(e:Object):void
		{
			var action:OrientationAction = OrientationAction.PoolGet(e.type, e.beforeOrientation, e.afterOrientation);
			var len:int = _list.length;
			for (var i:int = 0; i < len; i++)
			{
				_list[i].OnOrientationBeginChange(action);
			}
			_signal.Invoke(e.type, action);
			_OnOrientationBeginChange.Invoke(action);
		}
		
		private static function onOrientationChange(e:Object):void
		{
			var action:OrientationAction = OrientationAction.PoolGet(e.type, e.beforeOrientation, e.afterOrientation);
			var len:int = _list.length;
			for (var i:int = 0; i < len; i++)
			{
				_list[i].OnOrientationEndChange(action);
			}
			_signal.Invoke(e.type, action);
			_OnOrientationEndChange.Invoke(action);
		}
		
		private static function onDeactive(e:Event):void
		{
			_isActive = false;
			_stage.addEventListener(Event.ACTIVATE, onActive);
			var len:int = _list.length;
			for (var i:int = 0; i < len; i++)
			{
				_list[i].OnDeactive();
			}
			_signal.Invoke(e.type);
			_OnDeactive.Invoke();
		}
		
		private static function onActive(e:Event):void
		{
			_isActive = true;
			_stage.removeEventListener(Event.ACTIVATE, onActive);
			var len:int = _list.length;
			for (var i:int = 0; i < len; i++)
			{
				_list[i].OnActive();
			}
			_signal.Invoke(e.type);
			_OnActive.Invoke();
		}
		
		internal static function exit():void
		{
			var len:int = _list.length;
			for (var i:int = 0; i < len; i++)
			{
				_list[i].OnClose();
			}
			_signal.Invoke("exit");
		}
		
		public static function AddSignalListener(type:String, listener:Function):void
		{
			_signal.AddListener(type, listener);
		}
		
		public static function RemoveSigmalListener(type:String, listener:Function):void
		{
			_signal.RemoveListener(type, listener);
		}
		
		public static function get OnActive():Delegate
		{
			return _OnActive;
		}
		
		public static function get OnDeactive():Delegate
		{
			return _OnDeactive;
		}
		
		public static function set OnDeactive(value:Delegate):void
		{
			_OnDeactive = value;
		}
		
		public static function get OnResize():Delegate
		{
			return _OnResize;
		}
		
		public static function set OnResize(value:Delegate):void
		{
			_OnResize = value;
		}
		
		public static function get OnOrientationBeginChange():Delegate
		{
			return _OnOrientationBeginChange;
		}
		
		public static function set OnOrientationBeginChange(value:Delegate):void
		{
			_OnOrientationBeginChange = value;
		}
		
		public static function get OnOrientationEndChange():Delegate
		{
			return _OnOrientationEndChange;
		}
		
		public static function set OnOrientationEndChange(value:Delegate):void
		{
			_OnOrientationEndChange = value;
		}
		
		/**
		 * INSTANCE
		 */
		
		public function Activity()
		{
			_list.push(this);
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
			var i:int = _list.indexOf(this);
			if (i != -1)
			{
				_list.splice(i, 1);
			}
		}
		
		public function Equals(object:Object):Boolean
		{
			return this === object;
		}
	
	}

}