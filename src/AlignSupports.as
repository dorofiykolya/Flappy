package 
{
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class AlignSupports
	{
		
		public static function AlignLeft(container:Rectangle, item:Object, value:Number = 0):void
		{
			item.x = value;
		}
		
		public static function AlignLeftItems(container:Rectangle, items:Vector.<Object>, value:Number = 0, gap:Number = 0):void
		{
			var len:int = items.length;
			if (len == 0) return;
			var x:Number = value;
			for (var i:int = 0; i < len; i++) 
			{
				items[i].x = value + x;
				x += items[i].width + gap;
			}
		}
		
		public static function AlignRight(container:Rectangle, item:Object, value:Number = 0):void
		{
			item.x = container.width - item.width - value;
		}
		
		public static function AlignRightItems(container:Rectangle, items:Vector.<Object>, value:Number = 0, gap:Number = 0):void
		{
			var len:int = items.length;
			if (len == 0) return;
			var w:Number = 0;
			for (var i:int = 0; i < len; i++) 
			{
				w += items[i].width + gap;
			}
			w -= gap;
			var x:Number = value;
			for (i = 0; i < len; i++) 
			{
				items[i].x = x - items[i].width;
				x -= gap + items[i].width;
			}
		}
		
		public static function AlignTop(container:Rectangle, item:Object, value:Number = 0):void
		{
			item.y = value;
		}
		
		public static function AlignTopItems(container:Rectangle, items:Vector.<Object>, value:Number = 0):void
		{
			var len:int = items.length;
			if (len == 0) return;
			for (var i:int = 0; i < len; i++) 
			{
				items[i].y = value;
			}
		}
		
		public static function AlignBottom(container:Rectangle, item:Object, value:Number = 0):void
		{
			item.y = container.height - item.height - value;
		}
		
		public static function AlignHorizontalCenter(container:Rectangle, item:Object, value:Number = 0):void
		{
			item.x = (container.width - item.width) / 2 + value;
		}
		
		public static function AlignVerticalCenter(container:Rectangle, item:Object, value:Number = 0):void
		{
			item.y = (container.height - item.height) / 2 + value;
		}
		
		public static function AlignHorizontalCenterItems(container:Rectangle, items:Vector.<Object>, value:Number = 0, gap:Number = 0):void
		{
			var len:int = items.length;
			if (len == 0) return;
			var w:Number = 0;
			for (var i:int = 0; i < len; i++) 
			{
				w += items[i].width + gap;
			}
			w -= gap;
			var x:Number = (container.width - w) / 2 + value;
			for (i = 0; i < len; i++) 
			{
				items[i].x = x;
				x += gap + items[i].width;
			}
		}
		
		public static function AlignVerticalCenterItems(container:Rectangle, items:Vector.<Object>, value:Number = 0, gap:Number = 0):void
		{
			var len:int = items.length;
			if (len == 0) return;
			var h:Number = 0;
			for (var i:int = 0; i < len; i++) 
			{
				h += items[i].height + gap;
			}
			h -= gap;
			var y:Number = (container.height - h) / 2 + value;
			for (i = 0; i < len; i++) 
			{
				items[i].y = y;
				y += gap + items[i].height;
			}
		}
		
		public static function AlignVerticalFromValue(container:Rectangle, items:Vector.<Object>, value:Number = 0, gap:Number = 0):void
		{
			var len:int = items.length;
			if (len == 0) return;
			var h:Number = 0;
			for (var i:int = 0; i < len; i++) 
			{
				h += items[i].height + gap;
			}
			h -= gap;
			var y:Number = value;
			for (i = 0; i < len; i++) 
			{
				items[i].y = y;
				y += gap + items[i].height;
			}
		}
		
	}

}