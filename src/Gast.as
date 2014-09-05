package
{
	import flash.display.Sprite;

	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.ui.Mouse;
	
	import starling.core.Starling;
	import starling.events.ResizeEvent;
	
	[SWF(width="1920", height = "1080", frameRate="60", backgroundColor ="#000000")] 
	
	public class Gast extends flash.display.Sprite
	{
		protected var st:Starling; 
		public function Gast() 
		{
			//Mouse.hide(); 
			
			
			stage.align= StageAlign.TOP_LEFT; 	
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			st = new Starling(Main, stage);
			
			stage.addEventListener(ResizeEvent.RESIZE, resizeStage);				
			st.start(); 
			
		}
		private function resizeStage(e:Event) {
			var viewPortRectangle:Rectangle = new Rectangle();
			viewPortRectangle.width = stage.stageWidth;
			viewPortRectangle.height = stage.stageHeight;
			Starling.current.viewPort = viewPortRectangle;
			
			st.stage.stageWidth = stage.stageWidth;
			st.stage.stageHeight = stage.stageHeight;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			goFullScreen(); 
			
			
		}
		private function goFullScreen():void
		{
			stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;		
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align= StageAlign.TOP_LEFT; 	
			stage.align = "";
		}
	}
}