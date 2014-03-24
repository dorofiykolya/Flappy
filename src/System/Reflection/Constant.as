package System.Reflection 
{
	/**
	 * ...
	 * @author dorofiy
	 */
	public class Constant
	{
		public var name:String;
		public var value:*;
		public var type:String;
		public var metadata:Vector.<Metadata>;
		public var namespace:Namespace;
		
		public function Constant(name:String = null, value:* = null, type:String = null, namespaceUri:String = null) 
		{
			this.name = name;
			this.value = value;
			this.type = type;
			if (namespaceUri) {
				this.namespace = new Namespace(namespaceUri, namespaceUri);
			}
		}
		
	}

}