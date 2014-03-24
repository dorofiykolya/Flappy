/**
*	Author: Lex Talkington Design, Inc
*	December 30, 2009
*	http://www.lextalkington.com/blog
*	
*	VERSION 1.0;
*	
*	Copyright (c) 2009 Lex Talkington and Lex Talkington Design, Inc.	
*	
*	Permission is hereby granted, free of charge, to any person obtaining a copy
*	of this software and associated documentation files (the "Software"), to deal
*	in the Software without restriction, including without limitation the rights
*	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
*	copies of the Software, and to permit persons to whom the Software is
*	furnished to do so, subject to the following conditions:
*	
*	The above copyright notice and this permission notice shall be included in
*	all copies or substantial portions of the Software.
*	
*	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
*	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
*	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
*	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
*	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
*	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
*	THE SOFTWARE.
*
*
*	*/
package com.lextalkington.parallax {
	
	/**
	 *	Class description.
	 *
	 *	@langversion ActionScript 3.0
	 *	@playerversion Flash 9.0
	 *
	 *	@author Lex Talkington
	 *	@since  12.30.2009
	 */
	
	import flash.display.Sprite;
	import flash.display.Shape;
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	public class ParallaxReturn extends com.lextalkington.parallax.ParallaxEngine {
		
		/** @private */
		private var _origins:Array = [];

		/**
		*	This subclass allows the plates to return to their original x,y positions when the mouse leaves the active mouse area. 
		*	The constructor accepts arguments for width, height, ease factor, mouse boundries, and an ease factor to define the amount of ease-to when mousing outside the active area.
		*	@Constructor
		*	
		*	@param w The visible width of the parallax system. 
		*	@param h The visible height of the parallax system.
		*	@param ease [optional] The amount of easing applied to the motion.
		*	@param axis [optional] The axis allowed to move. Options are ParallaxEngine.BOTH_AXIS, ParallaxEngine.X_AXIS, ParallaxEngine.Y_AXIS.
		*	@param boundleft [optional] Default is the left border of the visible area. The distance left of the parallax system x position that serves as the boundry to stop applying motion.
		*	@param boundright [optional] Default is the right border of the visible area. The distance right of the parallax system x position plus width that serves as the boundry to stop applying motion.
		*	@param boundtop [optional] Default is the top border of the visible area. The distance above the parallax system y position that serves as the boundry to stop applying motion.
		*	@param boundbottom [optional] Default is the bottom border of the visible area. The distance below of the parallax system y position plus height that serves as the boundry to stop applying motion.
		*	
		*	@example
		*	<listing version="3.0"><code>
		*	import com.lextalkington.parallax.ParallaxEngine;
		*	import com.lextalkington.parallax.ParallaxReturn;
		*	
		*	// Omitting the bounds arguments allows the active mouse area to remain within the width and height of this instance. 
		*	var _pE:ParallaxReturn = new ParallaxReturn(400,400,0.09,ParallaxEngine.BOTH_AXIS);
		*	// ClipA and ClipB are simply linked library MovieClips. You can pass any type of DisplayObject to the addPlate method. 
		*	// Note that the plates appear in the order they are added from the lowest index within the DisplayList to the upper most index. 
		*	// For true parallax functionality, plates should be smaller in width and height the lower they are in depth.
		*	var cA:ClipA = new ClipA();
		*	var cB:ClipB = new ClipB();
		*	_pE.addPlate(cA);
		*	_pE.addPlate(cB);
		*	_pE.x = _pE.y = 10;
		*	addChild(_pE);
		*	_pE.start();
		*	</code></listing>
		*/
		public function ParallaxReturn(w:Number, h:Number, ease:Number=0.2, axis:String="both_axis", boundleft:Number=NaN, boundright:Number=NaN, boundtop:Number=NaN, boundbottom:Number=NaN) {
			super(w, h, ease, axis, boundleft, boundright, boundtop, boundbottom);
		}
		
		//-----------------------------------
		//	PUBLIC METHODS
		//-----------------------------------
		/**
		*	The addPlate method is used to add display objects to the "layered" parallax instance. You should adjust the initial x,y position of the display object prior to adding a plate to the parallax system.
		*	@param displayobj Any display object.
		*	*/
		override public function addPlate(e:DisplayObject):void {
			_target.addChild(e);
			_plates.push(e);
			_origins.push({x:e.x, y:e.y});
			_xOver.push(e.width-_width);
			_yOver.push(e.height-_height);
			_total = _plates.length;
		}
		/**
		*	The dispose method will clean the instance for Garabage Collection. This method is also called if the Class instance is removed from the Display List.
		*	@param e [optional] An optional event parameter allowed if the Class instance is removed from the Display List.
		*	*/
		override public function dispose(e:Event=null):void {
			removeEventListener(Event.REMOVED, dispose);
			if(hasEventListener(Event.ENTER_FRAME)) removeEventListener(Event.ENTER_FRAME, _axisFunction);
			_plates = null;
			_yOver = null;
			_xOver = null;
			_axisFunction = null;
			while(_target.numChildren > 0) {
				_target.removeChildAt(0);
			}
			_target.mask = null;
			removeChild(_mask);
			removeChild(_target);
			_mask = null;
			_target = null;
			_origins = null;
		}
		
		
		//-----------------------------------
		//	PROTECTED METHODS
		//-----------------------------------
		/** @private */
		override protected function onFrame_both(e:Event):void {
			var mX:int = int(this.mouseX);
			var mY:int = int(this.mouseY);
			if(!checkMouse(mX,mY)) {
				returnPlates();
				return;
			}
			
			var t:uint = _total;
			while(t--) {
				var xr:Number = mX/_width;
				var yr:Number = mY/_height;
				
				var dx:Number = -_xOver[t]*xr;
				var dy:Number = -_yOver[t]*yr;

				_plates[t].x += (dx - _plates[t].x)*_ease;
				_plates[t].y += (dy - _plates[t].y)*_ease;
			}
		}
		/** @private */
		override protected function onFrame_x(e:Event):void {
			var mX:int = int(this.mouseX);
			var mY:int = int(this.mouseY);
			if(!checkMouse(mX,mY)) {
				returnPlates();
				return;
			}
						
			var t:uint = _total;
			while(t--) {
				var xr:Number = mX/_width;
				var dx:Number = -_xOver[t]*xr;
				_plates[t].x += (dx - _plates[t].x)*_ease;
			}
		}
		/** @private */
		override protected function onFrame_y(e:Event):void {
			var mX:int = int(this.mouseX);
			var mY:int = int(this.mouseY);
			
			if(!checkMouse(mX,mY)) {
				returnPlates();
				return;
			}
			
			var t:uint = _total;
			while(t--) {
				var yr:Number = mY/_height;
				var dy:Number = -_yOver[t]*yr;
				_plates[t].y += (dy - _plates[t].y)*_ease;
			}
		}

		//-----------------------------------
		//	PRIVATE METHODS
		//-----------------------------------
		/** @private */
		private function returnPlates():void { 
			if(_plates[0].x == _origins[0].x && _plates[0].y == _origins[0].y) return;
			var t:uint = _total;
			while(t--) {
				var disX:Number = (_origins[t].x-_plates[t].x)*_ease;
				var disY:Number = (_origins[t].y-_plates[t].y)*_ease;
				_plates[t].x += disX;
				_plates[t].y += disY;
			}
		}
		
		/** @private */
		private function tracer(s:*=""):void {
			trace("[ ParallaxReturn ] :: ",s);
		}
		
	}
	
}
