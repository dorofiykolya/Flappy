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

package com.lextalkington.parallax
{
	
	/**
	 *	Class description.
	 *
	 *	@langversion ActionScript 3.0
	 *	@playerversion Flash 9.0
	 *
	 *	@author Lex Talkington
	 *	@since  12.30.2009
	 */
	
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.display.Shape;
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	public class ParallaxEngine extends Sprite
	{
		
		/**
		 *	Apply motion to both axis.
		 *	*/
		public static const BOTH_AXIS:String = "both_axis";
		/**
		 *	Apply motion only to x axis.
		 *	*/
		public static const X_AXIS:String = "x_axis";
		/**
		 *	Apply motion only to y axis.
		 *	*/
		public static const Y_AXIS:String = "y_axis";
		/**
		 *	The visible active width of the parallax instance.
		 *	@default null
		 *	*/
		public var _width:Number;
		/**
		 *	The visible active height of the parallax instance.
		 *	@default null
		 *	*/
		public var _height:Number;
		/**
		 *	The ease factor to use for the movement.
		 *	@default null
		 *	*/
		public var _ease:Number;
		
		/** @private */
		private var _boundLeft:Number;
		/** @private */
		private var _boundRight:Number;
		/** @private */
		private var _boundTop:Number;
		/** @private */
		public var _boundBottom:Number;
		/** @private */
		protected var _mask:Shape;
		/** @private */
		protected var _target:Sprite;
		/** @private */
		protected var _plates:Vector.<DisplayObject> = new Vector.<DisplayObject>();
		/** @private */
		protected var _xOver:Vector.<int> = new Vector.<int>();
		/** @private */
		protected var _yOver:Vector.<int> = new Vector.<int>();
		/** @private */
		protected var _total:uint;
		/** @private */
		protected var _axisFunction:Function;
		/** @private */
		protected var _disposed:Boolean;
		
		/**
		 *	The constructor accepts arguments for width, height, ease factor, and mouse boundries
		 *	@Constructor
		 *
		 *	@param w The visible width of the parallax system.
		 *	@param h The visible height of the parallax system.
		 *	@param ease [optional] The amount of easing applied to the motion.
		 *	@param axis [optional] The axis allowed to move. Options are ParallaxEngine.BOTH_AXIS, ParallaxEngine.X_AXIS, ParallaxEngine.Y_AXIS.
		 *	@param boundleft [optional] The distance left of the parallax system x position that serves as the boundry to stop applying motion.
		 *	@param boundright [optional] The distance right of the parallax system x position plus width that serves as the boundry to stop applying motion.
		 *	@param boundtop [optional] The distance above the parallax system y position that serves as the boundry to stop applying motion.
		 *	@param boundbottom [optional] The distance below of the parallax system y position plus height that serves as the boundry to stop applying motion.
		 *
		 *	@example
		 *	<listing version="3.0"><code>
		 *	import com.lextalkington.parallax.ParallaxEngine;
		 *
		 *	// Omitting the bounds arguments allows the active mouse area to remain within the width and height of this instance.
		 *	var _pE:ParallaxEngine = new ParallaxEngine(400,400,0.09,ParallaxEngine.BOTH_AXIS);
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
		public function ParallaxEngine(w:Number, h:Number, ease:Number = 0.2, axis:String = "both_axis", boundleft:Number = NaN, boundright:Number = NaN, boundtop:Number = NaN, boundbottom:Number = NaN)
		{
			_width = w;
			_height = h;
			_ease = ease;
			_disposed = false;
			
			// set axis allowance
			if (axis == ParallaxEngine.BOTH_AXIS)
			{
				_axisFunction = onFrame_both;
			}
			else if (axis == ParallaxEngine.X_AXIS)
			{
				_axisFunction = onFrame_x;
			}
			else if (axis == ParallaxEngine.Y_AXIS)
			{
				_axisFunction = onFrame_y;
			}
			
			// set mouse boundries
			(isNaN(boundleft)) ? _boundLeft = 0 : _boundLeft = boundleft;
			(isNaN(boundright)) ? _boundRight = _width : _boundRight = boundright;
			(isNaN(boundtop)) ? _boundTop = 0 : _boundTop = boundtop;
			(isNaN(boundbottom)) ? _boundBottom = _height : _boundBottom = boundbottom;
			
			// create mask
			_mask = new Shape();
			with (_mask.graphics)
			{
				beginFill(0xFF0000);
				drawRect(0, 0, _width, _height);
				endFill();
			}
			
			// create target to which plates are added to
			_target = new Sprite();
			addChild(_target);
			addChild(_mask);
			_target.mask = _mask;
		
			// create a listener to dispose of this Class instance if removed from the stage
			//addEventListener(Event.REMOVED, dispose);
		}
		
		//-----------------------------------
		//	PUBLIC METHODS
		//-----------------------------------
		/**
		 *	The addPlate method is used to add display objects to the "layered" parallax instance. You should adjust the initial x,y position of the display object prior to adding a plate to the parallax system.
		 *	@param displayobj Any display object.
		 *	*/
		public function addPlate(displayobj:DisplayObject):void
		{
			_target.addChild(displayobj);
			_plates.push(displayobj);
			_xOver.push(displayobj.width - _width);
			_yOver.push(displayobj.height - _height);
			_total = _plates.length;
		}
		
		/**
		 *	The start method begins the ENTER_FRAME that runs the parallax system.
		 *	*/
		public function start():void
		{
			if (!hasEventListener(Event.ENTER_FRAME))
				addEventListener(Event.ENTER_FRAME, _axisFunction, false, 0, true);
		}
		
		/**
		 *	The pause method removes the ENTER_FRAME that is running the parallax system.
		 *	*/
		public function pause():void
		{
			if (hasEventListener(Event.ENTER_FRAME))
				removeEventListener(Event.ENTER_FRAME, _axisFunction);
		}
		
		/**
		 *	The dispose method will clean the instance for Garabage Collection. This method is also called if the Class instance is removed from the Display List.
		 *	@param e [optional] An optional event parameter allowed if the Class instance is removed from the Display List.
		 *	*/
		public function dispose(e:Event = null):void
		{
			if (_disposed)
			{
				return;
			}
			_disposed = true;
			removeEventListener(Event.REMOVED, dispose);
			if (hasEventListener(Event.ENTER_FRAME))
				removeEventListener(Event.ENTER_FRAME, _axisFunction);
			_plates = null;
			_yOver = null;
			_xOver = null;
			_axisFunction = null;
			while (_target.numChildren > 0)
			{
				_target.removeChildAt(0);
			}
			_target.mask = null;
			removeChild(_mask);
			removeChild(_target);
			_mask = null;
			_target = null;
		}
		
		//-----------------------------------
		//	PROTECTED METHODS
		//-----------------------------------
		/** @private */
		protected function onFrame_both(e:Event):void
		{
			var mX:int = int(this.mouseX);
			var mY:int = int(this.mouseY);
			if (!checkMouse(mX, mY))
				return;
			
			var t:uint = _total;
			while (t--)
			{
				var xr:Number = mX / _width;
				var yr:Number = mY / _height;
				
				var dx:Number = -_xOver[t] * xr;
				var dy:Number = -_yOver[t] * yr;
				
				_plates[t].x += (dx - _plates[t].x) * _ease;
				_plates[t].y += (dy - _plates[t].y) * _ease;
			}
		}
		
		/** @private */
		protected function onFrame_x(e:Event):void
		{
			var mX:int = int(this.mouseX);
			var mY:int = int(this.mouseY);
			if (!checkMouse(mX, mY))
				return;
			
			var t:uint = _total;
			while (t--)
			{
				var xr:Number = mX / _width;
				var dx:Number = -_xOver[t] * xr;
				_plates[t].x += (dx - _plates[t].x) * _ease;
			}
		}
		
		/** @private */
		protected function onFrame_y(e:Event):void
		{
			var mX:int = int(this.mouseX);
			var mY:int = int(this.mouseY);
			if (!checkMouse(mX, mY))
				return;
			
			var t:uint = _total;
			while (t--)
			{
				var yr:Number = mY / _height;
				var dy:Number = -_yOver[t] * yr;
				_plates[t].y += (dy - _plates[t].y) * _ease;
			}
		}
		
		/** @private */
		protected function checkMouse(mX:uint, mY:uint):Boolean
		{
			return (mX < _boundLeft || mX > _boundRight || mY < _boundTop || mY > _boundBottom) ? false : true;
		}
		
		//--------------------------------------
		//  PRIVATE METHODS
		//--------------------------------------
		/** @private */
		private function tracer(str:*):void
		{
			trace("[ParallaxEngine]", str);
		}
		
		public function SetSize(_w:Number, _h:Number, boundleft:Number = NaN, boundright:Number = NaN, boundtop:Number = NaN, boundbottom:Number = NaN):void
		{
			_width = _w;
			_height = _h;
			(isNaN(boundleft)) ? _boundLeft = 0 : _boundLeft = boundleft;
			(isNaN(boundright)) ? _boundRight = _width : _boundRight = boundright;
			(isNaN(boundtop)) ? _boundTop = 0 : _boundTop = boundtop;
			(isNaN(boundbottom)) ? _boundBottom = _height : _boundBottom = boundbottom;
			Validate();
		}
		
		private function Validate():void
		{
			if (_disposed)
			{
				return;
			}
			if (_mask != null)
			{
				var g:Graphics = _mask.graphics;
				if (g != null)
				{
					g.clear();
					g.beginFill(0xFF0000);
					g.drawRect(0, 0, _width, _height);
					g.endFill();
				}
			}
		
		}
	
	}

}

