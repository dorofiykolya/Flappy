package System.Display 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import System.Display.Layout.BasicLayout;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class Container extends Sprite implements IContainer
	{
		private var _children:Vector.<DisplayObject> = new Vector.<DisplayObject>();
		private var _layout:ILayout;
		private var _includeInLayout:Boolean;
		
		public function Container(layout:ILayout = null) 
		{
			if (layout == null) {
				_layout = new BasicLayout();
			}
			
		}
		
		public function SetPercentSize(width:Number, height:Number):void {
			
		}
		public function SetSize(width:Number, height:Number):void {
			this.width = width;
			this.height = height;
		}
		public function Move(x:Number, y:Number):void {
			this.x = x;
			this.y = y;
		}
		
		public function get Children():Vector.<DisplayObject> {
			return _children;
		}
		
		public function get icludeInLayout():Boolean {
			return _includeInLayout;
		}
		
		public function set includeInLayout(value:Boolean):void {
			_includeInLayout = value;
		}
		
		public function get layout():ILayout {
			return _layout;
		}
		
		public function set layout(value:ILayout):void {
			_layout = value;
		}
		
		public function addChildren(children:Vector.<DisplayObject>, index:uint = 0):void {
			if (index < 0 || index >= _children.length) {
				throw new RangeError("index out of range");
				return;
			}
			if (children == null) {
				throw new Error("children is null");
				return;
			}
			var i:int = children.length;
			while (i-- > 0) {
				addChildAt(children[i], index);
			}
		}
		
		public function removeAllChildren():Vector.<DisplayObject> {
			while (numChildren) {
				super.removeChildAt(0);
			}
			var children:Vector.<DisplayObject> = _children.splice(0, _children.length);
			return children;
		}
		
		public function Sort(compareFunction:Function/*(v1:Object, v2:Object):int*/):Vector.<DisplayObject> {
			_children.sort(compareFunction);
			var i:int = numChildren;
			while (i-- > 0) {
				super.setChildIndex(_children[i], 0);
			}
			return _children;
		}
		
		//** CHILD **/
		private function addedChild(d:DisplayObject):void {
			if (d.parent) {
				d.parent.removeChild(d);
			}
			_children.push(d);
		}
		private function removedChild(d:DisplayObject):void {
			var i:int = _children.indexOf(d);
			if (i == -1) return;
			_children.splice(i, 1);
		}
		
		//** OVERRRIDE **/
		override public function addChild(child:DisplayObject):flash.display.DisplayObject 
		{
			if (child.parent == this) {
				setChildIndex(child, numChildren);
				return child;
			}
			addedChild(child);
			return super.addChild(child);
		}
		override public function addChildAt(child:DisplayObject, index:int):flash.display.DisplayObject 
		{
			if (child.parent == this) {
				setChildIndex(child, index);
				return child;
			}
			return super.addChildAt(child, index);
		}
		override public function removeChild(child:DisplayObject):flash.display.DisplayObject 
		{
			removedChild(child);
			return super.removeChild(child);
		}
		override public function removeChildAt(index:int):flash.display.DisplayObject 
		{
			if (index < 0 || index >= _children.length) {
				throw new RangeError("index out of range");
				return null;
			}
			_children.splice(index, 1);
			return super.removeChildAt(index);
		}
		override public function swapChildren(child1:DisplayObject, child2:DisplayObject):void 
		{
			super.swapChildren(child1, child2);
		}
		override public function swapChildrenAt(index1:int, index2:int):void 
		{
			super.swapChildrenAt(index1, index2);
		}
		override public function setChildIndex(child:DisplayObject, index:int):void 
		{
			super.setChildIndex(child, index);
		}

        public function get includeInLayout():Boolean {
            return false;
        }
    }

}