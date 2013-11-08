package  
{
	import org.flixel.FlxEmitter;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	import org.flixel.FlxU;
	import com.gskinner.utils.Rnd;
	
	public class Player extends FlxSprite
	{
		[Embed(source = 'ship.png')] private var ImgShip:Class;
		public var center:FlxPoint;
		private var degree:Number = 0;
		private var lastMousePos:FlxPoint;
		private var radius:Number = 0;
		private const MAXSPEED:Number = 10;
		private const MAXDEGREE:Number = 118;
		private const MINDEGREE:Number = 62;
		private const MINRAD:Number = 100;
		private const MAXRAD:Number = 150;
		private var momentum:FlxPoint;
		private var smokeEmitter:FlxEmitter;
		//private var shootTmr:Number = 1 ;
		private var shootCounter:Number = 1;
		private var lastShot:int = 0;
		public var cent:FlxPoint;
		
		public function Player():void
		{
			super( -100, -100);
			loadGraphic(ImgShip, false, false, 9, 9);
			height = width = 9;
			center = new FlxPoint(FlxG.width/2,FlxG.height/4);
			degree = 90;
			angle = 45;
			radius = 150;
			cent = new FlxPoint(x + (width / 2), y + (height / 2));
			cent.x += x;
			cent.y += y;
			lastMousePos = new FlxPoint();
			smokeEmitter = PlayState.exLayer.add(new Smoke(this)) as Smoke;
			smokeEmitter.start(false, 0.001);
			momentum = new FlxPoint(0, 0);
			shootCounter = 1;
			lastShot = -1;
			//shootTmr = 1;
		}
		
		override public function update():void
		{
			if (dead || !exists) return;
			if (!PlayState.P_FROZEN)
			{
				var radian:Number;
				var maxMomentum:FlxPoint = new FlxPoint(0,0);
				if (degree >= (MAXDEGREE) - ((MAXDEGREE-MINDEGREE)*0.25))
					maxMomentum.x = ((MAXDEGREE+2)-degree) / ((MAXDEGREE-MINDEGREE) * 0.25);
				else if (degree <= MINDEGREE + ((MAXDEGREE-MINDEGREE)*0.25))
					maxMomentum.x = (degree - (MINDEGREE-2)) / ((MAXDEGREE-MINDEGREE) * 0.25);
				else maxMomentum.x = 1;
				
				if (radius >= (MAXRAD) - ((MAXRAD-MINRAD)*0.25))
					maxMomentum.y = ((MAXRAD+2)-radius) / ((MAXRAD-MINRAD) * 0.25);
				else if (radius <= MINRAD + ((MAXRAD-MINRAD)*0.25))
					maxMomentum.y = (radius - (MINRAD-2)) / ((MAXRAD-MINRAD) * 0.25);
				else maxMomentum.y = 1;
				if (FlxG.keys.LEFT && degree < MAXDEGREE)
				{
					if (momentum.x < FlxG.elapsed * 2.5) momentum.x += FlxG.elapsed * 2.5;
					if (momentum.x < 0) momentum.x = 0; 
					else momentum.x += FlxG.elapsed;
				}
				else if (FlxG.keys.RIGHT && degree > MINDEGREE)
				{
					if (momentum.x > FlxG.elapsed * 2.5) momentum.x -= FlxG.elapsed * 2.5;
					else if (momentum.x > 0) momentum.x = 0;
					else momentum.x -= FlxG.elapsed;
				}
				else
				{
					if (momentum.x > FlxG.elapsed * 2) momentum.x -= FlxG.elapsed * 2;
					else if (momentum.x < 0) momentum.x += FlxG.elapsed*2;
					else if (momentum.x > 0 || momentum.x < 0) momentum.x = 0; 
				}
				if (momentum.x < -maxMomentum.x) momentum.x = -maxMomentum.x;
				else if (momentum.x > maxMomentum.x) momentum.x = maxMomentum.x;
				degree += (MAXSPEED * 0.25) * momentum.x;
				if (degree > MAXDEGREE) degree = MAXDEGREE;
				else if (degree < MINDEGREE) degree = MINDEGREE;
				radian = (degree / 180) * Math.PI;
				
				
				if (FlxG.keys.UP && radius > MINRAD)
				{
					if (momentum.y > FlxG.elapsed * 2.5) momentum.y -= FlxG.elapsed * 2.5;
					else if (momentum.y > 0) momentum.y = 0;
					else momentum.y -= FlxG.elapsed; 
				}
				else if (FlxG.keys.DOWN && radius < MAXRAD)
				{
					if (momentum.y <  FlxG.elapsed * 2.5) momentum.y += FlxG.elapsed * 2.5;
					else if (momentum.y < 0) momentum.y = 0;
					else momentum.y += FlxG.elapsed; 
				}
				else
				{
					if (momentum.y > 0) momentum.y -= FlxG.elapsed * 3;
					else if (momentum.y < 0) momentum.y += FlxG.elapsed * 3;
					else if (momentum.y > 0 || momentum.y < 0) momentum.y = 0; 
				}
				
				if (momentum.y < -maxMomentum.y) momentum.y = -maxMomentum.y;
				else if (momentum.y > maxMomentum.y) momentum.y = maxMomentum.y;
				radius += 2 * momentum.y;
				if (radius > MAXRAD) radius = MAXRAD;
				else if (radius < MINRAD) radius = MINRAD;
				//angle = degree-45;
				
				
				x = (center.x + Math.cos(radian) * radius) - (width/2);
				y = (center.y + Math.sin(radian) * radius) - (height/2);
				cent = new FlxPoint(x + (width / 2), y + (height / 2));
				
				
				ShootBullet();
				
					
			}
			super.update();
		}
		
		public function ShootBullet():void
		{
			
			/*if (shootTmr<=0)
			{
				shootTmr = 1;
				shootCounter++;
				if (shootCounter > 100) shootCounter = 1;
			}
			else shootTmr -= FlxG.elapsed * 5;*/
			shootCounter += FlxG.elapsed * 10;
			if (shootCounter > 50) shootCounter -= 50;
			
			if (lastShot != Math.floor(shootCounter))
			{
				switch(PlayState.PLevel)
				{
					case 1:
						if (Math.floor(shootCounter) % 5 == 0) spawnBullet(angle+45, 0);
						break;
					case 2:
						if (Math.floor(shootCounter) % 10 == 0) spawnBullet(angle+45-5, 0);
						if (Math.floor(shootCounter) % 5 == 0) spawnBullet(angle+45, 0);
						if (Math.floor(shootCounter) % 10 == 0) spawnBullet(angle+45+5, 0);
						break;
					case 3:
						if (Math.floor(shootCounter) % 10 == 0) spawnBullet(angle+45-5, 0);
						if (Math.floor(shootCounter) % 5 == 0) spawnBullet(angle+45, 1);
						if (Math.floor(shootCounter) % 10 == 0) spawnBullet(angle+45+5, 0);
						break;
					case 4:
						if (Math.floor(shootCounter) % 5 == 0) spawnBullet(angle+45-5, 0);
						if (Math.floor(shootCounter) % 5 == 0) spawnBullet(angle+45, 1);
						if (Math.floor(shootCounter) % 5 == 0) spawnBullet(angle+45+5, 0);
						break;
					case 5:
						if (Math.floor(shootCounter) % 10 == 0) spawnBullet(angle+45-15, 0);
						if (Math.floor(shootCounter) % 5 == 0) spawnBullet(angle+45-5, 1);
						if (Math.floor(shootCounter) % 5 == 0) spawnBullet(angle+45, 1);
						if (Math.floor(shootCounter) % 5 == 0) spawnBullet(angle+45+5, 1);
						if (Math.floor(shootCounter) % 10 == 0) spawnBullet(angle+45+15, 0);
						break;
					case 6:
						if (Math.floor(shootCounter) % 10 == 0) spawnBullet(angle+45-15, 0);
						if (Math.floor(shootCounter) % 5 == 0) spawnBullet(angle+45-5, 1);
						if (Math.floor(shootCounter) % 1 == 0) spawnBullet(angle+45, 2);
						if (Math.floor(shootCounter) % 5 == 0) spawnBullet(angle+45+5, 1);
						if (Math.floor(shootCounter) % 10 == 0) spawnBullet(angle+45+15, 0);
						break;
				}
			}
		}
		
		private function spawnBullet(a:Number,T:int = 0):void
		{
			var pb:PBullet = PlayState.PBulletGrp.getFirstAvail() as PBullet;
			var r:FlxPoint = FlxU.rotatePoint(x, y, cent.x, cent.y, angle);
			if (pb)
				pb.rebuild(x + (width / 2), y + (height / 2), a,T);
			else
				PlayState.PBulletGrp.add(new PBullet(r.x, r.y, a, T));
			lastShot = Math.floor(shootCounter);
		}
		
		override public function hurt(Damage:Number):void
		{
			if (!flickering()) flicker(1);
		}
		
		
	}

}