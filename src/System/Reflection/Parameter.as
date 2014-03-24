package System.Reflection 
{
	/**
	 * ...
	 * @author dorofiy
	 */
	public class Parameter 
	{
		public var index:int;
		public var type:String;
		public var optional:Boolean;
		public function Parameter(index:int = 0, type:String = null, optional:Boolean = false) 
		{
			this.index = index;
			this.type = type;
			this.optional = optional;
		}
		
	}

}