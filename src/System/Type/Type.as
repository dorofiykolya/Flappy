package System.Type
{
	import flash.utils.describeType;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import flash.xml.XMLNode;
	
	/**
	 * ...
	 * @author dorofiy
	 */
	public class Type
	{
		
		private static const STRING:String = getQualifiedClassName(String);
		private static const BOOLEAN:String = getQualifiedClassName(Boolean);
		private static const INT:String = getQualifiedClassName(int);
		private static const UINT:String = getQualifiedClassName(uint);
		private static const NUMBER:String = getQualifiedClassName(Number);
		private static const ARRAY:String = getQualifiedClassName(Array);
		private static const OBJECT:String = getQualifiedClassName(Object);
		private static const DICTIONARY:String = getQualifiedClassName(Dictionary);
		private static const XMLT:String = getQualifiedClassName(XML);
		private static const XMLLIST:String = getQualifiedClassName(XMLList);
		private static const XMLNODE:String = getQualifiedClassName(XMLNode);
		private static const VECTOR:String = "__AS3__.vec::Vector.";
		
		private static const READONLY:String = "readonly";
		private static const READWRITE:String = "readwrite";
		
		private static const LEFT_BR:String = "<";
		private static const RIGHT_BR:String = ">";
		
		private var _object:*;
		private var _type:Class;
		
		public static var MAX_INSPECT_INDENT:int = 50;
		private static var describeCache:Object = {};
		
		public function Type(object:*, type:Class = null)
		{
			_object = object;
			_type = type;
		}
		
		public function GetInstance():*
		{
			return parse(_object, _type);
		}
		
		public function Parse(type:Class):*
		{
			return Type.parse(_object, type);
		}
		
		public function getValue(property:String):*
		{
			if (_object == undefined)
			{
				return undefined;
			}
			if (_object == null)
			{
				return null;
			}
			return _object[property];
		}
		
		public function getMembers():Object
		{
			return Type.GetMembers(_object);
		}
		
		public function Invoke(method:String, ... params):Boolean
		{
			if (_object == null)
			{
				throw new ArgumentError("object is null");
			}
			if (_object[method] as Function == null)
			{
				throw new ArgumentError("method: " + method + " --- undefined from object");
			}
			return (_object[method] as Function).apply(null, params);
		}
		
//********************************************************************************************************/////
		
		public static function IsVector(instance:Object):Boolean
		{
			var cls:String = getQualifiedClassName(instance);
			if (cls.indexOf(VECTOR) == 0)
			{
				return true;
			}
			return false;
		}
		
		/**
		 *  case "String":
		 *	case "Number":
		 *	case "int":
		 *	case "uint":
		 *	case "Boolean":
		 * @param	instance
		 * @return
		 */
		public static function IsSimple(instance:Object):Boolean
		{
			var cls:String = getQualifiedClassName(instance);
			switch (cls)
			{
				case STRING: 
				case NUMBER: 
				case INT: 
				case UINT: 
				case BOOLEAN: 
					return true;
			}
			return false;
		}
		
		public static function DescribeType(object:*):XML
		{
			return describeType(object);
		}
		
		public static function ParseTypedArray(object:Array, arrayType:Class = null):Array
		{
			return parse(object, Array, arrayType);
		}
		
		public static function Parse(object:*, type:Class):*
		{
			return parse(object, type);
		}
		
		public static function Inspect(... params):String
		{
			var result:String = "";
			for each (var item:*in params)
			{
				result += inspect(item, 0, 5);
			}
			return result;
		}
		
		private static function Merge(object:*, result:*):*
		{
			return merge(object, result);
		}
		
		public static function Invoke(object:Object, method:String, ... params):*
		{
			if (object == null)
			{
				throw new ArgumentError("object is null");
			}
			if (object[method] as Function == null)
			{
				throw new ArgumentError("method: " + method + " --- undefined from object");
			}
			return (object[method] as Function).apply(null, params);
		}
		
		private static function inspect(value:*, indent:int = 0, indentation:int = 5):String
		{
			var result:String;
			var type:String;
			if (value == undefined)
			{
				type = "undefined";
			}
			else if (value == null)
			{
				type = "null";
			}
			else
			{
				type = typeof(value);
			}
			
			switch (type)
			{
				case "boolean": 
				case "number": 
					return String(value);
				case "string": 
					return "\"" + String(value) + "\"";
				case "object": 
					if (value is Date)
					{
						return value.toString();
					}
					else if (value is XMLNode)
					{
						return value.toString();
					}
					else if (value is Class)
					{
						return "(" + getQualifiedClassName(value) + ")";
					}
					else
					{
						var isArray:Boolean = value is Array;
						var isDict:Boolean = value is Dictionary;
						var classType:String = getQualifiedClassName(value);
						var i:int;
						result = "(" + classType + ")";
						
						indent += indentation;
						if (indent < MAX_INSPECT_INDENT)
						{
							var properties:Object = GetMembers(value);
							for (var prop:Object in properties)
							{
								result += "\n";
								for (i = 0; i < indent; i++)
								{
									result += " ";
								}
								
								if (isArray)
								{
									result += "[";
								}
								else if (isDict)
								{
									result += "{";
								}
								
								if (isDict)
								{
									result += inspect(prop, indent);
								}
								else
								{
									result += prop.toString();
								}
								
								if (isArray)
								{
									result += "]";
								}
								else if (isDict)
								{
									result += "} = ";
								}
								else
								{
									result += " = ";
								}
								
								try
								{
									result += inspect(properties[prop], indent);
								}
								catch (e:Error)
								{
									result += "?";
								}
							}
						}
						else
						{
							result += "\n";
							for (i = 0; i < indent; i++)
							{
								result += " ";
							}
							result += "ERROR MAX_INSPECT_INDENT";
						}
						
						indent -= indentation;
						return result;
					}
					break;
				case "xml": 
					return value.toXMLString();
				default: 
					return "(" + type + ")";
			}
			return "(unknow)";
		}
		
		public static function GetMembers(value:Object):Object
		{
			var dict:Object = {};
			if (value == null)
			{
				return dict;
			}
			var classType:String = getQualifiedClassName(value);
			var forEach:Boolean;
			var isDict:Boolean;
			switch (classType)
			{
				case OBJECT: 
				case ARRAY: 
					forEach = true;
					break;
				case DICTIONARY: 
					forEach = true;
					isDict = true;
					break;
				default: 
					if (classType.indexOf(VECTOR) == 0)
					{
						forEach = true;
					}
					break;
			}
			
			if (isDict)
			{
				dict = new Dictionary();
			}
			
			var xml:XML = describeType(value);
			for each (var x:XML in xml.variable)
			{
				dict[x.@name] = value[x.@name];
			}
			for each (x in xml.accessor)
			{
				if (x.@access == READONLY)
				{
					dict[x.@name] = value[x.@name];
				}
				else if (x.@access == READWRITE)
				{
					dict[x.@name] = value[x.@name];
				}
			}
			for each (x in xml.constant)
			{
				dict[x.@name] = value[x.@name];
			}
			if (xml.isDynamic || forEach)
			{
				for (var name:String in value)
				{
					dict[name] = value[name];
				}
			}
			return dict;
		}
		
		static public function ToObject(value:Object):Object
		{
			if (value == null)
			{
				return null;
			}
			var type:String = typeof(value);
			var result:Object;
			switch (type)
			{
				case "boolean": 
				case "number": 
				case "string": 
					return value;
				case "object": 
					if (value is Date)
					{
						return value.toString();
					}
					else if (value is XMLNode)
					{
						return value.toString();
					}
					else
					{
						if (value is Array || IsVector(value))
						{
							var i:int;
							var len:int;
							len = value.length;
							result = new Array(len);
							for (i = 0; i < len; i++) 
							{
								result[i] = ToObject( value[i] );
							}
						}
						else
						{
							result = { };
							var properties:Object = GetMembers(value);
							for (var prop:Object in properties)
							{
								result[String(prop)] = ToObject( value[prop] );
							}
						}
						return result;
					}
					break;
				case "xml": 
					return value.toXMLString();
				default: 
					return value;
			}
			return null;
		}
		
		private static function merge(input:*, output:*):*
		{
			if (input == undefined)
			{
				return output;
			}
			if (input == null)
			{
				return output;
			}
			if (output == undefined)
			{
				return undefined;
			}
			if (output == null)
			{
				return null;
			}
			if (output is Class)
			{
				output = new output();
			}
		}
		
		private static function parse(o:*, type:Class, arrayType:Class = null):*
		{
			if (o == undefined)
			{
				return o;
			}
			if (o == null)
			{
				return o;
			}
			
			var cls:String = getQualifiedClassName(type);
			
			var arrLen:int;
			var i:int;
			if (cls.indexOf(VECTOR) == 0)
			{
				var left:int = cls.indexOf(LEFT_BR);
				var right:int = cls.lastIndexOf(RIGHT_BR);
				if (left >= right)
				{
					throw new Error(String(Type));
				}
				arrayType = getDefinitionByName(cls.substring(left + 1, right)) as Class;
				arrLen = o.length;
				var resultVector:Object = new type(arrLen);
				for (i = 0; i < arrLen; i++)
				{
					resultVector[i] = parse(o[i], arrayType);
				}
				return resultVector;
			}
			
			if (arrayType != null && cls == ARRAY)
			{
				arrLen = o.length;
				var resultArray:Array = new Array(arrLen);
				for (i = 0; i < arrLen; i++)
				{
					resultArray[i] = parse(o[i], arrayType);
				}
				return resultArray;
			}
			
			switch (cls)
			{
				case STRING: 
				case NUMBER: 
				case ARRAY: 
				case OBJECT: 
				case INT: 
				case UINT: 
				case BOOLEAN: 
					return o;
				case XMLT:
					return XML(o);
				case XMLLIST:
					return XMLList(o);
				case XMLNODE:
					return new XMLNode(0, o as String);
			}
			
			if (cls == DICTIONARY)
			{
				var d:Dictionary = new Dictionary();
				for (var s:String in o)
				{
					d[s] = o[s];
				}
				return d;
			}
			
			var x:XML = describeCache[type];
			if (x == null)
			{
				x = describeType(type);
				describeCache[type] = x;
			}
			var out:Object = new type();
			var fieldType:Class;
			var fieldTypeName:String;
			var fieldName:String;
			var f:XML;
			var variable:Object = x.factory.variable;
			for each (f in variable)
			{
				fieldType = getDefinitionByName(String(f.@type)) as Class;
				fieldTypeName = getQualifiedClassName(fieldType);
				fieldName = String(f.@name);
				out[fieldName] = parse(o[fieldName], fieldType);
			}
			var accessor:Object = x.factory.accessor;
			for each (f in accessor)
			{
				if (f.@access == READONLY)
				{
					continue;
				}
				fieldType = getDefinitionByName(String(f.@type)) as Class;
				fieldTypeName = getQualifiedClassName(fieldType);
				fieldName = String(f.@name);
				out[fieldName] = parse(o[fieldName], fieldType);
			}
			return out;
		}
	}
}