package  
{
	import flash.display.BitmapData;
	import flash.display.Shader;
	import flash.filters.BlurFilter;
	import flash.filters.GradientGlowFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.filters.BitmapFilter;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	public class TrailLayer extends FlxGroup
	{
		private var _ether:FlxSprite;
		public function TrailLayer():void
		{
			super();
			_ether = new FlxSprite();
			_ether.createGraphic(FlxG.width, FlxG.height, 0x00000000, true);
		}
		
		override public function render():void
		{
			_ether.pixels.applyFilter(_ether.pixels, new Rectangle(0, 0, FlxG.width, FlxG.height), new Point(0, 0), new BlurFilter(2, 2, 2));
			_ether.pixels.colorTransform(new Rectangle(0, 0, FlxG.width, FlxG.height), new ColorTransform(1.2, 0.5, 1.3, .95));
			//_ether.pixels.applyFilter(_ether.pixels, new Rectangle(0, 0, FlxG.width, FlxG.height), new Point(0, 0), new BlurFilter(3, 3, 2));
			//_ether.pixels.applyFilter(_ether.pixels, new Rectangle(0, 0, FlxG.width, FlxG.height), new Point(0, 0), new BlurFilter(5, 5, 2));
			var tmp:BitmapData = FlxG.buffer;
			FlxG.buffer = _ether.pixels;
			super.render();
			FlxG.buffer = tmp;
			FlxG.buffer.copyPixels(_ether.pixels, new Rectangle(0, 0, FlxG.width, FlxG.height), new Point(0, 0), null, null, true);
			
		}
		
	}

}