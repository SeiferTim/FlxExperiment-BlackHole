package  
{
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxU;
	import org.flixel.FlxG;
	
	public class EBullet extends FlxSprite
	{
		private var timer:Number = 0;
		private var _type:int = 0;
		private var vel:FlxPoint;
		public var cent:FlxPoint;
		public function EBullet(X:Number, Y:Number, A:Number, T:int):void 
		{
			super(X, Y);
			rebuild(X, Y, A,T);
		}
		
		public function get power():int
		{
			switch (_type)
			{
				case 0:
					return 1;
				case 1:
					return 1;
			}
			return 0;
		}
		
		public function rebuild(X:Number, Y:Number, A:Number,T:int):void
		{
			_type = T;
			switch(_type)
			{
				case 0:
					createGraphic(2, 2, 0xff6699ff);
					timer = 8;
					vel = FlxU.rotatePoint(30, 0, 0, 0, A - 180);
					break;
				case 1:
					createGraphic(3, 3, 0xffccffcc);
					timer = 16;
					vel = FlxU.rotatePoint(20, 0, 0, 0, A - 180);
					break;
			}
			reset(X - (width/2), Y - (height/2));
			velocity.x = vel.x;
			velocity.y = vel.y;
			angle = A;
			cent = new FlxPoint(x + (width / 2), y + ( height / 2));
			alpha = 1;
		}
		
		override public function update():void
		{
			if (dead || !exists) return;
			if (!PlayState.P_FROZEN)
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