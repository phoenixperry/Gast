
package{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Screen;
	import flash.display.SpreadMethod;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.net.dns.AAAARecord;
	import flash.system.ImageDecodingPolicy;
	import flash.utils.Timer;
	
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.display.Stage;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;

	public class Main extends starling.display.Sprite{
		
		//reset timer 
		private var timeOut:Timer; 
		private var timeBeforeReset = 3000; 
		// var to change languages. Default to english
		private var lang:String = "en"; 
	 	
		//background image 
		[Embed(source="./assets/background.png")]
		private var bgBit:Class; 
		private var bgTexture:Texture; 
		private var bgImage:Image; 
		
		//photo btns 
		[Embed(source="./assets/01hg_btn.png")]
		private var btn01bit:Class; 
		private var btn01Texture:Texture; 
		private var btn01:Button; 
		
		[Embed(source="./assets/02hh_btn.png")]
		private var btn02Bit:Class;  
		private var btn02Texture:starling.textures.Texture; 
		private var btn02:Button; 
		
		[Embed(source="./assets/03ls_btn.png")]
		private var btn03Bit:Class; 
		private var btn03Texture:starling.textures.Texture; 
		private var btn03:Button; 
		
		[Embed(source="./assets/04js_btn.png")]
		private var btn04Bit:Class; 
		private var btn04Texture:starling.textures.Texture; 
		private var btn04:Button; 

		[Embed(source="./assets/05fd_btn.png")]
		private var btn05Bit:Class; 
		private var btn05Texture:starling.textures.Texture; 
		private var btn05:Button; 
		
		[Embed(source="./assets/06mt_btn.png")]
		private var btn06Bit: Class;  
		private var btn06Texture:starling.textures.Texture; 
		private var btn06:Button; 
		
		[Embed(source="./assets/07ay_btn.png")]
		private var btn07Bit:Class; 
		private var btn07Texture:starling.textures.Texture; 
		private var btn07:Button; 

		//collection of all photo Btns 
		public var btns:Sprite;  
		
		//popup background 
		[Embed(source="./assets/popup.png")]
		private var popupBit:Class; 
		private var popupTexture:Texture; 
		private var popupImage:Image; 
		
		//popup btns 
		[Embed(source="./assets/back.png")] 
		private var backBit:Class; 
		private var backTexture:Texture; 
		private var backBtn:Button; 
		
		[Embed(source="./assets/btnEn.png")]
		private var enBit:Class; 
		private var enBtnTexture:Texture; 
		private var enBtn:Button;
		
		[Embed(source="./assets/btnSimpleChinese.png")]
		private var scBit:Class; 
		private var scBtnTexture:Texture; 
		private var scBtn:Button;
		
		[Embed(source="./assets/btnTraditionalChinese.png")]
		private var tcBit:Class; 
		private var tcBtnTexture:Texture; 
		private var tcBtn:Button;
		
		//repositioned popup btns 
		private var tcBtn2:Button; 
		private var scBtn2:Button; 
		private var enBtn2:Button; 
		
		//collection of all the elements in every popup (btns + background) 
		private var popupPieces:Sprite;
		
		//popups 
		private var pop1:HG01; 
		private var pop2:HH02; 
		private var pop3:LS03; 
		private var pop4:JS04; 
		private var pop5:FD05; 
		private var pop6:MT06; 
		private var pop7:AY07;
	
		
		//collection of all popups as a data collection 
		private var popups:Sprite; 
		
		//all transitions 
		private var fadeDownPopup = .5; 
		private var fadeUpPopup = .5; 
		private var fadeChangeLang = .5; 
		
		//state machine mechanics 
		private var p1,p2,p3,p4,p5,p6,p7:Boolean = false; 
		private var home = true; 
		private var back = false; 
		private var en,sc,tc:Boolean = true; 
		
		public function Main()
		{
			addEventListener(starling.events.Event.ADDED_TO_STAGE, Init); 
		}
		
		private function Init(e:starling.events.Event):void{
			//add global listener for buttons 
			removeEventListener(starling.events.Event.ADDED_TO_STAGE, Init); 
		
			btns = new Sprite(); 
			btns.width = stage.stageWidth; 
			btns.height = stage.height; 
			//add the background imamge 
			var bgBitmap = new bgBit(); 
			bgTexture = Texture.fromBitmap(bgBitmap); 
			bgImage = new Image(bgTexture); 
			bgImage.width = 1920; 
			bgImage.height = 1080; 
			bgImage.name = "bg";
			//add the background 
			addChildAt(bgImage,0);
			

			
			//create all of the popups 
			pop1 = new HG01(); 
			pop1.name = "pop1"; 
			pop2 = new HH02(); 
			pop2.name = "pop2"; 
			pop3 = new LS03();
			pop3.name = "pop3"; 
			pop4 = new JS04(); 
			pop4.name = "pop4"; 
			pop5 = new FD05(); 
			pop5.name = "pop5"; 
			pop6 = new MT06(); 
			pop6.name = "pop6"; 
			pop7 = new AY07(); 
			pop7.name = "pop7"; 
			//popups = new Vector.<Sprite>([pop1, pop2, pop3, pop4, pop5, pop6, pop7]); 
			//putting all popups in container.
			popups = new Sprite(); 

			//add all of the popup btns and the popup background set to an alpha of 0 to start 
			popupPieces = new Sprite();
			var popupBitmap = new popupBit(); 
			popupTexture = Texture.fromBitmap(popupBitmap); 
			popupImage = new Image(popupTexture); 
			popupImage.x = 139; 
			popupImage.y =62; 
			//popupImage.alpha = 0; 
			popupImage.name = "popupBg"; 
			popupPieces.addChildAt(popupImage,0);
	
			var backBitmap = new backBit(); 
			backTexture = Texture.fromBitmap(backBitmap); 
			backBtn = new Button(backTexture,"",backTexture); 
			backBtn.addEventListener(Event.TRIGGERED, backBtnClicked);
			backBtn.x = 1588; 
			backBtn.y = 753;
			//backBtn.alpha = 0; 
			backBtn.name = "backBtn"; 
			popupPieces.addChildAt(backBtn,1);
			
			var enBitmap:Bitmap = new enBit(); 
			enBtnTexture = Texture.fromBitmap(enBitmap); 
			enBtn = new Button(enBtnTexture,"",enBtnTexture);
			enBtn2 = new Button(enBtnTexture, "", enBtnTexture); 
			enBtn.addEventListener(Event.TRIGGERED, enBtnClicked);
			enBtn2.addEventListener(Event.TRIGGERED, enBtnClicked);
			//enBtn.alpha =0; 
			enBtn2.x = 1117; 
			enBtn2.y = 776; 
			enBtn.x = 905; 
			enBtn.y = 776; 
			enBtn.name = "enBtn"; 
			enBtn2.name = "enBtn2"; 
			en = false; //have the english button off to start with 
			popupPieces.addChildAt(enBtn,2); 
			popupPieces.addChildAt(enBtn2,3); 
			
			var tcBitmap:Bitmap = new tcBit(); 
			tcBtnTexture = Texture.fromBitmap(tcBitmap); 
			tcBtn = new Button(tcBtnTexture, "", tcBtnTexture); 
			tcBtn2 = new Button(tcBtnTexture, "", tcBtnTexture); 
			tcBtn.addEventListener(Event.TRIGGERED, tcBtnClicked); 
			tcBtn2.addEventListener(Event.TRIGGERED, tcBtnClicked); 
			tcBtn2.x = 1117; 
			tcBtn2.y = 776; 
			tcBtn.x = 905; 
			tcBtn.y = 776; 
			tcBtn.name = "tcBtn"; 
			tcBtn2.name = "tcBtn2"; 
		
			popupPieces.addChildAt(tcBtn,4); 
			popupPieces.addChildAt(tcBtn2,5); 
			
			var scBitmap:Bitmap = new scBit(); 
			scBtnTexture = Texture.fromBitmap(scBitmap); 
			scBtn = new Button(scBtnTexture, "", scBtnTexture); 
			scBtn2 = new Button(scBtnTexture, "", scBtnTexture); 
			scBtn.addEventListener(Event.TRIGGERED, scBtnClicked); 
			scBtn.x = 905; 
			scBtn.y = 776;
			scBtn2.x = 1117; 
			scBtn2.y = 776;
			scBtn.name = "scBtn"; 
			scBtn2.name = "scBtn2"; 
			popupPieces.addChildAt(scBtn, 6);
			popupPieces.addChildAt(scBtn2, 7);
			
			popupPieces.alpha = 0.0; 
			
			popups.addChildAt(popupPieces, 0); 
			popups.addChildAt(pop1,1); 
			popups.addChildAt(pop2, 2);
			popups.addChildAt(pop3, 3); 
			popups.addChildAt(pop4, 4); 
			popups.addChildAt(pop5, 5); 
			popups.addChildAt(pop6, 6); 
			popups.addChildAt(pop7, 7); 
			popups.name = "popups"; 
			
			//turn all the popups and buttons off to start  
			pop1.alpha = 0.0; 
			pop2.alpha = 0.0; 
			pop3.alpha = 0.0; 
			pop4.alpha = 0.0; 
			pop5.alpha = 0.0; 
			pop6.alpha = 0.0; 
			pop7.alpha = 0.0; 

			addChildAt(popups,1); 
			
			//add the photo btns and put them in btns container 
			
			var btn01Bitmap = new btn01bit();
			btn01Texture = Texture.fromBitmap(btn01Bitmap); 
			btn01 = new Button(btn01Texture, "", btn01Texture); 
			btn01.x = 96; 
			btn01.y = 816; 
			btn01.name="btn01";
			btn01.addEventListener(Event.TRIGGERED, popup1);	
			btns.addChild(btn01);
			
			
			var btn02Bitmap = new btn02Bit();
			btn02Texture = Texture.fromBitmap(btn02Bitmap); 
			btn02 = new Button(btn02Texture, "", btn02Texture); 
			btn02.x = 94; 
			btn02.y = 436; 
			btn02.name = "btn02";
			btn02.addEventListener(Event.TRIGGERED, popup2);
			btns.addChild(btn02); 
			
			
			var btn03Bitmap = new btn03Bit();
			btn03Texture = Texture.fromBitmap(btn03Bitmap); 
			btn03 = new Button(btn03Texture, "", btn03Texture); 
			btn03.x = 94; 
			btn03.y = 53; 
			btn03.name = "btn03";
			btn03.addEventListener(Event.TRIGGERED, popup3);
			btns.addChild(btn03); 
			
			var btn04Bitmap = new btn04Bit();
			btn04Texture = Texture.fromBitmap(btn04Bitmap); 
			btn04 = new Button(btn04Texture, "", btn04Texture); 
			btn04.x = 398; 
			btn04.y = 26; 
			btn04.name = "btn04";
			btn04.addEventListener(Event.TRIGGERED, popup4);
			btns.addChild(btn04); 
			
			var btn05Bitmap = new btn05Bit();
			btn05Texture = Texture.fromBitmap(btn05Bitmap); 
			btn05 = new Button(btn05Texture, "", btn05Texture); 
			btn05.x = 1363; 
			btn05.y = 24; 
			btn05.name = "btn05";
			btn05.addEventListener(Event.TRIGGERED, popup5);
			btns.addChild(btn05); 
			
			var btn06Bitmap = new btn06Bit();
			btn06Texture = Texture.fromBitmap(btn06Bitmap); 
			btn06 = new Button(btn06Texture,"", btn06Texture); 
			btn06.x = 1642; 
			btn06.y = 52; 
			btn06.name = "btn06";
			btn06.addEventListener(Event.TRIGGERED, popup6);
			btns.addChild(btn06);
			
			var btn07Bitmap = new btn07Bit();
			btn07Texture = Texture.fromBitmap(btn07Bitmap); 
			btn07 = new Button(btn07Texture, "", btn07Texture); 
			btn07.x = 1647; 
			btn07.y = 444;
			btn07.name = "btn07";
			btn07.addEventListener(Event.TRIGGERED, popup7);
			btns.addChild(btn07);
			btns.name = "btns"; 
			//adding the collection 
			addChildAt(btns,2);
			
			//debug timer
			timeOut = new Timer (timeBeforeReset);
			timeOut.start();
			timeOut.addEventListener(TimerEvent.TIMER, checkForUser); 
			home = true; 
			addEventListener(Event.ENTER_FRAME, OnEnterFrame); 
			
			//set up english btns as the default
			popupPieces.setChildIndex(popupPieces.getChildByName("scBtn"), popupPieces.numChildren-1); 
			popupPieces.setChildIndex(popupPieces.getChildByName("tcBtn2"), popupPieces.numChildren-1);
			sc = false; 
			tc = false; 
			en = true;
		}
		private function checkForUser (e:TimerEvent):void
		{
			//restart application 
			//strace("restarting");
			
		}
		private function scBtnClicked(e:Event):void
		{
			timeOut.reset(); 
			timeOut.start(); 
			lang = "sc"; 
			sc = true; 
			pop1.setLang("sc"); 
			
			sc = true; 
			en = false; 
			tc = false; 
//			pop2.setLang("sc"); 
//			pop3.setLang("sc"); 
//			pop4.setLang("sc"); 
//			pop5.setLang("sc"); 
//			pop6.setLang("sc"); 
//			pop7.setLang("sc");
			

			
		}
		
		private function tcBtnClicked(e:Event):void
		{
			// TODO Auto Generated method stub
			timeOut.reset(); 
			timeOut.start(); 
		
			pop1.setLang("tc"); 
//			pop2.setLang("tc"); 
//			pop3.setLang("tc"); 
//			pop4.setLang("tc"); 
//			pop5.setLang("tc"); 
//			pop6.setLang("tc"); 
//			pop7.setLang("tc"); 
			
			//if you're in simple chinese  
			if(sc)
			{
				var tween:Tween = new Tween(enBtn, fadeDownPopup); 
				tween.fadeTo(0); 
				
				var tween2:Tween = new Tween(tcBtn2, fadeDownPopup); 
				tween2.fadeTo(0); 
				
				var tween3:Tween = new Tween(scBtn, fadeDownPopup); 
				tween3.fadeTo(1); 
				
				var tween4:Tween = new Tween(enBtn2, fadeDownPopup); 
				tween4.fadeTo(1); 
				tween4.onComplete= function():void
				{	
					trace("fade complete"); 
					//move the current btns to the top of the stack in their container
					popupPieces.setChildIndex(getChildByName("scBtn"),popupPieces.numChildren-1); 
					popupPieces.setChildIndex(getChildByName("enBtn2"),popupPieces.numChildren-1); 
					
				}
					
			}
			//if you're in english 
			if(en)
			{
				trace("detected lang as en"); 
				var tween:Tween = new Tween(enBtn, fadeDownPopup); 
				tween.fadeTo(0); 
				
				var tween2:Tween = new Tween(tcBtn2, fadeDownPopup); 
				tween2.fadeTo(0); 
				
				var tween3:Tween = new Tween(scBtn, fadeDownPopup); 
				tween3.fadeTo(1); 
				
				var tween4:Tween = new Tween(enBtn2, fadeDownPopup); 
				tween4.fadeTo(1); 

				tween4.onComplete= function():void
				{
					popupPieces.setChildIndex(getChildByName("scBtn"),popupPieces.numChildren-1); 
					popupPieces.setChildIndex(getChildByName("enBtn2"),popupPieces.numChildren-1); 
				}
			} 
			
			//pop2.setLang("tc"); 
//			pop3.setLang("tc"); 
//			pop4.setLang("tc"); 
//			pop5.setLang("tc"); 
//			pop6.setLang("tc"); 
//			pop7.setLang("tc"); 
			lang = "tc"; 
			en = false; 
			sc = false; 
			tc = true; 
		
		}
		
		private function enBtnClicked(e:Event):void
		{
			timeOut.reset(); 
			timeOut.start(); 
			// TODO Auto Generated method stub
			lang = "en" 
			pop1.setLang("en"); 
			en = true; 
			tc = false; 
			sc = false; 
//			pop2.setLang("en"); 
//			pop3.setLang("en"); 
//			pop4.setLang("en"); 
//			pop5.setLang("en"); 
//			pop6.setLang("en"); 
//			pop7.setLang("en"); 
			
		}
		
		private function OnEnterFrame():void
		{
			if(p1 && back)
			{
				var tween:Tween = new Tween(popupPieces,fadeDownPopup); 
				tween.fadeTo(0); 
				var tween2:Tween = new Tween(pop1,fadeDownPopup); 
				tween2.fadeTo(0); 
				Starling.juggler.add(tween);
				Starling.juggler.add(tween2); 
				tween.onComplete = function():void 
				{
					swapChildren(popups, btns); 
					trace("finished tween", getChildAt(0).name, getChildAt(1).name, getChildAt(2).name); 
				}
				back = false; 
				p1 = false; 
	
			}
			

			
		}
		private function backBtnClicked(e:Event):void
		{
			timeOut.reset(); 
			timeOut.start(); 
			back = true;	
				
		}
		public function popup1(e:Event):void{
			timeOut.reset(); 
			timeOut.start(); 
			trace("1");
			
			//reset the timer
			//check for the langauge 
			//fade up + scale the right poopup 
			swapChildren(popups, btns); 
			var tween:Tween = new Tween(popupPieces, fadeUpPopup); 
			tween.fadeTo(1); 
			var tween2:Tween = new Tween(pop1,fadeUpPopup); 
			tween2.fadeTo(1); 
			Starling.juggler.add(tween);
			Starling.juggler.add(tween2); 
	
			back = false; 
			p1 = true; 
			
			
		}	
		public function popup2(e:Event):void{
			timeOut.reset(); 
			timeOut.start(); 
			trace("2"); 
		}	
		public function popup3(e:Event):void{
			timeOut.reset(); 
			timeOut.start(); 
			trace("3"); 
		}	
		public function popup4(e:Event):void{
			timeOut.reset(); 
			timeOut.start(); 
			trace("4"); 
		}	
		public function popup5(e:Event):void{
			timeOut.reset(); 
			timeOut.start(); 
			trace("5"); 
		}	
		public function popup6(e:Event):void{
			timeOut.reset(); 
			timeOut.start(); 
			trace("6"); 
		}	
		
		public function popup7(e:Event):void{
			timeOut.reset(); 
			timeOut.start(); 
			trace("7"); 
		}		

		
	
		
	}
}