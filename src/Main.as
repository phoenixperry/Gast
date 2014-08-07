
package{
	import flash.display.Screen;
	import flash.utils.Timer;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;

	public class Main extends starling.display.Sprite{
		private var timeOut:Timer; 
		private var ghbtn01:starling.display.Button; 
		private var hhbtn02:starling.display.Button; 
		private var lsbtn03:starling.display.Button;
		private var jsbtn04:starling.display.Button; 
		private var fdbtn05:starling.display.Button;
		private var mtbtn06:starling.display.Button;
		private var aybtn07:starling.display.Button;
		
		public var language:String = "en"; 
	 	
		[Embed(source="./assets/background.png")]
		private var bgBit:Class; 
		private var bgTexture:Texture; 
		private var bgImage:Image; 
//		
		[Embed(source="./assets/01hg_btn.png")]
		private var btn01bit:Class; 
		private var btn01Texture:Texture; 
		private var btn01:Image; 
		
		[Embed(source="./assets/02hh_btn.png")]
		private var btn02Bit:Class;  
		private var btn02Texture:starling.textures.Texture; 
		private var btn02:Image; 
		
		[Embed(source="./assets/03ls_btn.png")]
		private var btn03Bit:Class; 
		private var btn03Texture:starling.textures.Texture; 
		private var btn03:Image; 
		
		[Embed(source="./assets/04js_btn.png")]
		private var btn04Bit:Class; 
		private var btn04Texture:starling.textures.Texture; 
		private var btn04:Image; 

		[Embed(source="./assets/05fd_btn.png")]
		private var btn05Bit:Class; 
		private var btn05Texture:starling.textures.Texture; 
		private var btn05:Image; 
		
		[Embed(source="./assets/06mt_btn.png")]
		private var btn06Bit: Class;  
		private var btn06Texture:starling.textures.Texture; 
		private var btn06:Image; 
		
		[Embed(source="./assets/07ay_btn.png")]
		private var btn07Bit:Class; 
		private var btn07Texture:starling.textures.Texture; 
		private var btn07:Image; 
		
		public function Main()
		{
			addEventListener(starling.events.Event.ADDED_TO_STAGE, Init); 
		}
		
		private function Init(e:starling.events.Event):void{
			var bgBitmap = new bgBit(); 
			bgTexture = Texture.fromBitmap(bgBitmap); 
			bgImage = new Image(bgTexture); 
			bgImage.width = 1920; 
			bgImage.height = 1080; 
			addChild(bgImage);
		}
		
	}
}