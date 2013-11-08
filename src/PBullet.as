package  
{
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxU;
	import org.flixel.FlxG;

	public class PBullet extends FlxSprite
	{
		private var timer:Number = 0;
		private var _type:int = 0;
		private var vel:FlxPoint;
		public var cent:FlxPoint;
		public function PBullet(X:Number, Y:Number, A:Number, T:int = 0):void 
		{
			super(X, Y);
			rebuild(X, Y, A, T);
		}
		
		public function rebuild(X:Number, Y:Number, A:Number, T:int = 0):void
		{
			
			_type = T;
			switch(_type)
			{
				case 0:
					createGraphic(3, 3, 0xffffffaa);
					break;
				case 1:
					createGraphic(3, 3, 0xffffccaa);
					break;
				case 2:
					createGraphic(3, 3, 0xffff99aa);
					break;
				case 3:
					createGraphic(3, 3, 0xffff66aa);
					break;
			}
			reset(X - (width/2), Y - (height/2));
			timer = 6;
			vel = FlxU.rotatePoint(60+(5*_type), 0, 0, 0, A-180);
			velocity.x = vel.x;
			velocity.y = vel.y;
			cent = new FlxPoint(x + (width / 2), y + ( height / 2));
			alpha = 1;
		}
		
		public function get power():int
		{
			switch(_type)
			{
				case 1:
					return 2;
				case 2:
					return 5;
				case 3:
					return 10;
			}
			return 1;
		}
		
		override public function update():void
		{
			if (dead || !exists) return;
			if(!PlayState.P_FROZEN)
			{
				velocity.x = vel.x;
				velocity.y = vel.y;
				if (timer <= 0)
				{
					if (alpha <= 0) kill();
					else alpha -= 0.1;
				}
				else
					timer -= FlxG.elapsed * 2;
			}
			else
			{
				velocity.x = 0;
				velocity.y = 0;
			}
			cent = new FlxPoint(x + (width / 2), y + (height / 2));
			super.update();
		}
		
		override public function kill():void
		{
			super.kill();
		}
		
	}

}