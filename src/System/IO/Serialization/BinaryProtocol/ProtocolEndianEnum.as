package System.IO.Serialization.BinaryProtocol 
{
	import flash.utils.Endian;
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class ProtocolEndianEnum 
	{
		
		public static const BIG:ProtocolEndianEnum = new ProtocolEndianEnum(Endian.BIG_ENDIAN);
		public static const LITTLE:ProtocolEndianEnum = new ProtocolEndianEnum(Endian.LITTLE_ENDIAN);
		
		private var value:String;
		
		public function ProtocolEndianEnum(value:String) 
		{
			this.value = value;
		}
		
		public function toString():String
		{
			return value;
		}
		
	}

}