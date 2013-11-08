package  
{
	import flash.filters.GlowFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	import org.flixel.FlxU;
	import com.gskinner.utils.Rnd;
	/**
	 * ...
	 * @author 
	 */
	public class StarDust extends FlxSprite
	{
		private var radius:Number;
		private var speed:Number;
		private var maxSpeed:Number
		private var degree:Number = 0;
		private var center:FlxPoint;
		private var gravity:Number;
		private var gravtimer:Number = 0;
		private const EventHorizon:Number = 25;
		private var colors:Array;
		private var sizes:Array;
		private var getUp2Speed:Number = 1;
		private var shipPart:Boolean = false;
		private var shipType:int = 0;
		
		public function StarDust(X:Number, Y:Number, centerX:Number, centerY:Number, Type:int = 0):void
		{
			super(X, Y);
			colors = new Array();
			colors.push(new Array());
			colors[0].push(0xff5232c1);
			colors[0].push(0xff5938cc);
			colors[0].push(0xff6546cf);
			colors[0].push(0xff7053d3);
			colors[0].push(0xff7618e2);
			colors[0].push(0xff7f23e8);
			colors[0].push(0xff8832ea);
			colors[0].push(0xffa360ee);
			colors[0].push(0xff398bca);
			colors[0].push(0xff7cb2dc);
			colors[0].push(0xffbcfecc);
			colors[0].push(0xfffffff77);
			colors[0].push(0xff0000000);
			colors[0].push(0xff0000000);
			colors[0].push(0xff0000000);
			
			colors.push(new Array());
			colors[1].push(0xff660000);
			colors[1].push(0xff990000);
			colors[1].push(0xff440000);
			colors[1].push(0xffaa0000);
			
			colors.push(new Array());
			colors[2].push(0xff006600);
			colors[2].push(0xff009900);
			colors[2].push(0xff004400);
			colors[2].push(0xff00aa00);
			
			colors.push(new Array());
			colors[3].push(0xffff00ff);
			colors[3].push(0xffff55ff);
			colors[3].push(0xffffaaff);
			
			sizes =  new Array();
			sizes.push(1);
			sizes.push(1);
			sizes.push(1);
			sizes.push(1);
			sizes.push(1);
			sizes.push(1);
			sizes.push(1);
			sizes.push(1);
			sizes.push(1);
			sizes.push(1);
			sizes.push(1);
			sizes.push(2);
			sizes.push(2);
			sizes.push(3);
			
			
			
			rebuild(X, Y, centerX, centerY,Type);
			
		}
			
		public function rebuild(X:Number, Y:Number, centerX:Number, centerY:Number,Type:int=0):void
		{
			super.reset(X, Y);
			var Size:int = sizes[Rnd.integer(0, sizes.length - 1)];
			if (Type == 0) shipPart = false;
			else shipPart = true;
			shipType = Type;
			if (shipPart)
				createGraphic(2,2, colors[shipType][Rnd.integer(0,colors[shipType].length-1)]);
			else
				createGraphic(Size,Size, colors[0][Rnd.integer(0,colors[0].length-1)]);
			width = Size;
			height = Size;
			if (shipPart)
			{
				center = new FlxPoint(centerX, centerY);
				degree = FlxU.getAngle(X - center.x, Y - centerY);
				getUp2Speed  = 0.1;
			}
			else
			{
				center = new FlxPoint(centerX + Rnd.float( -4, 4), centerY + Rnd.float( -4, 4));
				degree = Rnd.float(0, 359);
				getUp2Speed  = 1;
				
			}
			gravity = Rnd.float(0.1, 2);
			var radian:Number = (degree / 180) * Math.PI;
			radius = getDistance(center);
			if (radius < EventHorizon) kill();
			maxSpeed = Rnd.float(0.2,0.8);
			alpha = Rnd.float(0.66, 0.88);
			gravtimer = 0;
			x = center.x + Math.cos(radian) * radius;
			y = center.y + Math.sin(radian) * radius;

			
		}
		
		private function getDistance(P:FlxPoint):Number
		{
			var XX:Number = P.x - (x + width / 2);
			var YY:Number = P.y - (y + height / 2);
			return Math.sqrt(Math.pow(XX, 2) + Math.pow(YY, 2));
		}
		
		override public function update():void
		{
			if (dead || !exists) return;
			//pixels.applyFilter(this.pixels, new  Rectangle(x, y, width, height), new Point(x, y), new GlowFilter(0xffffffff));
			var radian:Number;
			if (!PlayState.BH_FROZEN)
			{
				if (getUp2Speed < 1) getUp2Speed *= 1.015
				else if (getUp2Speed > 1) getUp2Speed = 1;
				speed = ((maxSpeed) * (20000 / Math.pow(radius, 2))) * getUp2Speed;
				if (shipPart) degree += speed * 2;
				else degree += speed;
				radian = (degree / 180) * Math.PI;
				x = center.x + Math.cos(radian) * radius;
				y = center.y + Math.sin(radian) * radius;
			
				if (radius > 0)
				{
					if (!shipPart)
					{
						if (gravtimer <= 0)
						{
							gravtimer = 2;
							if (Rnd.boolean((1 * (5/ radius)))) radius -= gravity;							
						}
						else
							gravtimer -= FlxG.elapsed * 6;
					}
					else
						radius -= 0.1;
					if (radius <= EventHorizon)
						{
							alpha -= 0.1;
							if (alpha <= 0)
								kill();
						}
				}
				else
					kill();
			}
			else
			{
				if (Rnd.boolean(0.01))				
					x += Rnd.sign() * Rnd.float(0.1, .2);
				if (Rnd.boolean(0.01))				
					y += Rnd.sign() * Rnd.float(0.1, .2);
				getUp2Speed = 0.1;
			}
			super.update();
		}
		
		public function ChangeCenter(X:Number, Y:Number):void
		{
			
			
		}
		
		public function ResetCenter(X:Number, Y:Number):void
		{
			
		}
	}

}