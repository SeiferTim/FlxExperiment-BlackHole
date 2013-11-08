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
	public class ExhaustLayer extends FlxGroup
	{
		private var _ether:FlxSprite;
		public function ExhaustLayer():void
		{
			super();
			_ether = new FlxSprite();
			_ether.createGraphic(FlxG.width, FlxG.height, 0x00000000, true);
		}
		
		override public function render():void
		{
			_ether.pixels.colorTransform(new Rectangle(0, 0, FlxG.width, FlxG.height), new ColorTransform(1.5,1.5,1.5, .66));
			_ether.pixels.applyFilter(_ether.pixels, new Rectangle(0, 0, FlxG.width, FlxG.height), new Point(0, 0), new BlurFilter(2,2,1));			
			var tmp:BitmapData = FlxG.buffer;
			FlxG.buffer = _ether.pixels;
			super.render();
			FlxG.buffer = tmp;
			FlxG.buffer.copyPixels(_ether.pixels, new Rectangle(0, 0, FlxG.width, FlxG.height), new Point(0, 0), null, null, true);
			
		}
		
	}

}