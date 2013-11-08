package  
{
	import org.flixel.FlxG;
	public class Waves
	{
		
		private var waves:Array;
		public function Waves() 
		{
			waves = new Array();
			
			// setup a bunch of waves		
			var w:Wave = new Wave();
			
			w.addItem(0,  1, 10, 0, 0);
			w.addItem(0, 1, 30, 0, 0);
			w.addItem(0, 1, -10, 0, 0);
			w.addItem(0, 1, -30, 0, 0);
			
			w.addItem(1,  1, 10, 0, 0);
			w.addItem(1, 1, 20, 0, 0);
			w.addItem(1, 1, 30, 0, 0);
			w.addItem(1, 1, -10, 0, 0);
			w.addItem(1, 1, -20, 0, 0);
			w.addItem(1, 1, -30, 0, 0);
			
			
			w.addItem(2,  1, 10, 0, 0);
			w.addItem(2, 1, 30, 0, 0);
			w.addItem(2, 1, -10, 0, 0);
			w.addItem(2, 1, -30, 0, 0);
			w.addItem(2, 2, 20, -10, 1);
			w.addItem(2, 2, -20, -10, 1);
			w.addItem(2,  1, 10, -20, 2);
			w.addItem(2, 1, 30, -20, 2);
			w.addItem(2, 1, -10, -20, 2);
			w.addItem(2, 1, -30, -20, 2);
			
			w.addItem(3,  1, 10, 0, 0);
			w.addItem(3, 1, 20, 0, 0);
			w.addItem(3, 1, 30, 0, 0);
			w.addItem(3, 1, -10, 0, 0);
			w.addItem(3, 1, -20, 0, 0);
			w.addItem(3, 1, -30, 0, 0);
			w.addItem(3, 1, 10, -10, 1);
			w.addItem(3, 1, 20, -10, 1);
			w.addItem(3, 1, 30, -10, 1);
			w.addItem(3, 1, -10, -10, 1);
			w.addItem(3, 1, -20, -10, 1);
			w.addItem(3, 1, -30, -10, 1);
			w.addItem(3, 1, 10, -20, 2);
			w.addItem(3, 1, 20, -20, 2);
			w.addItem(3, 1, 30, -20, 2);
			w.addItem(3, 1, -10, -20, 2);
			w.addItem(3, 1, -20, -20, 2);
			w.addItem(3, 1, -30, -20, 2);
			
			w.addItem(4,  1, 10, 0, 0);
			w.addItem(4, 21, 20, 0, 0);
			w.addItem(4, 1, 30, 0, 0);
			w.addItem(4, 1, -10, 0, 0);
			w.addItem(4, 2, -20, 0, 0);
			w.addItem(4, 1, -30, 0, 0);
			w.addItem(4, 1, 10, -10, 1);
			w.addItem(4, 1, 20, -10, 1);
			w.addItem(4, 1, 30, -10, 1);
			w.addItem(4, 1, -10, -10, 1);
			w.addItem(4, 1, -20, -10, 1);
			w.addItem(4, 1, -30, -10, 1);
			w.addItem(4, 1, 10, -20, 2);
			w.addItem(4, 2, 20, -20, 2);
			w.addItem(4, 1, 30, -20, 2);
			w.addItem(4, 1, -10, -20, 2);
			w.addItem(4, 2, -20, -20, 2);
			w.addItem(4, 1, -30, -20, 2);
			
			w.addItem(5,  1, 10, 0, 0);
			w.addItem(5, 1, 20, 0, 0);
			w.addItem(5, 1, 30, 0, 0);
			w.addItem(5, 1, -10, 0, 0);
			w.addItem(5, 1, -20, 0, 0);
			w.addItem(5, 1, -30, 0, 0);
			w.addItem(5, 2, -20, -20, 1);
			w.addItem(5, 2, -20, -20, 1);
			w.addItem(5, 2, -40, -40, 2);
			w.addItem(5, 2, -40, -40, 2);

			waves.push(w);
			
			w = new Wave();
			
			w.addItem(0, 2, 0, 0, 0);
			
			w.addItem(1, 2, -10, 0,0);
			w.addItem(1, 2, 10, 0, 0);
			
			w.addItem(2, 2, -20, 0,0);
			w.addItem(2, 2, 20, 0,0);
			w.addItem(2, 2, -10, 0,0);
			w.addItem(2, 2, 10, 0, 0);
			
			w.addItem(3, 2, -20, 0,0);
			w.addItem(3, 2, 20, 0,0);
			w.addItem(3, 2, -10, 0,0);
			w.addItem(3, 2, 10, 0, 0);
			
			
			waves.push(w);
			
			w = new Wave();
			
			w.addItem(0, 1, -50, 0, 0);
			w.addItem(0, 1, 50, 0, 0);
			w.addItem(1, 1, -25, 0, 0);
			w.addItem(1, 1, 25, 0, 0);
			w.addItem(2, 1, -50, -10, 2);
			w.addItem(2, 1, 50, -10, 2);
			w.addItem(3, 1, -25, -10, 2);
			w.addItem(3, 1, 25, -10, 2);
			w.addItem(4, 1, -50, -20, 4);
			w.addItem(4, 1, 50, -20, 4);
			w.addItem(5, 1, -25, -20, 4);
			w.addItem(5, 1, 25, -20, 4);
			waves.push(w);
			
			w = new Wave();
			waves.push(w);
			
			w = new Wave();
			waves.push(w);
			
			w = new Wave();
			waves.push(w);
			
			w = new Wave();
			waves.push(w);
			
			w = new Wave();
			waves.push(w);
			
			w = new Wave();
			waves.push(w);
			
			w = new Wave();
			waves.push(w);
			
			w = new Wave();
			waves.push(w);

		}
		
		public function waveSpawn(W:int, Time:int, SubTime:int):void
		{
			//FlxG.log(W + " " + Time + " " + waves[W].length);
			//FlxG.log(waves[0][0].length + " " + W + " " + Time);
			if (W < 0 || Time >= waves[W].length) return;
			//FlxG.log(waves[W][Time].length);
			for (var i:int = 0; i < waves[W][Time].length; i++)
			{
				//FlxG.log(i);
				if (waves[W][Time][i][3] == SubTime)
				{
					PlayState.SpawnEnemy(waves[W][Time][i][0], waves[W][Time][i][1], waves[W][Time][i][2]);
				}
			}
		}
	}

}