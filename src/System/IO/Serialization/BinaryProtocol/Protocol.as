package System.IO.Serialization.BinaryProtocol 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.InteractiveObject;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.EventDispatcher;
	import flash.utils.ByteArray;
	import flash.utils.describeType;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import flash.xml.XMLNode;
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class Protocol 
	{
		private static const VECTOR:String = "__AS3__.vec::Vector.";
		private static const LEFT_BR:String = "<";
		private static const RIGHT_BR:String = ">";
		private static const READONLY:String = "readonly";
		private static const READWRITE:String = "readwrite";
		
		private static const ARRAY:Class = Array;
		private static const INT:Class = int;
		private static const UINT:Class = int;
		private static const NUMBER:Class = Number;
		private static const BOOLEAN:Class = Boolean;
		private static const STRING:Class = String;
		private static const BYTE_ARRAY:Class = ByteArray;
		
		private var hash:Dictionary;
		private var extension:Dictionary;
		private var extensionType:Dictionary;
		private var metaNames:Vector.<String>;
		private var metaTypes:Vector.<Class>;
		private var excludeClass:Vector.<Class>;
		
		public function Protocol() 
		{
			hash = new Dictionary();
			extension = new Dictionary();
			extensionType = new Dictionary();
			
			metaNames = new <String> ["Byte", "UByte", "Short", "Float"];
			metaTypes = new <Class> [Byte, UByte, Short, Float];
			
			excludeClass = new <Class>[DisplayObject, DisplayObjectContainer, InteractiveObject, Sprite, Stage, EventDispatcher, XMLNode, Array];
		}
		
		public function Register(value:Object, type:Class):void
		{
			register(type);
			extension[value] = type;
			extensionType[type] = value;
		}
		
		public function ReadExtension(buffer:ByteArray):ProtocolType
		{
			var index:int = buffer.readInt();
			return Get(extension[index]);
		}
		
		public function WriteExtension(buffer:ByteArray, type:Class):void
		{
			var index:Number = extensionType[type];
			if (index != index)
			{
				throw new ArgumentError("type not registered, Register type before use");
			}
			buffer.writeInt(int(index));
		}
		
		public function Get(type:Object):ProtocolType
		{
			type = getClassByInstance(type);
			return hash[type];
		}
		
		private function getClassByInstance(object:Object):Class
		{
			if (object is Class)
			{
				return Class(object);
			}
			var type:String = getQualifiedClassName(object);
			var result:Class = Class(getDefinitionByName(type));
			return result;
		}
		
		private function register(type:Class, metaType:Class = null):void
		{
			if (type in hash) 
			{
				return;
			}
			
			var result:ProtocolType;
			switch(type)
			{
				case Object:
					throw new ArgumentError(Object + ": not supported");
				case int:
				case uint:
				case Number:
				case Boolean:
				case String:
				case ByteArray:
				case XML:
				case XMLList:
					result = new ProtocolType();
					result.type = type;
					hash[type] = result;
					return;
			}
			
			var index:int = excludeClass.indexOf(type);
			if(index != -1)
			{
				throw new ArgumentError(excludeClass[index] + ": not supported");
			}
			
			var root:XML = describeType(type);
			var factory:XMLList = root.factory;
			
			var exclude:Class = checkExcludeClass(factory.extendsClass);
			if (exclude)
			{
				throw new ArgumentError("not support extend class: " + exclude);
			}
			
			var list:Vector.<ProtocolType> = new Vector.<ProtocolType>();
			
			result = new ProtocolType();
			result.type = type;
			result.members = list;
			
			hash[type] = result;
			
			if (isVector(type) == false)
			{
				var current:ProtocolType;
				var memberName:String;
				var memberType:Class;
				var memberMeta:Class;
				var memberItem:Class;
				for each (var variable:XML in factory.variable) 
				{
					memberName = String(variable.@name);
					memberType = Class(getDefinitionByName(variable.@type));
					memberMeta = getMetaType(variable.metadata);
					memberItem = null;
					if (isVector(memberType))
					{
						memberItem = getVectorType(memberType);
						register(memberItem);
					}
					register(memberType);
					list[list.length] = Get(memberType).AsMemeber(memberName, memberItem, memberMeta);
				}
				for each (var accessor:XML in factory.accessor) 
				{
					if (accessor.@access == "readwrite")
					{
						memberName = String(accessor.@name);
						memberType = Class(getDefinitionByName(accessor.@type));
						memberMeta = getMetaType(accessor.metadata);
						memberItem = null;
						if (isVector(memberType))
						{
							memberItem = getVectorType(memberType);
							register(memberItem);
						}
						register(memberType, memberMeta);
						list[list.length] = Get(memberType).AsMemeber(memberName, memberItem, memberMeta);
					}
				}
				list.sort(sortProtocolType);
			}
		}
		
		private function getMetaType(metadata:XMLList):Class
		{
			for each (var item:XML in metadata) 
			{
				var index:int = metaNames.indexOf(String(item.@name));
				if (index != -1)
				{
					return metaTypes[index];
				}
			}
			return null;
		}
		
		private static function isVector(type:Class):Boolean
		{
			var cls:String = getQualifiedClassName(type);
			if (cls.indexOf(VECTOR) == 0)
			{
				return true
			}
			return false;
		}
		
		private static function isVectorByName(name:String):Boolean
		{
			if (name.indexOf(VECTOR) == 0)
			{
				return true
			}
			return false;
		}
		
		private static function getVectorType(type:Class):Class
		{
			var cls:String = getQualifiedClassName(type);
			var left:int = cls.indexOf(LEFT_BR);
			var right:int = cls.lastIndexOf(RIGHT_BR);
			if (left >= right)
			{
				throw new Error(String(type));
			}
			var result:Class = getDefinitionByName(cls.substring(left + 1, right)) as Class;
			return result;
		}
		
		private function checkExcludeClass(xml:XMLList):Class
		{
			for each (var x:XML in xml) 
			{
				var type:String = String(x.@type);
				if (isVectorByName(type))
				{
					return null;
				}
				var clazz:Class = Class(getDefinitionByName(type));
				if (excludeClass.indexOf(clazz) != -1)
				{
					return clazz;
				}
			}
			return null;
		}
		
		private static function sortProtocolType(type1:ProtocolType, type2:ProtocolType):int
		{
			if (type1.name > type2.name)
			{
				return 1;
			}
			if (type1.name < type2.name)
			{
				return -1;
			}
			return 0;
		}
		
	}

}