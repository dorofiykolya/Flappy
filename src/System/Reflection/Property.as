package System.Reflection 
{
	/**
	 * ...
	 * @author dorofiy
	 */
	public class Property 
	{
		
		public static const READONLY:String = "readonly";
		public static const READWRITE:String = "readwrite";
		public static const WRITEONLY:String = "writeonly";
		
		public var name:Object;
		public var value:*;
		public var type:String;
		public var access:String;
		public var declaredBy:String;
		public var metadata:Vector.<Metadata>;
		public var namespace:Namespace;
		
		public function Property(name:Object = null, value:* = null, type:String = null, declaredBy:String = null, access:String = null,namespaceUri:String = null) 
		{
			this.name = name;
			this.value = value;
			this.type = type;
			this.access = access;
			this.declaredBy = declaredBy;
			if (namespaceUri) {
				this.namespace = new Namespace(namespaceUri, namespaceUri);
			}
		}
		
	}

}