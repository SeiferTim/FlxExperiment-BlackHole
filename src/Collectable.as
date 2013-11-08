package  
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxU;
	import org.flixel.FlxPoint;
	import org.flixel.FlxG;
	import com.gskinner.utils.Rnd;
	public class Collectable extends FlxSprite
	{
		public var type:int = 0;
		private var _tmr:Number = 0;
		private var _justborn:Number = 0;
		public var cent:FlxPoint;
		
		public function Collectable(X:Number, Y:Number, Type:int):void 
		{
			super(X, Y);
			maxVelocity.x = 60;
			maxVelocity.y = 60;
			
			rebuild(X, Y, Type);
		}
		
		public function rebuild(X:Number, Y:Number, Type:int):void
		{
			reset(X, Y);
			_tmr = 0;
			_justborn = 2;
			type = Type;
			
			switch(type)
			{
				case 0:
					// xp
					createGraphic(1, 1, 0xff3e3ec3);
					break;
				case 1:
					// health
					createGraphic(2, 2, 0xfff94b85);
					break;
				case 2:
					
					break;
				case 3:
					
					break;
			}
			velocity.x = 0;
			velocity.y = 0;
			angle = Rnd.float(0, 360);
		}
		
		override public function update():void
		{
			if (dead || !exists || PlayState.P_FROZEN) return;
			//fly towards the player
			var acc:FlxPoint;
			if (_justborn>0)
			{

				acc = FlxU.rotatePoint(-2,0, 0, 0, angle);
				_justborn -= FlxG.elapsed * 3;
				
			}
			else
			{
				angle =  FlxU.getAngle(cent.x - PlayState.P.cent.x, cent.y - PlayState.P.cent.y);
				acc = FlxU.rotatePoint( -30, 0, 0, 0, angle);
			}
			velocity.x += acc.x;
			velocity.y += acc.y;
			
			cent = new FlxPoint(x + (width / 2), y + ( height / 2));
			super.update();
		}
		
		private function getDistance(P:FlxPoint):Number
		{
			var XX:Number = P.x - cent.x;
			var YY:Number = P.y - cent.y;
			return Math.sqrt(Math.pow(XX, 2) + Math.pow(YY, 2));
		}
		
	}

}