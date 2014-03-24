package System.Reflection 
{
	/**
	 * ...
	 * @author dorofiy
	 */
	public class Method
	{
		public var name:String;
		public var value:Function;
		public var returnType:String;
		public var parameters:Vector.<Parameter>;
		public var declaredBy:String;
		public var metadata:Vector.<Metadata>;
		public var namespace:Namespace;
		
		public function Method(name:String = null, value:Function = null, returnType:String = null, declaredBy:String = null, namespaceUri:String = null) 
		{
			this.name = name;
			this.value = value;
			this.returnType = returnType;
			this.declaredBy = declaredBy;
			if (namespaceUri) {
				this.namespace = new Namespace(namespaceUri, namespaceUri);
			}
		}
	}

}