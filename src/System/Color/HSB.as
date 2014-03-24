package System.Color
{
	
	public final class HSB
	{
		private var _brightness:Number;
		private var _saturation:Number;
		private var _hue:Number;
		
		public function HSB(hue:Number = NaN, saturation:Number = NaN, brightness:Number = NaN)
		{
			this.Hue = hue;
			this.Saturation = saturation;
			this.Brightness = brightness;
		}
		
		/**
		 * The hue value for the HSB color. This represents an angle, in
		 * degrees, around the HSB cone. The supplied value will be modulated
		 * by 360 so that the stored value of hue will be in the range [0,360).
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10
		 *  @playerversion AIR 1.5
		 *  @productversion Flex 4
		 */
		public function get Hue():Number
		{
			return _hue;
		}
		
		public function set Hue(value:Number):void
		{
			_hue = value % 360;
		}
		
		/**
		 * The saturation parameter for this HSB color. This is a value between
		 * 0 (black) and 1 (full saturation), which represents the distance
		 * from the center in the HSB cone.
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10
		 *  @playerversion AIR 1.5
		 *  @productversion Flex 4
		 */
		public function get Saturation():Number
		{
			return _saturation;
		}
		
		public function set Saturation(value:Number):void
		{
			_saturation = value;
		}
		
		/**
		 * The brightness parameter for this HSB color. This is a value between
		 * 0 (black) and 1 (full brightness), which represents the distance
		 * from the apex of the HSB cone.
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10
		 *  @playerversion AIR 1.5
		 *  @productversion Flex 4
		 */
		public function get Brightness():Number
		{
			return _brightness;
		}
		
		public function set Brightness(value:Number):void
		{
			_brightness = value;
		}
		
		/**
		 *  Converts an HSB color specified by the parameters to a
		 *  uint RGB color.
		 *
		 *  @param hue The hue.
		 *
		 *  @param saturation The saturation.
		 *
		 *  @param brightness The brightness.
		 *
		 *  @return An RGB color.
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10
		 *  @playerversion AIR 1.5
		 *  @productversion Flex 4
		 */
		public static function ConvertHSBtoRGB(hue:Number, saturation:Number, brightness:Number):uint
		{
			// Conversion taken from Foley, van Dam, et al
			var r:Number, g:Number, b:Number;
			if (saturation == 0)
			{
				r = g = b = brightness;
			}
			else
			{
				var h:Number = (hue % 360) / 60;
				var i:int = int(h);
				var f:Number = h - i;
				var p:Number = brightness * (1 - saturation);
				var q:Number = brightness * (1 - (saturation * f));
				var t:Number = brightness * (1 - (saturation * (1 - f)));
				switch (i)
				{
					case 0: 
						r = brightness;
						g = t;
						b = p;
						break;
					case 1: 
						r = q;
						g = brightness;
						b = p;
						break;
					case 2: 
						r = p;
						g = brightness;
						b = t;
						break;
					case 3: 
						r = p;
						g = q;
						b = brightness;
						break;
					case 4: 
						r = t;
						g = p;
						b = brightness;
						break;
					case 5: 
						r = brightness;
						g = p;
						b = q;
						break;
				}
			}
			r *= 255;
			g *= 255;
			b *= 255;
			return (r << 16 | g << 8 | b);
		}
		
		/**
		 *  Converts a color from RGB format into an HSB.
		 *
		 *  @param rgb The RGB color.
		 *
		 *  @return The HSB object representing the RGB color.
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10
		 *  @playerversion AIR 1.5
		 *  @productversion Flex 4
		 */
		static public function ConvertRGBtoHSB(rgb:uint):HSB
		{
			// Conversion taken from Foley, van Dam, et al
			var hue:Number, saturation:Number, brightness:Number;
			var r:Number = ((rgb >> 16) & 0xff) / 255;
			var g:Number = ((rgb >> 8) & 0xff) / 255;
			var b:Number = (rgb & 0xff) / 255;
			var max:Number = Math.max(r, Math.max(g, b));
			var min:Number = Math.min(r, Math.min(g, b));
			var delta:Number = max - min;
			brightness = max;
			if (max != 0)
				saturation = delta / max;
			else
				saturation = 0;
			if (saturation == 0)
				hue = NaN;
			else
			{
				if (r == max)
					hue = (g - b) / delta;
				else if (g == max)
					hue = 2 + (b - r) / delta
				else if (b == max)
					hue = 4 + (r - g) / delta;
				hue = hue * 60;
				if (hue < 0)
					hue += 360;
			}
			return new HSB(hue, saturation, brightness);
		}
	}
}