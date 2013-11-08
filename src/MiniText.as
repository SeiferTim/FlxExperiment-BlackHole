package
{
	import org.flixel.FlxG;
	import org.flixel.FlxText;
	
	public class MiniText extends FlxText
	{
		[Embed(source = 'pixel_maz.ttf', fontFamily = "A", embedAsCFF = "false")] private var FntA:Class;
		private var parent:ScoreBoard;
		private var scoreAmt:Number;
		private var tmr:Number;
		private var showMulti:int;
		
		public function MiniText(P:ScoreBoard, Amt:Number =0):void
		{
			super(2, 10, FlxG.width - 4);
			parent = P;
			setFormat("A", 16, 0xffff00, "right", 0x333333);
			rebuild(Amt);
			alpha = 0;
			exists = false;
		}
		
		public function rebuild(Amt:Number = 0):void
		{
			scoreAmt = 0;
			tmr = 0;
			alpha = 0;
			exists = false;
			if (Amt != 0) addScore(Amt);
		}
		
		override public function update():void
		{
			if (!exists) return;
			if (tmr >= 0)
				tmr -= FlxG.elapsed * 2;
			else if (y >= 0)
			{
				alpha -= 0.01;
				y -= 1;
			}
			else
			{
				text = "";
				parent.setText(scoreAmt * PlayState.getMulti());
				PlayState.scoreMulti = 0;
				scoreAmt = 0;
				exists = false;
			}
			super.update();
		}
		public function addScore(Amt:Number):void
		{	
			
			PlayState.scoreMulti++;
			showMulti = PlayState.getMulti();
			scoreAmt += Amt;
			text = "+" + String(scoreAmt);
			if (showMulti > 1)
				text += " x" + showMulti;
			alpha = 1;
			y = 10;
			tmr = 3;
			exists = true;
		}
	}

}