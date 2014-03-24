package System.Color
{
	
	/**
	 * ...
	 * @author dorofiy
	 */
	public class ColorConverter
	{
		
		public static function RgbaToHex(red:int, green:int, blue:int, alpha:int):uint
		{
			return alpha << 24 ^ red << 16 ^ green << 8 ^ blue;
		}
		
		public static function RgbToHex(red:int, green:int, blue:int):uint
		{
			return red << 16 ^ green << 8 ^ blue;
		}
		
		public static function HexToRgba(color:uint):RGBA
		{
			var result:RGBA = new RGBA();
			
			result.alpha = (color >> 24) & 0xFF;
			result.red = (color >> 16) & 0xFF;
			result.green = (color >> 8) & 0xFF;
			result.blue = color & 0xFF;
			
			return result;
		}
		
		public static function HexToRgb(color:uint):RGB
		{
			var result:RGB = new RGB;
			
			result.red = (color >> 16) & 0xFF;
			result.green = (color >> 8) & 0xFF;
			result.blue = color & 0xFF;
			
			return result;
		}
		
		public static function HexToFloat3(color:uint):Vector.<uint>
		{
			var result:Vector.<uint> = new Vector.<uint>(3);
			
			result[0] = (color >> 16) & 0xFF;
			result[1] = (color >> 8) & 0xFF;
			result[2] = color & 0xFF;
			
			return result;
		}
		
		public static function InterpolateColorsRgb(color1:uint, color2:uint, amount:Number):uint
		{
			var color1Rgba:RGB = HexToRgb(color1);
			var color2Rgba:RGB = HexToRgb(color2);
			
			var resultRgb:RGB = new RGB();
			
			resultRgb.red = color1Rgba.red * (1 - amount) + color2Rgba.red * amount;
			resultRgb.green = color1Rgba.green * (1 - amount) + color2Rgba.green * amount;
			resultRgb.blue = color1Rgba.blue * (1 - amount) + color2Rgba.blue * amount;
			
			return RgbToHex(resultRgb.red, resultRgb.green, resultRgb.blue);
		}
		
		public static function InterpolateColorsRgba(color1:uint, color2:uint, amount:Number):uint
		{
			var color1Rgba:RGBA = HexToRgba(color1);
			var color2Rgba:RGBA = HexToRgba(color2);
			
			var resultRgb:RGBA = new RGBA();
			
			resultRgb.red = color1Rgba.red * (1 - amount) + color2Rgba.red * amount;
			resultRgb.green = color1Rgba.green * (1 - amount) + color2Rgba.green * amount;
			resultRgb.blue = color1Rgba.blue * (1 - amount) + color2Rgba.blue * amount;
			resultRgb.alpha = 255;
			
			return RgbaToHex(resultRgb.red, resultRgb.green, resultRgb.blue, resultRgb.alpha);
		}
		
		public static function Invert(color:uint): uint
		{
			return 16777215 - color;
		}
	
	}

}