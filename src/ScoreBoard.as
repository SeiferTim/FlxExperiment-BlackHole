package  
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxG;
	import org.flixel.FlxText;
	
	public class ScoreBoard extends FlxGroup
	{
		[Embed(source = 'pixel_maz.ttf', fontFamily = "A", embedAsCFF="false")] private var FntA:Class;
		public var mainTxt:FlxText;
		private var mT:MiniText;
		private var lastScore:Number;
		private var lastMulti:Number;
		public var currentAmt:Number;
		
		public function ScoreBoard():void
		{
			super();
			currentAmt = 0;
			lastScore = 0;
			//setAmt = 0;
			mainTxt = add(new FlxText(2, 0, FlxG.width - 4, "0",true)) as FlxText;
			mainTxt.setFormat("A", 16, 0xffffff, "right", 0x444444);
			mT = add(new MiniText(this)) as MiniText;
		}
		
		override public function update():void
		{
			var diff:Number = PlayState.preScore - lastScore;
			
			if (diff != 0 || (lastMulti != PlayState.scoreMulti && PlayState.scoreMulti > 0))
			{
				lastScore = PlayState.preScore;
				mT.addScore(diff);
			}
			lastMulti = PlayState.scoreMulti;
			if (currentAmt < FlxG.score - 100)
				currentAmt += 100;
			if (currentAmt < FlxG.score - 50)
				currentAmt += 50;
			else if (currentAmt < FlxG.score - 10)
				currentAmt += 10;
			else if (currentAmt < FlxG.score)
				currentAmt += 1;
			else if (currentAmt > FlxG.score + 10)
				currentAmt -= 10;
			else if (currentAmt > FlxG.score)
				currentAmt -= 1;
			mainTxt.text = String(currentAmt);
			super.update();
		}
		
		public function setText(Amt:Number):void
		{
			FlxG.score += Amt;
		}
		
	}

}