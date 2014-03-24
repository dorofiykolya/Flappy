package System.Reflection 
{
	/**
	 * ...
	 * @author dorofiy
	 */
	public class Argument 
	{
		public var name:String;
		public var value:*;
		public function Argument(name:String = null, value:* = null) 
		{
			this.name = name;
			this.value = value;
		}
		
	}

}