package  
{
	import org.flixel.FlxGame;
	import org.flixel.FlxG;
	[SWF(width = "320", height = "480", backgroundColor = "#000000")]
	[Frame(factoryClass="Preloader")]
	public class BlackHole extends FlxGame
	{
		
		public function BlackHole() 
		{
			super(160, 240, PlayState, 2);
			FlxG.framerate = 200;
			
		}
		
	}

}