package
{
	import starling.animation.Tween;
	import starling.core.Starling;
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
		
		private var fadeTime = 0.5; 
		
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
			scImage.x = 666; 
			scImage.y = 299; 
			addChild(scImage); 
			
			var tcBitmap = new tcBit(); 
			tcTexture = Texture.fromBitmap(tcBitmap); 
			tcImage = new Image(tcTexture); 
			tcImage.x = 666; 
			tcImage.y = 299; 
			addChild(tcImage); 
			
			var enBitmap = new enBit(); 
			enTexture = Texture.fromBitmap(enBitmap); 
			enImage = new Image(enTexture); 
			enImage.x = 666; 
			enImage.y = 260; 
			addChild(enImage);
			setLang("en"); 
		
		
		}
		
		
		//change the language the popup displays
		public function setLang(lang_:String):void
		{
			lang = lang_; 
			if(lang == "en")
			{
				var tweenEn:Tween = new Tween(enImage, fadeTime); 
				tweenEn.fadeTo(1); 
				Starling.juggler.add(tweenEn); 
					
				var tweenSc:Tween = new Tween(scImage, fadeTime); 
				tweenSc.fadeTo(0); 
				Starling.juggler.add(tweenSc); 
				
				var tweenTc:Tween = new Tween(tcImage, fadeTime); 
				tweenTc.fadeTo(0); 
				Starling.juggler.add(tweenTc); 
	
			}
			
			if(lang == "tc")
			{
				var tweenEn:Tween = new Tween(enImage, fadeTime); 
				tweenEn.fadeTo(0); 
				Starling.juggler.add(tweenEn); 
				
				var tweenSc:Tween = new Tween(scImage, fadeTime); 
				tweenSc.fadeTo(0); 
				Starling.juggler.add(tweenSc); 
				
				var tweenTc:Tween = new Tween(tcImage, fadeTime); 
				tweenTc.fadeTo(1); 
				Starling.juggler.add(tweenTc); 
			}
			
			if(lang == "sc")
			{
				var tweenEn:Tween = new Tween(enImage, fadeTime); 
				tweenEn.fadeTo(0); 
				Starling.juggler.add(tweenEn); 
				
				var tweenSc:Tween = new Tween(scImage, fadeTime); 
				tweenSc.fadeTo(1); 
				Starling.juggler.add(tweenSc); 
				
				var tweenTc:Tween = new Tween(tcImage, fadeTime); 
				tweenTc.fadeTo(0); 
				Starling.juggler.add(tweenTc); 
			}
		}
		
	}
}