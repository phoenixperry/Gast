package
{
	import flash.display.Bitmap;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	
	public class HG01 extends Sprite
	{
		[Embed(source="./assets/01hg_photo.png")]
		private var photoBit:Class; 
		private var photoTexture:Texture; 
		private var photoImage:Image; 
		
		[Embed(source="./assets/01hg_sc.png")]
		private var scBit:Class; 
		private var scTexture:Texture; 
		private var scImage:Image; 
		
		[Embed(source="./assets/01hg_tc.png")]
		private var tcBit:Class; 
		private var tcTexture:Texture; 
		private var tcImage:Image; 
	
		
		[Embed(source="./assets/01hg_en.png")]
		private var enBit:Class; 
		private var enTexture:Texture; 
		private var enImage; 
		

		public var lang:String; 
		
		public function HG01()
		{
			super();
			//start off with English as the default langugae 
			var photoBitmap = new photoBit(); 
			photoTexture = Texture.fromBitmap(photoBitmap); 
			photoImage = new Image(photoTexture); 
			photoImage.x = 240; 
			photoImage.y = 263; 
			addChild(photoImage); 
			
			var scBitmap = new scBit(); 
			scTexture = Texture.fromBitmap(scBitmap); 
			scImage = new Image(scTexture); 
			scImage.x = 665; 
			scImage.y = 256; 
			addChild(scImage); 
			
			var tcBitmap = new tcBit(); 
			tcTexture = Texture.fromBitmap(tcBitmap); 
			tcImage = new Image(tcTexture); 
			tcImage.x = 665; 
			tcImage.y = 256; 
			addChild(tcImage); 
			
			var enBitmap = new enBit(); 
			enTexture = Texture.fromBitmap(enBitmap); 
			enImage = new Image(enTexture); 
			enImage.x = 665; 
			enImage.y = 256; 
			addChild(enImage);
			setLang("en"); 
		
		
		}
		
		
		//change the language the popup displays
		public function setLang(lang_:String):void
		{
			lang = lang_; 
			if(lang == "en")
			{
				enImage.alpha = 1; 
				tcImage.alpha = 0 ;
				scImage.alpha = 0; 
			}
			
			if(lang == "tc")
			{
				enImage.alpha = 0; 
				tcImage.alpha = 1 ;
				scImage.alpha = 0; 
			}
			
			if(lang == "sc")
			{
				enImage.alpha = 0; 
				tcImage.alpha = 0 ;
				scImage.alpha = 1; 
			}
		}
		
	}
}