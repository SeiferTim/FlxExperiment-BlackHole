package  
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	
	public class HealthMeter extends FlxGroup
	{
		private var sprOutline:FlxSprite;
		private var sprInset:FlxSprite
		private var sprFlash:FlxSprite;
		private var sprBar:FlxSprite;
		private var currentAmt:Number;
		private var flashDir:Number = 1;
		
		private var sprXPInset:FlxSprite;
		private var sprXPBar:FlxSprite;
		private var sprXPFlash:FlxSprite;
		private var currentXPAmt:Number;
		
		public function HealthMeter():void 
		{
			super();
			sprOutline = add(new FlxSprite(4, 4)) as FlxSprite;
			sprOutline.createGraphic(52, 8, 0x99ffffff);
			
			sprInset = add(new FlxSprite(5, 5)) as FlxSprite;
			sprInset.createGraphic(50, 3, 0x66000000);
			
			sprBar = add(new FlxSprite(5, 5)) as FlxSprite;
			sprBar.createGraphic(50, 3, 0xff009900);
			
			sprFlash = add(new FlxSprite(5, 5 )) as FlxSprite;
			sprFlash.createGraphic(50, 3, 0xffff0000);
			sprFlash.alpha = 0;
			currentAmt = PlayState.PMaxHealth;
			
			sprXPInset = add(new FlxSprite(5, 9)) as FlxSprite;
			sprXPInset.createGraphic(50, 2, 0x66000000);
			
			sprXPBar = add(new FlxSprite(5,9)) as FlxSprite;
			sprXPBar.createGraphic(1, 2, 0xff3939b7);
			
			sprXPFlash = add(new FlxSprite(5, 9)) as FlxSprite;
			sprXPFlash.createGraphic(50, 2, 0xffe6e6f7);
			sprXPFlash.alpha = 0;
			currentXPAmt = PlayState.PXP;
		}
		
		override public function update():void
		{
			if (currentAmt < PlayState.PHealth - 10)
				currentAmt += 10;
			else if (currentAmt < PlayState.PHealth)
				currentAmt++;
			else if (currentAmt > PlayState.PHealth + 10)
				currentAmt -= 10;
			else if (currentAmt > PlayState.PHealth)
				currentAmt--;
			if (currentAmt / (PlayState.PMaxHealth / 50) != sprBar.width && currentAmt / (PlayState.PMaxHealth / 50) >=1)
			{
				sprBar.createGraphic(currentAmt / (PlayState.PMaxHealth / 50), 3, 0xff009900);
				sprFlash.alpha = 1;
				sprFlash.createGraphic(currentAmt / (PlayState.PMaxHealth / 50) , 3, 0xffff0000);
				sprFlash.alpha = 0;
			}
			if (currentAmt < 30)
			{
				if (flashDir == 1)
				{
					if (sprFlash.alpha >= 1)
						flashDir = -1;
					else
						sprFlash.alpha += 0.1;
				}
				else
					if (sprFlash.alpha <= 0)
						flashDir = 1;
					else
						sprFlash.alpha -= 0.1;
			}
			else
			{
				sprFlash.alpha = 0;
				flashDir = 1;
			}
			var XPFlash:Boolean = false;
			if (currentXPAmt < PlayState.PXP) XPFlash = true;
			if (PlayState.PXP == 0) currentXPAmt = 1;
			else if (currentXPAmt > PlayState.PXP) currentXPAmt = PlayState.PXP;
			else if (currentXPAmt < PlayState.PXP - 50) currentXPAmt += 50;
			else if (currentXPAmt < PlayState.PXP - 10) currentXPAmt += 10;
			else if (currentXPAmt < PlayState.PXP) currentXPAmt += 1;
			if (currentXPAmt / ((PlayState.getXPToLevel(PlayState.PLevel)) / 50) != sprXPBar.width && currentXPAmt / ((PlayState.getXPToLevel(PlayState.PLevel)) / 50) >=1)
			{
				
				sprXPBar.createGraphic(currentXPAmt / ((PlayState.getXPToLevel(PlayState.PLevel)) / 50), 2, 0xff3939b7);
				
				if (XPFlash)
				{
					sprXPFlash.alpha = 1;
					sprXPFlash.createGraphic(currentXPAmt / ((PlayState.getXPToLevel(PlayState.PLevel)) / 50) , 2, 0xffe6e6f7);
				}
			}
			
			if (sprXPFlash.alpha > 0) sprXPFlash.alpha -= 0.05;
			super.update();
		}
		
	}

}