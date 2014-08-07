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
		
		[Embed(source="./assets/back.png")] 
		private var backBit:Class; 
		private var backTexture:Texture; 
		private var backImage; 
		
		public function HG01()
		{
			super();
	
		
		}

	}
}