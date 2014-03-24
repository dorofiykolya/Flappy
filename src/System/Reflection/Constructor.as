package System.Reflection 
{
	/**
	 * ...
	 * @author dorofiy
	 */
	public class Constructor 
	{
		public var name:Object;
		public var parameters:Vector.<Parameter>;
		public var constructor:Object;
		public var metadata:Vector.<Metadata>;
		public function Constructor(name:Object, constructor:Object = null)
		{
			this.name = name;
			this.constructor = constructor;
		}
		
	}

}