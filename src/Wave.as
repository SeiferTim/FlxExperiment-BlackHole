package  
{
	import org.flixel.FlxG;
	public dynamic class Wave extends Array
	{
		
		public function Wave():void
		{
			
			for (var i:int = 0; i < 12; i++)
				this.push(new Array());
			
		}
		
		public function addItem(Time:int, Ship:int,DX:Number, DY:Number, SubTime:int):void
		{
			//FlxG.log(Time);
			this[Time].push(new Array(Ship, DX, DY, SubTime));
		}
		
	}

}