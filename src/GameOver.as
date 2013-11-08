package  
{
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxG;
	
	public class GameOver extends FlxState
	{
		
		public function GameOver():void 
		{
			add(new FlxText(0, 0, FlxG.width, "GAME OVER").setFormat(null,10,0xffffff,"center")) as FlxText;
			
		}
		
	}

}