package System.Application.Managers
{
	import core.Application;
	import flash.events.KeyboardEvent;
	import System.Signals.SignalDispatcher;
	
	/**
	 * ...
	 * @author dorofiy
	 */
	public class HotKeyManager
	{
		private var _ctrl:Boolean;
		private var _alt:Boolean;
		private var _shift:Boolean;
		private var _up:Boolean;
		private var _char:String;
		private var _keyCode:uint;
		
		private var _signal:SignalDispatcher = new SignalDispatcher();
		
		public function HotKeyManager()
		{
			Application.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			Application.stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		}
		
		private function onKeyUp(e:KeyboardEvent):void
		{
			_ctrl = e.ctrlKey;
			_shift = e.shiftKey;
			_alt = e.altKey;
			_up = false;
			_char = String.fromCharCode(e.charCode);
			_keyCode = e.keyCode;
			validate();
		}
		
		private function onKeyDown(e:KeyboardEvent):void
		{
			_ctrl = e.ctrlKey;
			_shift = e.shiftKey;
			_alt = e.altKey;
			_up = true;
			_char = String.fromCharCode(e.charCode);
			_keyCode = e.keyCode;
			validate();
		}
		
		private function validate():void
		{
			var key:String = _char + "_";
			var keyCode:String = _keyCode + "_";
			if (_ctrl)
			{
				key += "c";
				keyCode += "c";
			}
			if (_alt)
			{
				key += "a";
				keyCode += "a";
			}
			if (_shift)
			{
				key += "s";
				keyCode += "s";
			}
			if (_up)
			{
				key += "u";
				keyCode += "u";
			}
			_signal.Invoke(key);
			_signal.Invoke(keyCode);
		}
		
		public function Add(charOrKeyCode:Object, listener:Function, ctrlKey:Boolean = false, altKey:Boolean = false, shiftKey:Boolean = false, keyUp:Boolean = true):void
		{
			if (charOrKeyCode == null || charOrKeyCode === 0 || charOrKeyCode is String && charOrKeyCode.length != 1)
			{
				throw new ArgumentError();
				return;
			}
			var key:String = String(charOrKeyCode).toLowerCase() + "_";
			if (ctrlKey)
				key += "c";
			if (altKey)
				key += "a";
			if (shiftKey)
				key += "s";
			if (keyUp)
				key += "u";
			_signal.AddListener(key, listener);
		}
		
		public function Remove(charOrKeyCode:Object, listener:Function, ctrlKey:Boolean = true, altKey:Boolean = false, shiftKey:Boolean = false, keyUp:Boolean = true):void
		{
			if (charOrKeyCode == null || charOrKeyCode === 0 || charOrKeyCode is String && charOrKeyCode.length != 1)
			{
				throw new ArgumentError();
				return;
			}
			var key:String = String(charOrKeyCode).toLowerCase() + "_";
			if (ctrlKey)
				key += "c";
			if (altKey)
				key += "a";
			if (shiftKey)
				key += "s";
			if (keyUp)
				key += "u";
			_signal.RemoveListener(key, listener);
		}
	}

}