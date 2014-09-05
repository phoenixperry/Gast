package 
{
	import starling.animation.Juggler;
	import starling.animation.Tween;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	
	public class TestAnim extends Sprite
	{
		private var _initColor:int;
		private var _finalColor:int;
		
		private var _currentColor:int;
		private var _currentProgress:Number;
		
		private var _juggler:Juggler;
		
		private var _colorizedItem:Quad;
		
		public function TestAnim()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			//item + init color
			_initColor = 0xFF0000;
			_finalColor = 0x0000FF;
			_colorizedItem = new Quad(300, 300, _initColor);
			_colorizedItem.x = 100; _colorizedItem.y = 100;
			this.addChild(_colorizedItem);
			
			calculateStartAndFinalColorsArgbs();
			_currentProgress = 0;
			//first update
			updateColor();
			
			//juggler
			_juggler = new Juggler();
			//small delay
			_juggler.delayCall(startAnim, 0.5);
			
			//mark for update
			this.addEventListener(EnterFrameEvent.ENTER_FRAME, onEnterFrame);
		}
		
		private function startAnim():void
		{
			var tweenColor:Tween = new Tween(this, 5);
			tweenColor.animate("currentProgress", 1);
			_juggler.add(tweenColor);
		}
		
		private function onEnterFrame(e:EnterFrameEvent):void
		{
			_juggler.advanceTime(e.passedTime);
		}
		
		// --------------------------------------------------------------------------------------------------------------------------------
		// modified by tween
		public function get currentProgress():Number { return _currentProgress; }
		public function set currentProgress(value:Number):void
		{
			_currentProgress = value;
			updateColor();
		}
		// --------------------------------------------------------------------------------------------------------------------------------
		
		// --------------------------------------------------------------------------------------------------------------------------------
		// color management
		private function updateColor():void
		{
			//calculate the current color
			calculateColorBasedOnProgress();
			
			//set color
			_colorizedItem.color = _currentColor;
		}
		private function calculateColorBasedOnProgress():void
		{
			var rCurrent:Number = rStart + (rFinal - rStart) * _currentProgress,
				gCurrent:Number = gStart + (gFinal - gStart) * _currentProgress,
				bCurrent:Number = bStart + (bFinal - bStart) * _currentProgress;
			
			_currentColor = toRGB(rCurrent, gCurrent, bCurrent);
		}
		
		private var rStart:Number, gStart:Number, bStart:Number;
		private var rFinal:Number, gFinal:Number, bFinal:Number;
		private function calculateStartAndFinalColorsArgbs():void
		{
			//start
			rStart = getRed(_initColor);  gStart = getGreen(_initColor);  bStart = getBlue(_initColor);
			//final
			rFinal = getRed(_finalColor); gFinal = getGreen(_finalColor); bFinal = getBlue(_finalColor);
		}
		
		private function getRed(color:int):int { return (( color >> 16 ) & 0xFF); }
		private function getGreen(color:int):int { return ( (color >> 8) & 0xFF ); }
		private function getBlue(color:int):int { return ( color & 0xFF ); }
		
		private function toRGB(red:int, green:int, blue:int):int { return ( ( red << 16 ) | ( green << 8 ) | blue ); }
		// --------------------------------------------------------------------------------------------------------------------------------
		
		override public function dispose():void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			this.removeEventListener(EnterFrameEvent.ENTER_FRAME, onEnterFrame);
			
			_juggler.purge();
			_juggler = null;
			
			if (_colorizedItem) {
				_colorizedItem.removeFromParent(true);
				_colorizedItem = null;
			}
			
			super.dispose();
		}
	}
}