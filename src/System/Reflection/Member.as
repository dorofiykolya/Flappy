package System.Reflection 
{
	/**
	 * ...
	 * @author dorofiy
	 */
	public class Member 
	{
		public var name:Object;
		public var value:*;
		public var type:String;
		public var metadata:Vector.<Metadata>;
		public var namespace:Namespace;
		public var isDynamic:Boolean;
		public var isConst:Boolean;
		public var isField:Boolean;
		public var isProperty:Boolean;
		public var access:String;
		public var declaredBy:String;
		
		public function Member()
		{
			
		}
	}

}