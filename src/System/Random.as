package System
{
	
	/**
	 * ...
	 * @author dorofiy
	 */
	public class Random
	{
		private var mirand:int = 1;
		private var seed:int;
		
		public function Random(seed:int = 1)
		{
			this.seed = seed;
		}
		
		public function Generate():Number
		{
			seed = (214013 * seed + 2531011);
			return ((seed >> 16) & 0x7FFF) * 0.001024;
		}
		
		public function Next(value:Number = 1):Number
		{
			mirand *= 16807;
			var a:Number = (mirand & 0x007fffff) | 0x40000000;
			return (a - 3.0) * value;
		}
		
		public function NextInt(value:int = 10):int
		{
			mirand *= 16807;
			var a:Number = (mirand & 0x007fffff) | 0x40000000;
			return (a - 3.0) * value;
		}
		
		public function NextBoolean():Boolean
		{
			mirand *= 16807;
			var a:Number = (mirand & 0x007fffff) | 0x40000000;
			return (a - 3.0) > 0.5;
		}
		
		/////////////////////////////////////////////////////
		
		public static function Next():Number
		{
			return Math.random();
		}
		
		public static function NextMax(max:Number, round:Boolean = false):Number
		{
			if (round)
			{
				return Math.round(Math.random() * max);
			}
			return Math.random() * max;
		}
		
		public static function NextRange(min:Number, max:Number, round:Boolean = false):Number
		{
			if (round)
				Math.round(int(Math.random() * (max - min + 1)) + min);
			return (int(Math.random() * (max - min + 1)) + min);
		}
		
		public static function NextBoolean():Boolean
		{
			return Math.random() > 0.5;
		}
	
	}

}