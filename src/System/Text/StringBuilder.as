package System.Text 
{
	import System.IDisposable;
	import System.IEquals;
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class StringBuilder implements IEquals, IDisposable 
	{
		public static const EMPTY:String = "";
		private var string:String;
		
		public function StringBuilder(string:String = "", ...format) 
		{
			if (string == null) string = "";
			this.string = string;
			if (format.length == 0) return;
			Format.apply(null, format);
		}
		
		public function Dispose():void {
			string = null;
		}
		
		public function Append(text:String):void {
			string += text;
		}
		
		public function AppendLine(text:String):void {
			string += text + "\n";
		}
		
		public function AppendFormat(text:String, ...params):void {
			var len:uint = params.length;
			var args:Array;
			if (len == 1 && params[0] is Array)
			{
				args = params[0] as Array;
				len = args.length;
			}
			else
			{
				args = params;
			}
			
			for (var i:int = 0; i < len; i++)
			{
				text = text.replace(new RegExp("\\{"+i+"\\}", "g"), args[i]);
			}
			string += text;
		}
		
		public function AppendEndLine():void {
			string += "\n";
		}
		
		public function Clear():void {
			string = "";
		}
		
		public function Equals(s:Object):Boolean {
			return s.toString() == string;
		}
		
		public function AppendAt(text:String, index:int = int.MAX_VALUE):void {
			if (index < 0) {
				index = 0;
			}
			if (index >= string.length) {
				string += text;
				return;
			}
			var left:String = string.substring(0, index);
			var right:String = string.substring(index, string.length);
			string = left + text + right;
		}
		
		public function Insert(text:String, index:int = int.MAX_VALUE):void {
			if (index < 0) {
				index = 0;
			}
			if (index >= string.length) {
				string += text;
				return;
			}
			var left:String = string.substring(0, index);
			var right:String = string.substring(index, string.length);
			string = left + text + right;
		}
		
		public function Contains(text:String, caseSensitive:Boolean = false):Boolean {
			var i:int;
			if (caseSensitive == false) {
				i = string.toLowerCase().indexOf(text.toLowerCase());
			}else {
				i = string.indexOf(text);
			}
			return i != -1;
		}
		
		public function Search(text:String, startIndex:int = int.MAX_VALUE, caseSensitive:Boolean = false):int {
			if (caseSensitive == false) {
				return string.toLowerCase().indexOf(text.toLowerCase(), startIndex);
			}
			return string.indexOf(text, startIndex);
		}
		
		public function SearchLast(text:String, index:int = int.MAX_VALUE, caseSensitive:Boolean = false):int {
			if (caseSensitive == false) {
				return string.toLowerCase().lastIndexOf(text.toLowerCase(), index);
			}
			return string.lastIndexOf(text, index);
		}
		
		public function Remove(text:String, global:Boolean = false, caseSensitive:Boolean = false):Boolean {
			var opt:String = '';
			if (global) opt += "g";
			if (caseSensitive == false) opt += "i";
			var i:int;
			if (caseSensitive == false) {
				i = string.toLowerCase().indexOf(text.toLowerCase());
			}else {
				i = string.indexOf(text);
			}
			string = string.replace(new RegExp(text, opt), "");
			return i != -1;
		}
		
		public function RemoveAt(text:String, index:int = 0, global:Boolean = false, caseSensitive:Boolean = false):Boolean {
			var str:String = string;
			var txt:String = text;
			if (caseSensitive == false) {
				str = str.toLowerCase();
				txt = txt.toLowerCase();
			}
			var i:int = str.indexOf(txt, index);
			if (i != -1) {
				var left:String = string.substring(0, i);
				var right:String = string.substring(i + 1, string.length);
				string = left + right;
			}
			if (global && i != -1) {
                while (RemoveAt(text, index, global, caseSensitive)) {
                }
            }
			return i != -1;
		}
		
		public function RemoveLeftChars(count:int):void {
			if (count <= 0) return;
			if (count >= string.length) {
				string = EMPTY;
				return;
			}
			string = string.substring(count, string.length);
		}
		
		public function RemoveRightChars(count:int):void {
			if (count <= 0) return;
			if (count >= string.length) {
				string = EMPTY;
				return;
			}
			string = string.substring(0, string.length - count);
		}
		
		public function RemoveRange(startIndex:int = 0, endIndex:int = int.MAX_VALUE):void {
			string = string.substring(startIndex, endIndex);
		}
		
		public function RemoveCount(startIndex:int, count:int = int.MAX_VALUE):void {
			string = string.substr(startIndex, count);
		}
		
		public function RemoveAllWhitespaces():void {
			string = string.replace(/[ \t\r\n\f]*/gi, "");
		}
		
		public function Format(...params):void {
			var len:uint = params.length;
			var args:Array;
			if (len == 1 && params[0] is Array)
			{
				args = params[0] as Array;
				len = args.length;
			}
			else
			{
				args = params;
			}
			
			for (var i:int = 0; i < len; i++)
			{
				string = string.replace(new RegExp("\\{"+i+"\\}", "g"), args[i]);
			}
		}
		public function Parameters(...params):void {
			var len:uint = params.length;
			var args:Array;
			if (len == 1 && params[0] is Array)
			{
				args = params[0] as Array;
				len = args.length;
			}
			else
			{
				args = params;
			}
			
			for (var i:int = 0; i < len; i++)
			{
				string = string.replace(new RegExp("\\{"+i+"\\}", "g"), args[i]);
			}
		}
		
		public function ReplaceRegExp(oldText:String, newText:String, global:Boolean = false, caseSensitive:Boolean = false):Boolean {
			var opt:String = '';
			if (global) opt += "g";
			if (caseSensitive == false) opt += "i";
			var i:int;
			if (caseSensitive == false) {
				i = string.toLowerCase().indexOf(oldText.toLowerCase());
			}else {
				i = string.indexOf(oldText);
			}
			string = string.replace(new RegExp(oldText, opt), newText);
			return i != -1;
		}
		
		public function Replace(oldText:String, newText:String):void {
			string = string.split(oldText).join(newText);
		}
		
		public function Trim():void {
			var startIndex:int = 0;
			while (isWhitespace(string.charAt(startIndex)))
				++startIndex;
				
			var endIndex:int = string.length - 1;
			while (isWhitespace(string.charAt(endIndex)))
				--endIndex;
				
			if (endIndex >= startIndex)
				string = string.slice(startIndex, endIndex + 1);
			else
				string = "";
		}
		
		public function TrimLeft():void {
			var startIndex:int = 0;
			while (isWhitespace(string.charAt(startIndex)))
				++startIndex;
			if (startIndex >= string.length) {
				string = "";
			}else {
				string = string.substring(startIndex, string.length);
			}
		}
		
		public function TrimRight():void {
			var endIndex:int = string.length - 1;
			while (isWhitespace(string.charAt(endIndex)))
				--endIndex;
			if (endIndex <= 0) {
				string = "";
			}else {
				string = string.substring(0, endIndex + 1);
			}
		}
		
		public function PaddingLeft(maxWidth:int = 0, char:String = " "):void {
			if (maxWidth <= string.length) return;
			if (char.length > 1) char = char.charAt(0);
			var i:int = maxWidth - string.length;
			if (i <= 0) {
				return;
			}
			while (i--) {
				string = char + string;
			}
		}
		
		public function PaddingRight(maxWidth:int = 0, char:String = " "):void {
			if (maxWidth <= string.length) return;
			if (char.length > 1) char = char.charAt(0);
			var i:int = maxWidth - string.length;
			if (i <= 0) {
				return;
			}
			while (i--) {
				string += char;
			}
		}
		
		public function ToUpperCase():void {
			string = string.toUpperCase();
		}
		
		public function ToLowerCase():void {
			string = string.toLowerCase();
		}
		
		public function get Lenght():int {
			return string.length;
		}
		
		public function set Lenght(value:int):void {
			if (value <= 0) value = 0;
			if (value == 0) {
				string = "";
				return;
			}
			if (value >= string.length) {
				value = string.length;
			}
			string = string.substring(0, value);
		}
		
		public function toString():String {
			return string;
		}
		public function ToString():String {
			return string;
		}
		
		public function get Text():String {
			return string;
		}
		public function set Text(value:String):void {
			if (value == null) value = EMPTY;
			string = value;
		}
		
		public function get IsEmpty():Boolean {
			return string == "";
		}
		
		public static function isWhitespace(character:String):Boolean
		{
			switch (character)
			{
				case " ":
				case "\t":
				case "\r":
				case "\n":
				case "\f":
					return true;
					
				default:
					return false;
			}
		}
	}

}