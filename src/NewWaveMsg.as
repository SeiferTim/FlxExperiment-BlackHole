package  
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxU;
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	import org.flixel.FlxText;
	import org.flixel.FlxObject;
	
	public class NewWaveMsg extends FlxGroup
	{
		[Embed(source = 'pixel_maz.ttf', fontFamily = "A", embedAsCFF = "false")] private var FntA:Class;
		public var waveNo:int;
		private var sprBack1:FlxSprite;
		private var sprBack2:FlxSprite;
		private var sprBack3:FlxSprite;
		private var sprBack4:FlxSprite;
		private var txtText:FlxText;
		private var boss:Boolean = false;
		private var goingUp:Boolean = true;
		private var tmr:Number = 5;
		
		public function NewWaveMsg(No:int, Boss:Boolean = false):void
		{
			super();
			sprBack1 = add(new FlxSprite(0, (FlxG.height / 2) - 20)) as FlxSprite;
			sprBack2 = add(new FlxSprite(0, (FlxG.height / 2) - 10)) as FlxSprite;
			sprBack3 = add(new FlxSprite(0, (FlxG.height / 2))) as FlxSprite;
			sprBack4 = add(new FlxSprite(0, (FlxG.height / 2) + 10)) as FlxSprite;
			sprBack1.createGraphic(FlxG.width, 10, 0xcc000000);
			sprBack2.createGraphic(FlxG.width, 10, 0xcc000000);
			sprBack3.createGraphic(FlxG.width, 10, 0xcc000000);
			sprBack4.createGraphic(FlxG.width, 10, 0xcc000000);
			txtText = add(new FlxText(0, (FlxG.height / 2) - 20, FlxG.width, "", true)) as FlxText;
			//rebuild(No, Boss);
			kill();
		}
		
		public function rebuild(No:int, Boss:Boolean = false):void
		{
			super.reset(0, 0);

			waveNo = No;
			boss = Boss;
			goingUp = true;
			tmr = 5;
			sprBack1.alpha = 0;
			sprBack2.alpha = 0;
			sprBack3.alpha = 0;
			sprBack4.alpha = 0;
			txtText.alpha = 0;
			sprBack1.velocity.x = 0;
			sprBack2.velocity.x = 0;
			sprBack3.velocity.x = 0;
			sprBack4.velocity.x = 0;
			sprBack1.acceleration.x = 0;
			sprBack2.acceleration.x = 0;
			sprBack3.acceleration.x = 0;
			sprBack4.acceleration.x = 0;
			sprBack1.x = 0;
			sprBack2.x = 0;
			sprBack3.x = 0;
			sprBack4.x = 0;
			txtText.velocity.x = 0;
			txtText.acceleration.x = 0;
			txtText.x = 0;
			sprBack1.dead = false;
			sprBack1.exists = true;
			sprBack2.dead = false;
			sprBack2.exists = true;
			sprBack3.dead = false;
			sprBack3.exists = true;
			sprBack4.dead = false;
			sprBack4.exists = true;
			txtText.dead = false;
			txtText.exists = true;
			sprBack1.y = (FlxG.height / 2) - 20;
			sprBack2.y = (FlxG.height / 2) - 10;
			sprBack3.y = (FlxG.height / 2);
			sprBack4.y = (FlxG.height / 2) + 10;
			txtText.y = (FlxG.height / 2) - 15;
			
			if (boss)
			{
				txtText.text = "! BOSS APPROACHING !"
				txtText.setFormat("A", 40, 0xffff0000, "center", 0x66330000);
			}
			else
			{
				txtText.text = "WAVE " + No;
				txtText.setFormat("A", 40, 0xffffffff, "center", 0x66333333);
			}
		}
		
		override public function update():void
		{
			if (dead || !exists) return;
			PlayState.P_FROZEN = true;
			if (goingUp)
			{
				if (sprBack1.alpha >= 1)
				{
					if (txtText.alpha >=1)
						goingUp = false;
					else
						txtText.alpha += 0.2;
				}
				else
				{
					sprBack1.alpha += 0.2;
					sprBack2.alpha += 0.2;
					sprBack3.alpha += 0.2;
					sprBack4.alpha += 0.2;
					
				}
			}
			else
			{
				if (tmr <= 0)
				{				
					if (sprBack1.x == 0)
					{
						sprBack1.acceleration.x = -FlxG.width * 40;
						txtText.acceleration.x = -FlxG.width * 10;
					}
					if (sprBack1.x <= -(FlxG.width / 2))
						sprBack2.acceleration.x = -FlxG.width * 40;
					if (sprBack2.x <= -(FlxG.width / 2))
						sprBack3.acceleration.x = -FlxG.width * 40;
					if (sprBack3.x <= -(FlxG.width / 2))
						sprBack4.acceleration.x = -FlxG.width * 40;
					if (sprBack4.x <= -FlxG.width)
						kill();
				}
				else
					tmr -= FlxG.elapsed * 2;
			}
			super.update();
		}
		
		override public function kill():void
		{
			super.kill();
			PlayState.P_FROZEN = false;
		}
		
	}

}