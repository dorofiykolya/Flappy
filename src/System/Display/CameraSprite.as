package System.Display 
{
import System.IDisposable;

import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import flash.display.Stage;
import flash.events.Event;
import flash.geom.ColorTransform;
import flash.geom.Matrix;

/**
	 * ...
	 * @author dorofiy
	 */
	public class CameraSprite extends Sprite implements IDisposable
	{
		private var _level:int;
		private var _enabled:Boolean = true;
		private var _topLevel:ColorTransform;
		private var _resetMatrix:Matrix;
		public function CameraSprite(level:int = 1) 
		{
			_level = level;
			addEventListener(Event.ENTER_FRAME, onFrame);
			visible = false;
			validateParentMatrix();
		}
		
		private function onFrame(e:Event):void 
		{
			//http://www.oreillynet.com/pub/a/javascript/2004/08/17/flashhacks.html?page=2
		}
		
		public function validateParentMatrix():void {
			var p:DisplayObjectContainer = this.parent;
			var m:Matrix;
			var i:int;
			if (_level > 0) {
				i = _level;
			}else {
				return;
			}
			while (i-- > 0 && p && (p is Stage) == false) {
				var temp:ColorTransform = p.transform.colorTransform;
				if (m == null) {
					m = p.transform.matrix;
				}else {
					m.concat(p.transform.matrix);
				}
				p = p.parent;
			}
			_topLevel = p.transform.colorTransform;
			_resetMatrix = p.transform.matrix;
		}
		
		private function validateMatrix():void {
			
		}
		
		private function resetMatrix():void {
			
		}
		
		public function get level():int {
			return _level;
		}
		
		public function set level(value:int):void 
		{
			_level = value;
			validateParentMatrix();
		}
		
		public function get enabled():Boolean {
			return _enabled;
		}
		
		public function set enabled(value:Boolean):void 
		{
			_enabled = value;
			if (value) {
				validateParentMatrix();
				validateMatrix();
			}else {
				resetMatrix();
			}
		}
		
		public function Dispose():void {
			
		}
		
	}

}