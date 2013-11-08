package org.flixel
{	
	import org.osflash.signals.Signal;
	/**
	 * ...
	 * @author Kronoshifter
	 */
	public class FlxTimer
	{
		protected var _delay:Number;
		protected var _timeLeft:Number;
		protected var _running:Boolean;
		protected var _dispatchOnStart:Boolean;
		protected var _complete:Signal;
 
		/**
		 * The timer's current state; true if the timer is running, otherwise false.
		 */
		public function get running():Boolean 
		{
			return _running;
		}
 
		public function get delay():Number 
		{ 
			return _delay; 
		}
 
		public function set delay(value:Number):void 
		{
			_delay = value;
			stop();
		}
 
		/**
		 * Creates a FlxTimer object. Call add() to add a method to be called by the timer.
		 * Remember to call FlxG.addTimer(), or addTimer() from FlxState or anything that inherits from FlxObject.
		 * The best way to add a new timer is something like this:
		 * var timer:FlxTimer = FlxG.addTimer(new FlxTimer(1));
		 * 
		 * @param	delay				The delay, in seconds, of the timer.
		 * @param	dispatchOnStart		Whether this timer should dispatch its listener when the start() method is called.
		 */
		public function FlxTimer(delay:Number, dispatchOnStart:Boolean = false)
		{
			_delay = delay;
			_timeLeft = delay;
			_dispatchOnStart = dispatchOnStart;
 
			_complete = new Signal();
 
			_running = false;
		}
 
		/**
		 * Starts the timer. If the timer is started, it will be restarted.
		 * 
		 * @return	This FlxTimer instance. Nice for chaining stuff together.
		 */
		public function start():FlxTimer
		{	
			if (_running) 
			{
				stop();
				start();
			}
			else
			{
				if (_dispatchOnStart) dispatch();
				_running = true;
			}
 
			return this;
		}
 
		/**
		 * Stops the timer.
		 * 
		 * @return	This FlxTimer instance. Nice for chaining stuff together.
		 */
		public function stop():FlxTimer
		{
			_running = false;
			_timeLeft = _delay;
 
			return this;
		}
 
		public function update():void 
		{
			if (_running) 
			{
				_timeLeft -= FlxG.elapsed;
				if (_timeLeft <= 0) 
				{
					dispatch();
					_timeLeft = _delay;
				}
			}
		}
 
		public function toString():String
		{
			return '[FlxTimer: delay = ' + _delay.toString() + ']';
		}
 
		/* DELEGATE org.osflash.signals.Signal */
 
		public function add(listener:Function):Function 
		{
			return _complete.add(listener);
		}
 
		public function addOnce(listener:Function):Function 
		{
			return _complete.addOnce(listener);
		}
 
		public function dispatch(...valueObjects):void 
		{
			_complete.dispatch.apply(null, valueObjects);
		}
 
		public function remove(listener:Function):Function 
		{
			return _complete.remove(listener);
		}
 
		public function removeAll():void 
		{
			_complete.removeAll();
		}
 
	}
 
}