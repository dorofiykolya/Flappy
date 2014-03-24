package System.Reflection
{
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class Reflection
	{
		private var instance:*;
		
		private var isArray:Boolean;
		private var isDictionary:Boolean;
		private var isVector:Boolean;
		private var isSimple:Boolean;
		private var isXML:Boolean;
		private var isXMLList:Boolean;
		private var isUndefined:Boolean;
		private var isNull:Boolean;
		private var isDynamic:Boolean;
		private var isFunction:Boolean;
		private var isFinal:Boolean;
		private var isStatic:Boolean;
		private var extendsClass:Vector.<String>;
		private var implementsInterface:Vector.<String>;
		private var constructor:Constructor;
		private var name:String;
		private var clazz:Class;
		private var qualifiedClassName:String;
		private var parameters:Vector.<Parameter>;
		
		private var constants:Vector.<Constant>;
		private var properties:Vector.<Property>;
		private var fields:Vector.<Field>;
		private var methods:Vector.<Method>;
		private var members:Vector.<Member>;
		
		private var forEach:Boolean;
		
		private var type:Object;
		
		public function Reflection(object:*)
		{
			instance = object;
			if (instance === undefined)
			{
				isUndefined = true;
				return;
			}
			if (instance === null)
			{
				isNull = true;
				return;
			}
			parse(object);
		}
		
		private function parse(object:*, isFactory:Boolean = false):void
		{
			isUndefined = object === undefined;
			if (isUndefined)
			{
				return;
			}
			isNull = object === null;
			if (isNull)
			{
				return;
			}
			
			instance = object;
			
			var cls:String = getQualifiedClassName(instance);
			qualifiedClassName = cls;
			
			if (object is Class)
			{
				clazz = object;
			}
			else 
			{
				clazz = Class(getDefinitionByName(cls));
			}
			
			var itemXML:XML;
			type = describeType(instance);
			if (isFactory)
			{
				type = type.factory;
			}
			
			switch (cls)
			{
				case "String": 
				case "Number": 
				case "int": 
				case "uint": 
				case "Boolean": 
					isSimple = true;
					break;
				case "Array": 
					isArray = true;
					forEach = true;
					break;
				case "Object": 
					forEach = true;
					break;
				case "flash.utils::Dictionary": 
					isDictionary = true;
					forEach = true;
					break;
				case "XML": 
					isXML = true;
					break;
				case "XMLList": 
					isXMLList = true;
					break;
				case "Function": 
					isFunction = true;
					break;
				default: 
					if (cls.indexOf("__AS3__.vec::Vector.") == 0)
					{
						isVector = true;
						forEach = true;
					}
					if (object is Function)
					{
						isFunction = true;
					}
					break;
			}
			
			name = type.@name;
			
			if (isFactory == false)
			{
				isDynamic = type.@isDynamic;
				isFinal = type.@isFinal;
				isStatic = type.@isStatic;
			}
			
			if (type.hasOwnProperty("extendsClass") && type.extendsClass.length() > 0)
			{
				extendsClass = new Vector.<String>();
				for each (var ext:XML in type.extendsClass)
				{
					extendsClass.push(ext.@type);
				}
			}
			
			if (type.hasOwnProperty("implementsInterface") && type.implementsInterface.length() > 0)
			{
				implementsInterface = new Vector.<String>();
				for each (var x:XML in type.implementsInterface)
				{
					implementsInterface.push(x.@type);
				}
			}
			
			constructor = createConstructor(type.constructor, object, name);
			
			fields = createFields(type, object);
			properties = createProperties(type, object);
			methods = createMethods(type, object);
			constants = createConstants(type, object);
			
			if (forEach)
			{
				if (properties == null) 
				{
					properties = new Vector.<Property>();
				}
				for (var name:Object in object) 
				{
					properties.push(new Property(name, object[name], getQualifiedClassName(object[name]), qualifiedClassName, Property.READWRITE));
				}
			}
			
			members = new Vector.<Member>();
			var mem:Member;
			var len:int;
			if (fields)
			{
				len = fields.length;
				for (var j:int = 0; j < len; j++)
				{
					var f:Field = fields[j];
					mem = new Member();
					mem.isDynamic = f.isDynamic;
					mem.metadata = f.metadata;
					mem.name = f.name;
					mem.namespace = f.namespace;
					mem.type = f.type;
					mem.value = f.value;
					mem.isField = true;
				}
			}
			if (properties)
			{
				len = properties.length;
				for (var k:int = 0; k < len; k++)
				{
					var p:Property = properties[k];
					mem = new Member();
					mem.name = p.name;
					mem.namespace = p.namespace;
					mem.type = p.type;
					mem.value = p.value;
					mem.metadata = p.metadata;
					mem.declaredBy = p.declaredBy;
					mem.access = p.access;
					mem.isProperty = true;
				}
			}
			if (constants)
			{
				len = constants.length;
				for (var l:int = 0; l < len; l++)
				{
					var c:Constant = constants[l];
					mem = new Member();
					mem.name = c.name;
					mem.metadata = c.metadata;
					mem.type = c.type;
					mem.value = c.value;
					mem.namespace = c.namespace;
					mem.isConst = true;
				}
			}
			
			if (isFunction)
			{
				var i:int = 1;
				for each (var it:XML in type.parameter)
				{
					if (parameters == null)
						parameters = new Vector.<Parameter>();
					parameters.push(new Parameter(i, it.@type, it.@optional));
					i++;
				}
			}
		}
		
		public function Invoke(methodName:String, ... params):*
		{
			return (instance[methodName] as Function).apply(null, params);
		}
		
		public function GetValue(prop:String):*
		{
			return instance[prop];
		}
		
		public function get IsArray():Boolean
		{
			return isArray;
		}
		
		public function get IsDictionary():Boolean
		{
			return isDictionary;
		}
		
		public function get IsVector():Boolean
		{
			return isVector;
		}
		
		public function get IsSimple():Boolean
		{
			return isSimple;
		}
		
		public function get IsXML():Boolean
		{
			return isXML;
		}
		
		public function get IsXMLList():Boolean
		{
			return isXMLList;
		}
		
		public function get IsNull():Boolean
		{
			return isNull;
		}
		
		public function get IsUndefined():Boolean
		{
			return isUndefined;
		}
		
		public function get IsDynamic():Boolean
		{
			return isDynamic;
		}
		
		public function get IsFinal():Boolean
		{
			return isFinal;
		}
		
		public function get IsStatic():Boolean
		{
			return isStatic;
		}
		
		public function get IsFunction():Boolean
		{
			return isFunction;
		}
		
		public function get ExtendsClass():Vector.<String>
		{
			return extendsClass;
		}
		
		public function get ImplementsInterface():Vector.<String>
		{
			return implementsInterface;
		}
		
		public function get Name():String
		{
			return name;
		}
		
		public function get Value():*
		{
			return instance;
		}
		
		public function get ConstructorClass():Constructor
		{
			return constructor;
		}
		
		public function get Constants():Vector.<Constant>
		{
			return constants;
		}
		
		public function get Fields():Vector.<Field>
		{
			return fields;
		}
		
		public function get Methods():Vector.<Method>
		{
			return methods;
		}
		
		public function get Properties():Vector.<Property>
		{
			return properties;
		}
		
		public function get Members():Vector.<Member>
		{
			return members;
		}
		
		public function get QualifiedClassName():String 
		{
			return qualifiedClassName;
		}
		
		public function GetClass():Class 
		{
			return clazz;
		}
		
		public function GetField(name:String):Field
		{
			for each (var item:Field in fields) 
			{
				if (item.name == name)
				{
					return item;
				}
			}
			return null;
		}
		
		public function GetProperty(name:String):Property
		{
			for each (var item:Property in properties) 
			{
				if (item.name == name)
				{
					return item;
				}
			}
			return null;
		}
		
		public function GetMember(name:String):Member
		{
			for each (var item:Member in members) 
			{
				if (item.name == name)
				{
					return item;
				}
			}
			return null;
		}
		
		public function GetMethod(name:String):Method
		{
			for each (var item:Method in methods) 
			{
				if (item.name == name)
				{
					return item;
				}
			}
			return null;
		}
		
		private static function createConstructor(xml:Object, object:*, name:Object):Constructor
		{
			if (xml == null)
			{
				return null;
			}
			var c:Constructor = new Constructor(name, Object(object).constructor);
			c.metadata = createMetadata(xml);
			var par:Vector.<Parameter>;
			var i:int = 1;
			for each (var x:XML in xml.parameter)
			{
				if (par == null)
					par = new Vector.<Parameter>();
				par.push(new Parameter(i, x.@type, x.@optional));
				i++;
			}
			c.parameters = par;
			return c;
		}
		
		private static function createMetadata(xml:Object):Vector.<Metadata>
		{
			if (xml == null)
				return null;
			if (xml.hasOwnProperty("metadata") == false || xml.metadata.length() == 0)
			{
				return null;
			}
			xml = xml.metadata;
			var ml:Vector.<Metadata> = new Vector.<Metadata>();
			
			if (xml is XML)
			{
				ml.push(exctractMetadata(xml as XML));
				return ml;
			}
			if (xml is XMLList)
			{
				for each (var x:XML in xml)
				{
					ml.push(exctractMetadata(x));
				}
				return ml;
			}
			return null;
		}
		
		private static function exctractMetadata(xml:XML):Metadata
		{
			var meta:Metadata = new Metadata(xml.@name);
			var arg:Vector.<Argument>;
			for each (var item:XML in xml.arg)
			{
				if (arg == null)
					arg = new Vector.<Argument>();
				arg.push(new Argument(item.@key, item.@value));
			}
			meta.arguments = arg;
			return meta;
		}
		
		private static function createFields(type:Object, object:*):Vector.<Field>
		{
			if (type.hasOwnProperty("variable") == false || type.variable.length() == 0)
				return null;
			var l:Vector.<Field> = new Vector.<Field>();
			for each (var x:XML in type.variable)
			{
				var name:String = x.@name;
				var uri:String = x.@uri;
				var f:Field = new Field(name, getUriValue(object, uri, name), x.@type, uri);
				f.metadata = createMetadata(x);
				l.push(f);
			}
			return l;
		}
		
		private static function createProperties(type:Object, object:*):Vector.<Property>
		{
			if (type.hasOwnProperty("accessor") == false || type.accessor.length() == 0)
				return null;
			var pl:Vector.<Property> = new Vector.<Property>();
			for each (var x:XML in type.accessor)
			{
				var name:String = x.@name;
				var p:Property;
				var access:String = x.@access;
				var uri:String = x.@uri;
				switch (access)
				{
					case Property.WRITEONLY: 
						p = new Property(name, null, x.@type, x.@declaredBy, x.@access, uri);
						break;
					default: 
						p = new Property(name, getUriValue(object, uri, name), x.@type, x.@declaredBy, x.@access, uri);
						break;
				}
				p.metadata = createMetadata(x);
				pl.push(p);
			}
			return pl;
		}
		
		private static function createMethods(type:Object, object:*):Vector.<Method>
		{
			if (type.hasOwnProperty("method") == false || type.method.length() == 0)
				return null;
			var ml:Vector.<Method> = new Vector.<Method>();
			for each (var x:XML in type.method)
			{
				var name:String = x.@name;
				var uri:String = x.@uri;
				var m:Method = new Method(name, getUriValue(object, uri, name), x.@returnType, x.@declaredBy, uri);
				m.metadata = createMetadata(x);
				var par:Vector.<Parameter>;
				var i:int = 1;
				for each (var it:XML in x.parameter)
				{
					if (par == null)
						par = new Vector.<Parameter>();
					par.push(new Parameter(i, it.@type, it.@optional));
					i++;
				}
				m.parameters = par;
				ml.push(m);
			}
			return ml;
		}
		
		private static function getUriValue(object:Object, uri:String, name:String):*
		{
			if (uri != null) 
			{
				var n:Namespace = new Namespace(uri, uri);
				return object.n::[name];
			}
			return object[name];
		}
		
		private static function createConstants(type:Object, object:*):Vector.<Constant>
		{
			if (type.hasOwnProperty("constant") == false || type.constant.length() == 0)
				return null;
			var cl:Vector.<Constant> = new Vector.<Constant>();
			for each (var x:XML in type.constant)
			{
				var name:String = x.@name;
				var uri:String = x.@uri;
				var c:Constant = new Constant(name, getUriValue(object, uri, name), x.@type, uri);
				c.metadata = createMetadata(x);
				cl.push(c);
			}
			return cl;
		}
	}

}
