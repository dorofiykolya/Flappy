package System 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.ui.Keyboard;
	import System.Events.ConsoleEvent;
	/**
	 * ...
	 * @author dorofiy.com
	 */
	[Event(name = "read", type = "System.Events.ConsoleEvent")]
	public class Console 
	{
		private static var event:EventDispatcher = new EventDispatcher();
		private static var tf:TextField = new TextField();
		private static var itf:TextField = new TextField();
		private static var dialog:Sprite = new Sprite();
		private static var isInit:Boolean;
		private static var _isVisible:Boolean;
		
		public static function get isVisible():Boolean {
			return _isVisible;
		}
		
		public static function show(container:DisplayObjectContainer):void {
			initialize();
			if (container) {
				container.addChild(dialog);
				_isVisible = true;
				if (dialog.stage) {
					dialog.stage.focus = itf;
				}
			}
			validate();
		}
		public static function hide():void {
			if (dialog.parent) {
				dialog.parent.removeChild(dialog);
				_isVisible = false;
			}
		}
		
		private static function validate():void {
			if (isInit == false) return;
			if (dialog.parent == null) return;
			var parent:DisplayObjectContainer = dialog.parent;
			dialog.graphics.clear();
			dialog.graphics.beginFill(0, 0.98);
			dialog.graphics.drawRect(0, 0, parent.width, int(parent.height * .3));
			tf.width = parent.width;
			itf.width = parent.width;
			tf.height = int(parent.height * .3) - 20;
			itf.y = tf.height;
			itf.height = 20;
		}
		
		private static function initialize():void {
			if (isInit) return;
			tf.type = TextFieldType.DYNAMIC;
			itf.type = TextFieldType.INPUT;
			tf.background = false;
			tf.border = false;
			tf.defaultTextFormat = new TextFormat("Arial");
			itf.defaultTextFormat = new TextFormat("Arial");
			tf.textColor = 0x1f7650;
			tf.multiline = true;
			tf.wordWrap = true;
			itf.textColor = 0xFFFFFF;
			itf.background = false;
			itf.border = false;
			itf.antiAliasType = AntiAliasType.ADVANCED;
			tf.antiAliasType = AntiAliasType.ADVANCED;
			itf.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			dialog.addChild(tf);
			dialog.addChild(itf);
			isInit = true;
		}
		
		static private function onKeyDown(e:KeyboardEvent):void 
		{
			if (e.keyCode == Keyboard.ENTER) {
				if (event.hasEventListener(ConsoleEvent.READ)) {
					event.dispatchEvent(new ConsoleEvent(ConsoleEvent.READ, itf.text));
				}
				itf.text = "";
			}
		}
		
		public static function addEventListener(type:String, listener:Function):void {
			event.addEventListener(type, listener);
		}
		public static function removeEventListener(type:String, listener:Function):void {
			event.removeEventListener(type, listener);
		}
		
		public static function Write(...arg):void {
			var str:String = arg.join(", ");
			tf.appendText(str);
			tf.scrollV = tf.maxScrollV;
		}
		public static function WriteLine(...arg):void {
			var str:String = arg.join(", ");
			tf.appendText(str + "\n");
			tf.scrollV = tf.maxScrollV;
		}
	}

}