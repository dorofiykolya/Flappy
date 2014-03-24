package System.IO.Serialization.BinaryProtocol 
{
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class ProtocolType 
	{
		public var name:String;
		public var type:Class;
		public var itemType:Class;
		public var metaType:Class;
		public var members:Vector.<ProtocolType>;
		
		public function ProtocolType() 
		{
			
		}
		
		internal function AsMemeber(name:String, memberItem:Class, memberMeta:Class):ProtocolType
		{
			var p:ProtocolType = new ProtocolType();
			p.name = name;
			p.type = type;
			p.itemType = memberItem;
			p.metaType = memberMeta;
			p.members = members;
			return p;
		}
		
	}

}