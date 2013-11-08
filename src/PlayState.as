package  
{
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import org.flixel.FlxU;
	import org.flixel.FlxGame;
	import org.flixel.FlxState;
	import org.flixel.FlxPoint;
	import org.flixel.FlxTimer;
	import com.gskinner.utils.Rnd;
	import as3utils.NumberUtil;
	
	public class PlayState extends FlxState
	{
		[Embed(source = 'eh.png')]private var ImgEH:Class;
		//STATUSES
		public static var P_FROZEN:Boolean = true;
		public static var BH_FROZEN:Boolean = true;
		
		
		public static var PHealth:Number;
		public static var PMaxHealth:Number = 100;
		
		public static var PLevel:Number = 1;
		public static var PXP:Number = 0;
		
		public static var scoreMulti:int = 0;
		public static var preScore:int = 0;
		
		// CONSTS
		private const MAX_DUST:Number = 2000;
		public const holeCenter:FlxPoint = new FlxPoint(FlxG.width/2, FlxG.height / 4);
		
		// LAYERS
		private var dustGrp:TrailLayer;
		public static var debrisGrp:TrailLayer;
		private var fxobj:FlxSprite;
		public static var Enemies:FlxGroup;
		public static var exLayer:ExhaustLayer;
		private var playLayer:FlxGroup;
		public static var EBulletGrp:FlxGroup;
		public static var PBulletGrp:FlxGroup;
		public static var CollectableGrp:FlxGroup;
		private var eh:FlxSprite;
		private var HUD:FlxGroup;
		private var NewWave:NewWaveMsg;
		
		// MISC
		public static var P:Player;
		private var ScoreB:ScoreBoard;
		private var HealthB:HealthMeter;
		private var waves:Waves;
		
		// TIMERS
		private var gameEvents:Number = 0;
		private var newGameMode:int = 0;
		private var waveTimer:FlxTimer = FlxG.addTimer(new FlxTimer(5));
		private var waveSubTimer:FlxTimer = FlxG.addTimer(new FlxTimer(1));
		private var waveNo:int = 0;
		private var waveTime:int = 0;
		private var waveSubTime:int = 10;
		private var waveInc:Number = 0;
		
		public function PlayState()
		{
			P_FROZEN = true;
			BH_FROZEN = true;
			createWorld();
			waves = new Waves();
			PMaxHealth = 100;
			PHealth = 100;
			PXP = 0;
			PLevel = 1;
			scoreMulti = 0;
			preScore = 0;
			FlxG.score = 0;
			newGameMode = 0;
			gameEvents = 1;
			for (var i:int = 0; i < MAX_DUST*0.5; i++)
				dustGrp.add(new StarDust(Rnd.float(-5,FlxG.width+5), Rnd.float(-5,FlxG.height+5), holeCenter.x, holeCenter.y)) as StarDust;
			createDust();
		}
		
		private function createWorld():void
		{
			eh = add(new FlxSprite(holeCenter.x - 40, holeCenter.y - 40).loadGraphic(ImgEH, false, false, 80, 80)) as FlxSprite;
			eh.angularVelocity = -100;
			eh.alpha = 0;
			dustGrp = add(new TrailLayer()) as TrailLayer;
			
			fxobj = add(new FlxSprite(0, 0)) as FlxSprite;
			fxobj.createGraphic(FlxG.width, FlxG.height, 0x88110066);
			fxobj.blend = "overlay";
			
			exLayer = add(new ExhaustLayer()) as ExhaustLayer;
			debrisGrp = add(new TrailLayer()) as TrailLayer;
			PBulletGrp = add(new FlxGroup()) as FlxGroup;
			EBulletGrp = add(new FlxGroup()) as FlxGroup;
			CollectableGrp = add(new FlxGroup()) as FlxGroup;
			Enemies = add(new FlxGroup()) as FlxGroup;
			playLayer = add(new FlxGroup()) as FlxGroup;
			P = playLayer.add(new Player()) as Player;
			
			FlxG.mouse.cursor = new FlxSprite().createGraphic(1, 1, 0x00000000);
			P.x = (FlxG.width / 2) - (P.width / 2);
			P.y = FlxG.height + 50;
			P.angle = 45;
			HUD = add(new FlxGroup()) as FlxGroup;
			HUD.add(new FlxSprite(0, 0).createGraphic(2, FlxG.height, 0x99ffffff));
			HUD.add(new FlxSprite(2, 0).createGraphic(FlxG.width-4, 2, 0x99ffffff));
			HUD.add(new FlxSprite(2,FlxG.height-2).createGraphic(FlxG.width-4, 2, 0x99ffffff));
			HUD.add(new FlxSprite(FlxG.width-2, 0).createGraphic(2, FlxG.height, 0x99ffffff));
			HUD.add(new FlxSprite(0, 0).createGraphic(1, FlxG.height, 0x99ffffff));
			HUD.add(new FlxSprite(1, 0).createGraphic(FlxG.width-2, 1, 0x99ffffff));
			HUD.add(new FlxSprite(1,FlxG.height-1).createGraphic(FlxG.width-2, 1, 0x99ffffff));
			HUD.add(new FlxSprite(FlxG.width - 1, 0).createGraphic(1, FlxG.height, 0x99ffffff));
			ScoreB = HUD.add(new ScoreBoard()) as ScoreBoard;
			HealthB  = HUD.add(new HealthMeter()) as HealthMeter;
			waveNo = 0;
			waveTime = -1;
			waveTimer.add(waveTimerUp);
			NewWave = HUD.add(new NewWaveMsg(waveNo, false)) as NewWaveMsg;
			P_FROZEN = true;
		}
		
		public static function givePoint(Amt:Number):void
		{
			preScore += Amt;			
		}
		
		private function doneFade():void
		{
			FlxG.state = new GameOver();
		}
		
		override public function update():void
		{
			checkNewGame();
			if (PlayState.PHealth <= 0 && !P_FROZEN)
			{
				P_FROZEN = true;
				FlxG.fade.start(0xff000000, 1, doneFade, true);
			}
			else
			{
				FlxU.overlap(PBulletGrp, Enemies, PBulletHitEnemy);
				FlxU.overlap(EBulletGrp, P, EBulletHitPlayer);
				FlxU.overlap(CollectableGrp, P, collect);
				//FlxU.overlap(Enemies, Enemies, ECollidesE);
				FlxU.overlap(P, Enemies, PCollidesE);
				if (dustGrp.countLiving() < MAX_DUST) createDust();
				if (waveSubTime < 10)
				{
					if (waveInc <= 0)
					{
						waveInc = FlxG.elapsed*6;
						waves.waveSpawn(waveNo, waveTime, waveSubTime);
						waveSubTime++;
					}
					else
						waveInc -= FlxG.elapsed * 0.33;
				}
			}
			super.update();
			
		}
		
		private function ECollidesE(E1:Enemy, E2: Enemy):void
		{
			
			if (E1.dead || !E1.exists || E2.dead || !E2.exists) return;
			//ships should stop and bounce away from each other...
			//get angle of one ship to another and move them away...
			var a:Number = FlxU.getAngle(E1.cent.x - E2.cent.x, E1.cent.y - E2.cent.y);
			var acc1:FlxPoint = new FlxPoint();
			acc1 = FlxU.rotatePoint( -10, 0, 0, 0, a);
			var acc2:FlxPoint = new FlxPoint();
			acc2 = FlxU.rotatePoint( 10, 0, 0, 0, a);
			E1.bounce(acc1);
			E2.bounce(acc2);
		}
		
		private function PCollidesE(Pl:Player, E:Enemy):void
		{
			if (Pl.dead || !Pl.exists || E.dead || !E.exists) return;
			PHealth -= 2;
			E.hurt(100);
		}
		
		private function collect(C:Collectable, Pl:Player):void
		{
			if (Pl.dead || !Pl.exists || C.dead || !C.exists) return;
			switch(C.type)
			{
				case 0:
					PXP += 5;
					if (PXP >= getXPToLevel(PLevel)) 
					{
						PLevel++;
						PXP = 0;
					}
					break;
				case 1:
					PHealth += 10;
					if (PHealth > PMaxHealth) PHealth = PMaxHealth;
					break;
			}
			C.kill();
		}
		
		public static function SpawnCollect(X:Number, Y:Number, Type:int):void
		{
			var c:Collectable = CollectableGrp.getFirstAvail() as Collectable;
			if (c)
				c.rebuild(X, Y, Type);
			else
				CollectableGrp.add(new Collectable(X, Y, Type));
		}
		
		private function EBulletHitPlayer(EB:EBullet, P:Player):void
		{
			if (EB.dead || !EB.exists || P.dead || !P.exists || P.flickering()) return;
			EB.kill();
			P.hurt(0);
			PHealth -= 5;
			scoreMulti = 0;
			givePoint(0);
		}
		
		private function PBulletHitEnemy(PB:PBullet, E:Enemy):void
		{
			if (E.dead || !E.exists || PB.dead || !PB.exists) return;
			E.hurt(PB.power);
			PB.kill();
		}
		
		private function checkNewGame():Boolean
		{
			if (newGameMode == -1) return false;
			switch(newGameMode)
			{
				case 0:
					if (P.y <= ((FlxG.height/2) + Math.sin((90 / 180) * Math.PI) * 90) - (P.height / 2))
					{
						P.y = ((FlxG.height/2) + Math.sin((90 / 180) * Math.PI) * 90) - (P.height / 2)
						newGameMode = 1;
					}
					else
						P.y--;
					break;
				case 1:
					if (gameEvents <= 0)
					{
						FlxG.flash.start(0xffffffff, 1);
						if (eh.alpha >= 0.7)
						{
							newGameMode = 2;
							waveTimer.start();
							gameEvents = 3;
						}
						else
							eh.alpha += 0.01;
						BH_FROZEN = false;
					}
					else
						gameEvents -= FlxG.elapsed * 2;
					break;
				case 2:
					if (gameEvents <= 0)
					{
						NewWave.rebuild(waveNo + 1, false);
						newGameMode = -1;
					}
					else
						gameEvents -= FlxG.elapsed * 2;
					
					break;
			}
			return true;
		}
		
		
		
		private function waveTimerUp():void
		{
			if(Enemies.countLiving() > 0 || P_FROZEN)
			{
				waveTimer.start();
				return;
			}
			if (waveTime > 6)
			{
				waveTime = 0;
				waveNo++;
				// new wave message
				NewWave.rebuild(waveNo + 1, false);
			}
			else
			{
				if (waveNo < 6)
				{
					waveSubTime = 0;
					waveTimer.start();
				}
				waveTime++;
			}
			
			// okay, we want to increment to the next wave number only when all the enemies are dead, but sub-number (.2, etc) should be incremented...
			
		}
		
		private function createDust():void
		{
			var d:StarDust;
			for (var j:int = dustGrp.countLiving(); j < MAX_DUST; j++)
			{
				d = dustGrp.getFirstAvail() as StarDust;
				switch (Rnd.integer(0, 3))
				{
					case 0:
						if (d)
							d.rebuild(Rnd.integer( -5, FlxG.width + 5), Rnd.integer( -5, 0), holeCenter.x, holeCenter.y);
						else
							dustGrp.add(new StarDust(Rnd.integer(-5,FlxG.width+5), Rnd.integer(-5,0), holeCenter.x, holeCenter.y)) as StarDust;
						break;
					case 1:
						if (d)
							d.rebuild(Rnd.integer(-5,0), Rnd.integer(0,FlxG.height), holeCenter.x, holeCenter.y);
						else
							dustGrp.add(new StarDust(Rnd.integer(-5,0), Rnd.integer(0,FlxG.height), holeCenter.x, holeCenter.y)) as StarDust;
						break;
					case 2:
						if (d)
							d.rebuild(Rnd.integer(FlxG.width,FlxG.width+5), Rnd.integer(0,FlxG.height), holeCenter.x, holeCenter.y);
						else
							dustGrp.add(new StarDust(Rnd.integer(FlxG.width,FlxG.width+5), Rnd.integer(0,FlxG.height), holeCenter.x, holeCenter.y)) as StarDust;
						break;
					case 3:
						if (d)
							d.rebuild(Rnd.integer(-5,FlxG.width+5), Rnd.integer(FlxG.height,FlxG.height+20), holeCenter.x, holeCenter.y);
						else
							dustGrp.add(new StarDust(Rnd.integer(-5,FlxG.width+5), Rnd.integer(FlxG.height,FlxG.height+20), holeCenter.x, holeCenter.y)) as StarDust;
						break;
				}
			}
		}
		
		public static function SpawnEnemy(EType:int, DX:Number, DY:Number):void
		{
			var hC:FlxPoint = new FlxPoint(FlxG.width / 2, FlxG.height / 4);
			var e:Enemy = Enemies.getFirstAvail() as Enemy;
			if (e)
				e.rebuild(hC.x + DX, hC.y + DY, EType);// , DX, DY);
			else
				e = Enemies.add(new Enemy(hC.x + DX, hC.y + DY, EType)) as Enemy;//,DX,DY)) as Enemy;
		}
		
		public static function getMulti():int
		{
			// this returns the current multiplier based on the current kills...
			return Math.floor(.5 + Math.sqrt(2) * Math.sqrt((scoreMulti / 3) + 1 / 8));
		}
		
		public static function getXPToLevel(Level:int):Number
		{
			return Level * 250;
		}
		
		
	}

}