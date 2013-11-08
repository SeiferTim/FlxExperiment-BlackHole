package  
{
	import org.flixel.FlxEmitter;
	import org.flixel.FlxObject;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	import org.flixel.FlxU;
	import com.gskinner.utils.Rnd;
	
	public class Enemy extends FlxSprite
	{
		[Embed(source = 'enemy.png')] private var ImgE:Class;
		private var smokeEmitter:FlxEmitter;
		private var moveTimer:Number;
		private var actCounter:Number = 0;
		private var moveCounter:int = 0;
		private var lastShot:int = 0;
		private var _type:int;
		private var Dest:FlxPoint;
		private var atDest:Boolean;
		public var cent:FlxPoint;
		public var isBoss:Boolean = false;
		private var bossCounter:Number  = 0;
		private var degree:Number = 0;
		private var radius:Number = 0;
		private var destAngle:Number = 0;
		private var friction:Number = 0.95;
		private var bounced:Boolean = false;
		
		
		
		public function Enemy(X:Number, Y:Number, EType:int):void
		{
			super(X, Y);
			rebuild(X, Y, EType);// , DX, DY);
		}
		
		private function getShootTimer():Number
		{
			switch(_type)
			{
				case 1:
					return 4;
				case 2:
					return 8;
			}
			return 0;
		}
		
		public function rebuild(X:Number, Y:Number, EType:int):void
		{
			super.reset(X, Y);
			_type = EType;
			Dest = new FlxPoint(X, Y);
			//atDest = false;
			switch(_type)
			{
				case 1:
					loadGraphic(ImgE, false, false, 5, 5);
					width = 5;
					height = 5;
					health = 1;
					isBoss = false;
					radius = 5;
					thrust = 10;
					maxThrust = 20;
					maxAngular = 180;
					break;
				case 2:
					createGraphic(7, 7, 0xff00ff00);
					width = 7;
					height = 7;
					health = 2;
					isBoss = false;
					radius = 7;
					break;
				case 3: 
					createGraphic(17, 17, 0xffff00ff);
					width = 17;
					height = 17;
					health = 20;
					isBoss = true;
					radius = 10;
					degree = 0;
					break;
			}
			bounced = false;
			alpha = 0;
			acceleration.x = 0;
			acceleration.y = 0;
			velocity.x = 0;
			velocity.y = 0;
			cent = new FlxPoint(x+(width / 2), y+(height / 2));
			angle = 225;
			actCounter = 0;
			moveCounter = 0;
			lastShot = -1;
			moveTimer = 1;
			bossCounter = 0;
			maxVelocity.x  = maxVelocity.y = 30;
			
			smokeEmitter = PlayState.exLayer.add(new Smoke(this,200)) as Smoke;
			smokeEmitter.start(false,0.001);	
		}
		
		public function bounce(acc:FlxPoint):void
		{
			bounced = true;
			velocity.x = acc.x;
			velocity.y = acc.y;
		}
		
		override public function update():void
		{
			if (dead || !exists) return;
			var acc:FlxPoint;
			if (!PlayState.P_FROZEN)
			{
				if (alpha < 1)
					alpha += 0.06;
				else 
				{
					if (moveTimer <= 0)
					{
						moveTimer = 1;
						moveCounter++;
						if (moveCounter > 1080) moveCounter = 1;
					}
					else moveTimer -= FlxG.elapsed * 7;
					actCounter+=FlxG.elapsed*10;
					if (actCounter > 50) actCounter -= 50;
					if (bounced)
						bounced = false;
					else
					{
						switch (_type)
						{
							case 1:
								ShootBullet();
								velocity.y = 16;
								velocity.x = Math.cos(moveCounter) * 32;
								break;
							case 2:
								ShootBullet();
								if (moveCounter < 10)
								{
									velocity.y = 10;
									velocity.x = -20;
								}
								else if (moveCounter < 40)
								{
									velocity.x = velocity.y = 0;
								}
								else
								{
									velocity.y = 18;
								}
								break;
						}
					}
				}
				if (!onScreen() && !dead && exists) kill();
			}
			
			cent = new FlxPoint(x+(width / 2), y+(height / 2));
			super.update();
		}
		
		public function ShootBullet():void
		{
			if (lastShot != Math.floor(actCounter))
			{
				var eb:EBullet;
				switch (_type)
				{
					case 1:
						if (Math.floor(actCounter) == 30) spawnBullet(angle+45, 0);
						break;
					case 2:
						if (Math.floor(actCounter) == 40) 
						{
							spawnBullet(angle + 45, 1);
							spawnBullet(angle + 45 - 5, 1);
							spawnBullet(angle + 45 + 5, 1);
						}
						break;
					case 3:
						if (Math.floor(actCounter) == 20) spawnBullet(angle + 45 - 30, 1);
						if (Math.floor(actCounter) == 21) spawnBullet(angle + 45 - 20, 1);
						if (Math.floor(actCounter) == 22) spawnBullet(angle + 45 - 10, 1);
						if (Math.floor(actCounter) == 23) spawnBullet(angle + 45, 1);
						if (Math.floor(actCounter) == 24) spawnBullet(angle + 45 + 10, 1);
						if (Math.floor(actCounter) == 25) spawnBullet(angle + 45 + 20, 1);
						if (Math.floor(actCounter) == 26) spawnBullet(angle + 45 + 30, 1);
						break;
				}
			}
		}
		
		private function spawnBullet(a:Number,T:int = 0):void
		{
			var eb:EBullet = PlayState.EBulletGrp.getFirstAvail() as EBullet;
			var r:FlxPoint = FlxU.rotatePoint(x, y, cent.x, cent.y, angle);
			if (eb)
				eb.rebuild(cent.x, cent.y, a,T);
			else
				PlayState.EBulletGrp.add(new EBullet(r.x, r.y, a, T));
			lastShot = Math.floor(actCounter);
		}
		
		private function getDistance(P:FlxPoint):Number
		{
			var XX:Number = P.x - cent.x;
			var YY:Number = P.y - cent.y;
			return Math.sqrt(Math.pow(XX, 2) + Math.pow(YY, 2));
		}
		
		public function burst():void
		{
			var d:StarDust;
			for (var X:Number = x; X < x + width; X++)
			{
				for (var Y:Number = y; Y < y + height; Y++)
				{
					if (Rnd.boolean(0.8))
					{
						d = PlayState.debrisGrp.getFirstAvail() as StarDust;
						if (d)
							d.rebuild(X, Y, FlxG.width/2, FlxG.height/4,_type);
						else 
							PlayState.debrisGrp.add(new StarDust(X, Y, FlxG.width/2, FlxG.height/4, _type));
					}
				}
			}
			for (var i:Number = 0; i < 5 * _type; i++)
				PlayState.SpawnCollect(Rnd.integer(x, x + width), Rnd.integer(y, y + height), 0 );
			if (Rnd.boolean(0.2)) PlayState.SpawnCollect(Rnd.integer(x, x + width), Rnd.integer(y, y + height), 1);
			PlayState.givePoint(10 + 5 * _type);
		}
		
		override public function hurt(Damage:Number):void
		{
			super.hurt(Damage);
			if (health > 0) return;
			burst();
			kill();
		}
		
		override public function kill():void
		{
			super.kill();
			smokeEmitter.stop();
		}
		
	}

}