package System.Display
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class BitmapScale9Grid extends Bitmap
	{
		protected var mOriginalBitmapData:BitmapData;
		protected var mScale9Grid:Rectangle = null;
		
		public function BitmapScale9Grid(bitmapData:BitmapData = null, pixelSnapping:String = "auto", smoothing:Boolean = false)
		{
			super(bitmapData.clone(), pixelSnapping, smoothing);
			mOriginalBitmapData = bitmapData.clone();
		}
		
		override public function set bitmapData(bitmapData:BitmapData):void
		{
			mOriginalBitmapData = bitmapData.clone();
			if (mScale9Grid != null)
			{
				if (!validGrid(mScale9Grid))
				{
					mScale9Grid = null;
				}
				setSize(bitmapData.width, bitmapData.height);
			}
			else
			{
				assignBitmapData(mOriginalBitmapData.clone());
			}
		}
		
		override public function set width(value:Number):void
		{
			if (value != width)
			{
				setSize(value, height);
			}
		}
		
		override public function set height(value:Number):void
		{
			if (value != height)
			{
				setSize(width, value);
			}
		}
		
		override public function set scale9Grid(value:Rectangle):void
		{
			if ((mScale9Grid == null && value != null) || (mScale9Grid != null && !mScale9Grid.equals(value)))
			{
				if (value == null)
				{
					var currentWidth:Number = width;
					var currentHeight:Number = height;
					mScale9Grid = null;
					assignBitmapData(mOriginalBitmapData.clone());
					setSize(currentWidth, currentHeight);
				}
				else
				{
					if (!validGrid(value))
					{
						throw(new Error("#001 - The mScale9Grid does not match the original BitmapData"));
						return;
					}
					
					mScale9Grid = value.clone();
					resizeBitmap(width, height);
					scaleX = 1;
					scaleY = 1;
				}
			}
		}
		
		private function assignBitmapData(value:BitmapData):void
		{
			super.bitmapData.dispose();
			super.bitmapData = value;
		}
		
		private function validGrid(value:Rectangle):Boolean
		{
			return value.right <= mOriginalBitmapData.width && value.bottom <= mOriginalBitmapData.height;
		}
		
		override public function get scale9Grid():Rectangle
		{
			return mScale9Grid;
		}
		
		public function setSize(w:Number, h:Number):void
		{
			if (mScale9Grid == null)
			{
				super.width = w;
				super.height = h;
			}
			else
			{
				w = Math.max(w, mOriginalBitmapData.width - mScale9Grid.width);
				h = Math.max(h, mOriginalBitmapData.height - mScale9Grid.height);
				resizeBitmap(w, h);
			}
		}
		
		public function getOriginalBitmapData():BitmapData
		{
			return mOriginalBitmapData;
		}
		
		protected function resizeBitmap(w:Number, h:Number):void
		{
			if (isNaN(w) || isNaN(h))
			{
				return;
			}
			if (w <= 0 || h <= 0)
			{
				return;
			}
			var bmpData:BitmapData = new BitmapData(w, h, true, 0x00000000);
			
			var rows:Vector.<Number> = new <Number>[0, mScale9Grid.top, mScale9Grid.bottom, mOriginalBitmapData.height];
			var cols:Vector.<Number> = new <Number>[0, mScale9Grid.left, mScale9Grid.right, mOriginalBitmapData.width];
			
			var dRows:Vector.<Number> = new <Number>[0, mScale9Grid.top, h - (mOriginalBitmapData.height - mScale9Grid.bottom), h];
			var dCols:Vector.<Number> = new <Number>[0, mScale9Grid.left, w - (mOriginalBitmapData.width - mScale9Grid.right), w];
			
			var origin:Rectangle;
			var draw:Rectangle;
			var mat:Matrix = new Matrix();
			
			for (var cx:int = 0; cx < 3; cx++)
			{
				for (var cy:int = 0; cy < 3; cy++)
				{
					origin = new Rectangle(cols[cx], rows[cy], cols[cx + 1] - cols[cx], rows[cy + 1] - rows[cy]);
					draw = new Rectangle(dCols[cx], dRows[cy], dCols[cx + 1] - dCols[cx], dRows[cy + 1] - dRows[cy]);
					mat.identity();
					mat.a = draw.width / origin.width;
					mat.d = draw.height / origin.height;
					mat.tx = draw.x - origin.x * mat.a;
					mat.ty = draw.y - origin.y * mat.d;
					bmpData.draw(mOriginalBitmapData, mat, null, null, draw, smoothing);
				}
			}
			assignBitmapData(bmpData);
		}
	}

}