package System.Reflection 
{
	/**
	 * ...
	 * @author dorofiy
	 */
	public class Field
	{
		public var name:String;
		public var value:*;
		public var type:String;
		public var namespace:Namespace;
		public var metadata:Vector.<Metadata>;
		public var isDynamic:Boolean;
		
		public function Field(name:String = null, value:* = null, type:String = null, namespaceUri:String = null, isDynamic:Boolean = false) 
		{
			this.name = name;
			this.value = value;
			this.type = type;
			this.isDynamic = isDynamic;
			if (namespace) {
				this.namespace = new Namespace(namespaceUri, namespaceUri);
			}
		}
		
	}

}