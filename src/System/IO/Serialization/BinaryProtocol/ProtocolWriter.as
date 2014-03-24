package System.IO.Serialization.BinaryProtocol 
{
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class ProtocolWriter 
	{
		private var tempBuffer:ByteArray;
		protected var protocol:Protocol;
		protected var endian:ProtocolEndianEnum;
		protected var typeInfo:ProtocolType;
		protected var object:Object;
		protected var buffer:ByteArray;
		
		public function ProtocolWriter(protocol:Protocol, endian:ProtocolEndianEnum) 
		{
			this.tempBuffer = new ByteArray();
			this.protocol = protocol;
			this.endian = endian;
		}
		
		public function get Endian():ProtocolEndianEnum
		{
			return endian;
		}
		
		public function Write(object:Object):ByteArray
		{
			this.object = object;
			this.buffer = new ByteArray();
			this.buffer.endian = this.endian.toString();
			this.typeInfo = this.protocol.Get(this.object);
			this.protocol.WriteExtension(this.buffer, this.typeInfo.type);
			this.WriteBuffer(this.buffer, this.typeInfo, this.object);
			return this.buffer;
		}
		
		protected function WriteBuffer(buffer:ByteArray, typeInfo:ProtocolType, object:Object):void
		{
			switch (typeInfo.type)
			{
				case Boolean:
					WriteBoolean(buffer, Boolean(object));
					break;
				case int:
					WriteAsInt(buffer, object, typeInfo.metaType);
					break;
				case uint:
					WriteAsUInt(buffer, object, typeInfo.metaType);
					break;
				case Number:
					WriteAsDouble(buffer, object, typeInfo.metaType);
					break;
				case String:
					WriteString(buffer, object as String);
					break;
				case ByteArray:
					WriteByteArray(buffer, object as ByteArray);
					break;
				case XML:
					WriteXML(buffer, object as XML);
					break;
				case XMLList:
					WriteXMLList(buffer, object as XMLList);
					break;
				default:
					WriteType(buffer, typeInfo, object);
					break;
			}
		}
		
		
		
		
		////////////////////////////////////////
		
		protected function WriteXML(buffer:ByteArray, xml:XML):void 
		{
			WriteString(buffer, xml.toXMLString());
		}
		
		protected function WriteXMLList(buffer:ByteArray, xmlList:XMLList):void 
		{
			WriteString(buffer, xmlList.toXMLString());
		}
		
		protected function WriteAsDouble(buffer:ByteArray, object:Object, metaType:Class):void
		{
			switch(metaType)
			{
				case Float:
					WriteFloat(buffer, Number(object));
					break;
				default:
					WriteDouble(buffer, Number(object));
					break;
			}
		}
		
		protected function WriteAsUInt(buffer:ByteArray, object:Object, metaType:Class):void
		{
			switch(metaType)
			{
				case UByte:
					WriteUByte(buffer, int(object));
					break;
				case UShort:
					WriteUShort(buffer, int(object));
					break;
				default:
					WriteUInt(buffer, uint(object));
					break;
			}
		}
		
		protected function WriteAsInt(buffer:ByteArray, object:Object, metaType:Class):void
		{
			switch(metaType)
			{
				case Byte:
					WriteByte(buffer, int(object));
					break;
				case Short:
					WriteShort(buffer, int(object));
					break;
				default:
					WriteInt(buffer, int(object));
					break;
			}
		}
		
		protected function WriteBoolean(buffer:ByteArray, value:Boolean):void
		{
			buffer.writeBoolean(value);
		}
		
		protected function WriteInt(buffer:ByteArray, value:int):void
		{
			buffer.writeInt(value);
		}
		
		protected function WriteUInt(buffer:ByteArray, value:uint):void
		{
			buffer.writeUnsignedInt(value);
		}
		
		protected function WriteDouble(buffer:ByteArray, value:Number):void
		{
			buffer.writeDouble(value);
		}
		
		protected function WriteFloat(buffer:ByteArray, value:Number):void
		{
			buffer.writeFloat(value);
		}
		
		protected function WriteByte(buffer:ByteArray, value:int):void
		{
			buffer.writeByte(value);
		}
		
		protected function WriteUByte(buffer:ByteArray, value:int):void
		{
			buffer.writeByte(value);
		}
		
		protected function WriteShort(buffer:ByteArray, value:int):void
		{
			buffer.writeShort(value);
		}
		
		protected function WriteUShort(buffer:ByteArray, value:int):void
		{
			buffer.writeShort(value);
		}
		
		protected function WriteIsNull(buffer:ByteArray, value:Object):Boolean
		{
			if (value == null)
			{
				buffer.writeByte(0);
				return true;
			}
			buffer.writeByte(1);
			return false;
		}
		
		protected function WriteByteArray(buffer:ByteArray, bytes:ByteArray):void
		{
			if (WriteIsNull(buffer, bytes))
			{
				return;
			}
			var length:int = bytes.length;
			buffer.writeInt(length);
			if (length > 0)
			{
				buffer.writeBytes(bytes, 0, length);
			}
		}
		
		protected function WriteString(buffer:ByteArray, value:String):void
		{
			if (WriteIsNull(buffer, value))
			{
				return;
			}
			
			tempBuffer.clear();
			tempBuffer.endian = buffer.endian;
			tempBuffer.writeUTFBytes(value);
			WriteInt(buffer, tempBuffer.length);
			buffer.writeBytes(tempBuffer, 0, tempBuffer.length);
			tempBuffer.clear();
		}
		
		protected function WriteVector(buffer:ByteArray, typeInfo:ProtocolType, object:Object):void
		{
			if (WriteIsNull(buffer, object))
			{
				return;
			}
			var length:int = object.length;
			var itemType:ProtocolType = protocol.Get(typeInfo.itemType);
			WriteInt(buffer, length);
			for (var i:int = 0; i < length; i++) 
			{
				WriteBuffer(buffer, itemType, object[i]);
			}
		}
		
		protected function WriteObject(buffer:ByteArray, typeInfo:ProtocolType, object:Object):void
		{
			if (WriteIsNull(buffer, object))
			{
				return;
			}
			var members:Vector.<ProtocolType> = typeInfo.members;
			var length:int = members.length;
			var current:ProtocolType;
			for (var i:int = 0; i < length; i++) 
			{
				current = members[i];
				WriteBuffer(buffer, current, object[current.name]);
			}
		}
		
		protected function WriteType(buffer:ByteArray, typeInfo:ProtocolType, object:Object):void
		{
			if (typeInfo.itemType)
			{
				WriteVector(buffer, typeInfo, object);
			}
			else
			{
				WriteObject(buffer, typeInfo, object);
			}
		}
		
	}

}