package System.IO.Serialization.BinaryProtocol 
{
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class ProtocolReader 
	{
		protected var protocol:Protocol;
		protected var typeInfo:ProtocolType;
		protected var buffer:ByteArray;
		protected var endian:ProtocolEndianEnum;
		
		public function ProtocolReader(protocol:Protocol, endian:ProtocolEndianEnum) 
		{
			this.protocol = protocol;
			this.endian = endian;
		}
		
		public function get Endian():ProtocolEndianEnum
		{
			return endian;
		}
		
		public function Read(buffer:ByteArray):Object
		{
			this.buffer = buffer;
			this.buffer.endian = endian.toString();
			this.typeInfo = protocol.ReadExtension(buffer);
			var result:Object = ReadBuffer(typeInfo, buffer, protocol);
			return result;
		}
		
		protected function ReadBuffer(typeInfo:ProtocolType, buffer:ByteArray, protocol:Protocol):Object
		{
			var result:Object;
			switch (typeInfo.type)
			{
				case Boolean:
					result = ReadBoolean(buffer);
					break;
				case int:
					result = ReadAsInt(buffer, typeInfo.metaType);
					break;
				case uint:
					result = ReadAsUInt(buffer, typeInfo.metaType);
					break;
				case Number:
					result = ReadAsDouble(buffer, typeInfo.metaType);
					break;
				case String:
					result = ReadString(buffer);
					break;
				case ByteArray:
					result = ReadByteArray(buffer);
					break;
				case XML:
					result = ReadXML(buffer);
					break;
				case XMLList:
					result = ReadXMLList(buffer);
					break;
				default:
					result = ReadType(buffer, typeInfo);
					break;
			}
			return result;
		}
		
		////////////////////
		
		protected function ReadXMLList(buffer:ByteArray):XMLList 
		{
			return XMLList(ReadString(buffer));
		}
		
		protected function ReadXML(buffer:ByteArray):XML
		{
			return XML(ReadString(buffer));
		}
		
		protected function ReadAsInt(buffer:ByteArray, metaType:Class):int
		{
			var result:int;
			switch(metaType)
			{
				case Byte:
					result = ReadByte(buffer);
					break;
				case Short:
					result = ReadShort(buffer);
					break;
				default:
					result = ReadInt(buffer);
					break;
			}
			return result;
		}
		
		protected function ReadAsUInt(buffer:ByteArray, metaType:Class):uint
		{
			var result:uint;
			switch(metaType)
			{
				case UByte:
					result = ReadUByte(buffer);
					break;
				case UShort:
					result = ReadUShort(buffer);
					break;
				default:
					result = ReadUint(buffer);
					break;
			}
			return result;
		}
		
		protected function ReadAsDouble(buffer:ByteArray, metaType:Class):Number
		{
			var result:Number;
			switch(metaType)
			{
				case Float:
					result = ReadFloat(buffer);
					break;
				default:
					result = ReadDouble(buffer);
					break;
			}
			return result;
		}
		
		protected function ReadBoolean(buffer:ByteArray):Boolean
		{
			return Boolean(buffer.readBoolean());
		}
		
		protected function ReadInt(buffer:ByteArray):int
		{
			return int(buffer.readInt());
		}
		
		protected function ReadUint(buffer:ByteArray):uint
		{
			return uint(buffer.readUnsignedInt());
		}
		
		protected function ReadDouble(buffer:ByteArray):Number
		{
			return Number(buffer.readDouble());
		}
		
		protected function ReadFloat(buffer:ByteArray):Number
		{
			return Number(buffer.readFloat());
		}
		
		protected function ReadByte(buffer:ByteArray):int
		{
			return int(buffer.readByte());
		}
		
		protected function ReadUByte(buffer:ByteArray):int
		{
			return uint(buffer.readUnsignedByte());
		}
		
		protected function ReadShort(buffer:ByteArray):int
		{
			return int(buffer.readShort());
		}
		
		protected function ReadUShort(buffer:ByteArray):uint
		{
			return uint(buffer.readUnsignedShort());
		}
		
		protected function ReadIsNull(buffer:ByteArray):Boolean
		{
			return buffer.readByte() == 0;
		}
		
		protected function ReadByteArray(buffer:ByteArray):ByteArray
		{
			if (ReadIsNull(buffer))
			{
				return null;
			}
			var length:int = buffer.readInt();
			var result:ByteArray = new ByteArray();
			buffer.readBytes(result, 0, length);
			return result;
		}
		
		protected function ReadString(buffer:ByteArray):String
		{
			if (ReadIsNull(buffer))
			{
				return null;
			}
			var length:int = buffer.readInt();
			return String(buffer.readUTFBytes(length));
		}
		
		protected function ReadVector(buffer:ByteArray, typeInfo:ProtocolType):Object
		{
			if (ReadIsNull(buffer))
			{
				return null;
			}
			var i:int;
			var result:Object = new typeInfo.type;
			var length:int = buffer.readInt();
			var itemType:ProtocolType = protocol.Get(typeInfo.itemType);
			for (i = 0; i < length; i++)
			{
				result[i] = ReadBuffer(itemType, buffer, protocol);
			}
			return result;
		}
		
		protected function ReadObject(buffer:ByteArray, typeInfo:ProtocolType):Object
		{
			if (ReadIsNull(buffer))
			{
				return null;
			}
			var result:Object;
			var i:int;
			var current:ProtocolType;
			var members:Vector.<ProtocolType> = typeInfo.members;
			var length:int = members.length;
			result = new typeInfo.type;
			for (i = 0; i < length; i++)
			{
				current = members[i];
				result[current.name] = ReadBuffer(current, buffer, protocol);
			}
			return result;
		}
		
		protected function ReadType(buffer:ByteArray, typeInfo:ProtocolType):Object
		{
			var result:Object;
			if (typeInfo.itemType)
			{
				result = ReadVector(buffer, typeInfo);
			}
			else
			{
				result = ReadObject(buffer, typeInfo);
			}
			return result;
		}
		
	}

}