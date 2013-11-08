package  
{
	import org.flixel.FlxEmitter;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxObject;
	import com.gskinner.utils.Rnd;
	import org.flixel.FlxG;
	import org.flixel.FlxU;
	
	public class Smoke extends FlxEmitter
	{
		private var colors:Array;
		private var sizes:Array;
		private var parent:FlxObject;
		private var thickness:Number;
		
		public function Smoke(P:FlxObject,T:Number = 500):void 
		{
			super(0, 0);
			thickness = T;
			parent = P;
			colors = new Array();
			colors.push(0x11333333);
			colors.push(0x11666666);
			colors.push(0x11999999);
			colors.push(0x11cccccc);
			colors.push(0x11000000);
			sizes = new Array(1,1,1,2,2,3);
			var size:int;
			for (var j:int = 0; j < thickness; j++)
			{
				size = Rnd.integer(0,sizes.length-1);
				add(new FlxSprite(0, 0).createGraphic(sizes[size],sizes[size], colors[Rnd.integer(0,colors.length-1)]));
			}
			gravity = 0;
			setRotation();
			minParticleSpeed.x = -3;
			minParticleSpeed.y = 15;
			maxParticleSpeed.x = 3;
			maxParticleSpeed.y = 30;
		}
		
		override public function stop(Delay:Number=3):void
		{
			killMembers();
			super.stop(Delay);
		}
		
		override public function update():void
		{
			x = parent.x + (parent.width / 2);
			y = parent.y + (parent.height / 2);
			minParticleSpeed = FlxU.rotatePoint(-3, 15, 0, 0, parent.angle-45)
			maxParticleSpeed = FlxU.rotatePoint(3, 30, 0, 0, parent.angle-45);
			super.update();
		}
		
	}

}