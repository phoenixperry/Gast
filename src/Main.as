
package{

	
	import flash.desktop.NativeApplication;
	import flash.display.Bitmap;
	import flash.events.TimerEvent;
	import flash.ui.Mouse;
	import flash.utils.Timer;
	
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	import starling.filters.ColorMatrixFilter;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.utils.Color;

	public class Main extends starling.display.Sprite{
		
		//tint values 
		private var tintUp:Boolean; 
		private var tintDown:Boolean; 
		private var tintVal:Number; 
		private var tintBlack:ColorMatrixFilter; 
		private var q:Quad; 
		//reset timer 
		private var timeOut:Timer; 
		//private var timeBeforeReset = 120000; 
		//debug timer
		private var timeBeforeReset:Number = 5000; 

		// var to change languages. Default to english
		private var lang:String = "en"; 
	 	
		//background image 
		[Embed(source="./assets/background.png")]
		private var bgBit:Class; 
		private var bgTexture:Texture; 
		private var bgImage:Image; 
		private var blackImages:Sprite; 
		
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
		//data collection of all btns 
		public var allBtns:Vector.<Button>; 
		//popup background 
		[Embed(source="./assets/popup.png")]
		private var popupBit:Class; 
		private var popupTexture:Texture; 
		private var popupImage:Image; 
		
		//popup btns 
		[Embed(source="./assets/back.png")] 
		private var backBit:Class; 
		private var backTexture:Texture; 
		private var backBtn:starling.display.Button; 
		
		[Embed(source="./assets/btnEn.png")]
		private var enBit:Class; 
		private var enBtnTexture:Texture; 
		private var enBtn:starling.display.Button;
		
		[Embed(source="./assets/btnSimpleChinese.png")]
		private var scBit:Class; 
		private var scBtnTexture:Texture; 
		private var scBtn:starling.display.Button;
		
		[Embed(source="./assets/btnTraditionalChinese.png")]
		private var tcBit:Class; 
		private var tcBtnTexture:Texture; 
		private var tcBtn:starling.display.Button;
		
		//font
		[Embed(source="minion.otf", embedAsCFF="false", fontFamily="minion")]
		private static const Minion:Class;
		
		//repositioned popup btns 
		private var tcBtn2:starling.display.Button; 
		private var scBtn2:starling.display.Button; 
		private var enBtn2:starling.display.Button; 
		
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
		private var currentPop:Sprite; 
		
		//collection of all popups as a data collection 
		private var popups:Sprite; 
		
		//all transitions 
		private var fadeDownPopup:Number = .75; 
		private var fadeUpPopup:Number = .5; 
		private var fadeChangeLang:Number = .5; 
		private var fadeBackground:Number = .5; 
		
		//state machine mechanics 
		private var p1:Boolean,p2:Boolean,p3:Boolean,p4:Boolean,p5:Boolean,p6:Boolean,p7:Boolean = false; 
		private var home:Boolean = false; 
		private var back:Boolean = false; 
		private var en:Boolean,sc:Boolean,tc:Boolean = true; 
		

		public function Main()
		{
			//Mouse.hide();
			
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
	
			var backBitmap:Bitmap = new backBit(); 
			backTexture = Texture.fromBitmap(backBitmap); 
			backBtn = new starling.display.Button(backTexture,"",backTexture); 
			backBtn.addEventListener(Event.TRIGGERED, backBtnClicked);
			backBtn.x = 1588; 
			backBtn.y = 753;
			//backBtn.alpha = 0; 
			backBtn.name = "backBtn"; 
			popupPieces.addChildAt(backBtn,1);
			
			var enBitmap:Bitmap = new enBit(); 
			enBtnTexture = Texture.fromBitmap(enBitmap); 
			enBtn = new starling.display.Button(enBtnTexture,"",enBtnTexture);
			enBtn2 = new starling.display.Button(enBtnTexture, "", enBtnTexture); 
			enBtn.addEventListener(Event.TRIGGERED, enBtnClicked);
			enBtn2.addEventListener(Event.TRIGGERED, enBtnClicked);
			//enBtn.alpha =0; 
			enBtn.x = 905; 
			enBtn.y = 776; 
			enBtn2.x = 1117; 
			enBtn2.y = 776; 
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
			tcBtn.x = 905; 
			tcBtn.y = 776; 
			tcBtn2.x = 1117; 
			tcBtn2.y = 776; 
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
			
			var btn01Bitmap:Bitmap = new btn01bit();
			btn01Texture = Texture.fromBitmap(btn01Bitmap); 
			btn01 = new Button(btn01Texture, "", btn01Texture); 
			btn01.x = 96; 
			btn01.y = 816; 
			btn01.name="btn01";
			btn01.addEventListener(Event.TRIGGERED, popup1);	
			btns.addChild(btn01);
			
			
			var btn02Bitmap:Bitmap = new btn02Bit();
			btn02Texture = Texture.fromBitmap(btn02Bitmap); 
			btn02 = new Button(btn02Texture, "", btn02Texture); 
			btn02.x = 94; 
			btn02.y = 436; 
			btn02.name = "btn02";
			btn02.addEventListener(Event.TRIGGERED, popup2);
			btns.addChild(btn02); 
			
			
			var btn03Bitmap:Bitmap = new btn03Bit();
			btn03Texture = Texture.fromBitmap(btn03Bitmap); 
			btn03 = new Button(btn03Texture, "", btn03Texture); 
			btn03.x = 94; 
			btn03.y = 53; 
			btn03.name = "btn03";
			btn03.addEventListener(Event.TRIGGERED, popup3);
			btns.addChild(btn03); 
			
			var btn04Bitmap:Bitmap = new btn04Bit();
			btn04Texture = Texture.fromBitmap(btn04Bitmap); 
			btn04 = new Button(btn04Texture, "", btn04Texture); 
			btn04.x = 398; 
			btn04.y = 26; 
			btn04.name = "btn04";
			btn04.addEventListener(Event.TRIGGERED, popup4);
			btns.addChild(btn04); 
			
			var btn05Bitmap:Bitmap = new btn05Bit();
			btn05Texture = Texture.fromBitmap(btn05Bitmap); 
			btn05 = new Button(btn05Texture, "", btn05Texture); 
			btn05.x = 1363; 
			btn05.y = 24; 
			btn05.name = "btn05";
			btn05.addEventListener(Event.TRIGGERED, popup5);
			btns.addChild(btn05); 
			
			var btn06Bitmap:Bitmap = new btn06Bit();
			btn06Texture = Texture.fromBitmap(btn06Bitmap); 
			btn06 = new Button(btn06Texture,"", btn06Texture); 
			btn06.x = 1642; 
			btn06.y = 52; 
			btn06.name = "btn06";
			btn06.addEventListener(Event.TRIGGERED, popup6);
			btns.addChild(btn06);
			var btn07Bitmap:Bitmap = new btn07Bit();
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
			
			allBtns = new Vector.<Button>(); 
			allBtns.push(btn01); 
			allBtns.push(btn02); 
			allBtns.push(btn03); 
			allBtns.push(btn04); 
			allBtns.push(btn05); 
			allBtns.push(btn06); 
			allBtns.push(btn07); 
			
			//debug timer
			timeOut = new Timer (timeBeforeReset);
			timeOut.start();
			timeOut.addEventListener(TimerEvent.TIMER, checkForUser); 
			addEventListener(Event.ENTER_FRAME, OnEnterFrame); 
			
			setDefaultBtns(); 
			addEventListener(starling.events.KeyboardEvent.KEY_DOWN, quitOut);
			//add btn text 
			var textField:TextField = 
				new TextField(239, 40, "Change Language:", "Minion", 29, 0x4a3a20);
			textField.x =656; 
			textField.y =788;
			popupPieces.addChild(textField); 
			
			//set up tint 
			tintBlack = new ColorMatrixFilter(); 
			q = new Quad(stage.stageWidth, stage.stageHeight, 0x000000);
			q.name = "q"; 
			btns.addChild(q); 
			q.alpha = 0; 
			q.touchable = false; 
		}
		
		private function setDefaultBtns():void
		{
			//set up english btns as the default
			popupPieces.setChildIndex(popupPieces.getChildByName("scBtn"), popupPieces.numChildren-1); 
			popupPieces.setChildIndex(popupPieces.getChildByName("tcBtn2"), popupPieces.numChildren-1);
			sc = false; 
			tc = false; 
			en = true;
			//turn down alpha on all non-visible buttons 
			popupPieces.getChildByName("scBtn2").alpha = 0;
			popupPieces.getChildByName("tcBtn").alpha = 0;
			popupPieces.getChildByName("enBtn").alpha = 0;
			popupPieces.getChildByName("enBtn2").alpha = 0;	
			
			// turn up default btns 
			popupPieces.getChildByName("tcBtn2").alpha = 1; 
			popupPieces.getChildByName("scBtn").alpha = 1;
		}
		
		private function quitOut(e:starling.events.KeyboardEvent):void
		{
			//trace(e.keyCode); 
			if(e.keyCode == 27)
			{
				NativeApplication.nativeApplication.exit(0);
			}
		}
		
		//function for resetting the application to the default state if there is no activity
		private function checkForUser (e:TimerEvent):void
		{
			//reset lang to English  
			changeLang("en"); 
			home = true; 
			en = true; 
			tc = false; 
			sc = false; 
			
			
		}

		private function swapButtons(btn1:Button, btn2:Button,btn3:Button, btn4:Button ):void
		{
			var tween:Tween = new Tween(btn1, fadeDownPopup); 
			tween.fadeTo(0); 
			Starling.juggler.add(tween); 
			
			var tween2:Tween = new Tween(btn2, fadeDownPopup); 
			tween2.fadeTo(0); 
			Starling.juggler.add(tween2); 
			
			var tween3:Tween = new Tween(btn3, fadeDownPopup); 
			tween3.fadeTo(1); 
			Starling.juggler.add(tween3); 
			
			var tween4:Tween = new Tween(btn4, fadeDownPopup); 
			tween4.fadeTo(1); 
			Starling.juggler.add(tween4); 
			
			popupPieces.setChildIndex(popupPieces.getChildByName(btn3.name),popupPieces.numChildren-1); 
			popupPieces.setChildIndex(popupPieces.getChildByName(btn4.name),popupPieces.numChildren-1); 
			
			
		}
		private function scBtnClicked(e:Event):void
		{
			resetTimeout(); 
			changeLang("sc"); 
			if(tc)
			{
				swapButtons(scBtn,enBtn2, enBtn, tcBtn2);
			}
			//if you're in english 
			if(en)
			{
				swapButtons(scBtn, tcBtn2, enBtn, tcBtn2); 
			} 
			sc = true; 
			en = false; 
			tc = false; 
			
		}
		
		private function tcBtnClicked(e:Event):void
		{
			resetTimeout(); 
			//if you're in simple chinese  
			if(sc)
			{
				swapButtons(enBtn,tcBtn2, scBtn, enBtn2);
			}
			//if you're in english 
			if(en)
			{
				swapButtons(scBtn, tcBtn2, scBtn, enBtn2); 
			} 
			
			changeLang("tc"); 
			en = false; 
			sc = false; 
			tc = true; 
		
		}
		
		private function enBtnClicked(e:Event):void
		{
			resetTimeout();
			if(sc)
			{
				swapButtons(enBtn,tcBtn2, scBtn, tcBtn2);
			}
			//if you're in english 
			if(tc)
			{
				swapButtons(scBtn, enBtn2, scBtn, tcBtn2); 
			} 
			
			en = true; 
			tc = false; 
			sc = false; 
			changeLang("en"); 
			
		}
		
		private function resetTimeout():void
		{
			timeOut.reset(); 
			timeOut.start(); 
			
		}
		
		private function OnEnterFrame():void
		{
			//main driving state machine -- do some refractoring here 
			if(p1 && back)
			{
				fadeOutPopup(pop1); 
				p1 = false; 
			}
			if(p2 && back)
			{
				fadeOutPopup(pop2); 
				p2 = false; 
			}
			
			if(p3 && back)
			{
				
				fadeOutPopup(pop3); 
				p3 = false; 
			}
			if(p4 && back)
			{
				fadeOutPopup(pop4); 
				p4 = false; 
			}
			
			if(p5 && back)
			{
				fadeOutPopup(pop5); 
				p5 = false; 
			}
			if(p6 && back)
			{
				fadeOutPopup(pop6); 
				p6 = false; 
			}
			if(p7 && back)
			{
				fadeOutPopup(pop7); 
				p7 = false; 
			}
			// Time out reset 
			if(p1 && home)
			{
				fadeOutPopup(pop1); 
				p1 = false; 
			}
			if(p2 && home)
			{
				fadeOutPopup(pop2); 
				p2 = false; 
			}
			
			if(p3 && home)
			{
				
				fadeOutPopup(pop3); 
				p3 = false; 
			}
			if(p4 && home)
			{
				fadeOutPopup(pop4); 
				p4 = false; 
			}
			
			if(p5 && home)
			{
				fadeOutPopup(pop5); 
				p5 = false; 
			}
			if(p6 && home)
			{
				fadeOutPopup(pop6);  
				p6 = false; 
			}
			if(p7 && home)
			{
				fadeOutPopup(pop7);  
				p7 = false; 
			}
	
		}
		private function fadeOutPopup(pop:Sprite):void
		{
			changeBtnState(true); 
			back = false; 
			var tween:Tween = new Tween(popupPieces,fadeDownPopup); 
			tween.fadeTo(0); 
			var tween2:Tween = new Tween(pop,fadeDownPopup); 
			tween2.fadeTo(0); 
			Starling.juggler.add(tween);
			Starling.juggler.add(tween2); 
			tween.onComplete = function():void 
			{
				swapChildren(popups, btns); 
				trace("finished tween", getChildAt(0).name, getChildAt(1).name, getChildAt(2).name); 
			}
			//if the pop up is actually resetting to default, make sure to reset buttons + home trigger as well
			tween2.onComplete = function():void
			{
				if(home)
				{
					setDefaultBtns(); 
					home = false; 
				}
			}
			//fade up background and btns 
//			var tweenbg:Tween = new Tween(bgImage, fadeBackground); 
//			tweenbg.fadeTo(1);  
//			Starling.juggler.add(tweenbg); 
			var obj:Quad = btns.getChildByName("q") as Quad; 
			var postion:Number = btns.getChildIndex(obj) 
			obj.alpha =0;
			var quadTween:Tween = new Tween(obj, fadeBackground); 
			quadTween.fadeTo(0); 
			quadTween.onComplete= function(){
				trace(obj.alpha + " Alpha at end of tween");
			}
				
			Starling.juggler.add(quadTween); 
			tintUp = true; 
			tintDown = false; 
		}
		private function backBtnClicked(e:Event):void
		{
			timeOut.reset(); 
			timeOut.start(); 
			back = true;	
		}
		public function changeBtnState(b:Boolean):void
		{
			trace(allBtns.length); 
			for each (var button:Button in allBtns) 
			{
				button.enabled = b;
				//trace(button.name, button.enabled); 
			}
		}
		public function fadeInPopup(pop:Sprite):void{
			resetTimeout(); 
			changeBtnState(false); 
			//fade down background and btns 
//			var tweenbg:Tween = new Tween(bgImage, fadeBackground); 
//			tweenbg.fadeTo(.70); 
//			Starling.juggler.add(tweenbg); 
			
			
			var obj:Quad = getChildByName("q") as Quad;  
			trace(btns.getChildByName("q"));
			var tweenQuadA:Tween = new Tween(btns.getChildByName("q"), fadeBackground); 
			tweenQuadA.fadeTo(.3); 
			Starling.juggler.add(tweenQuadA); 
			//fade up popup pieces 
			var tweenpp:Tween = new Tween(popupPieces, fadeUpPopup); 
			tweenpp.fadeTo(1); 
			var tweenpop:Tween = new Tween(pop,fadeUpPopup); 
			tweenpop.fadeTo(1); 
			Starling.juggler.add(tweenpp);
			Starling.juggler.add(tweenpop); 
			back = false; 
			tintDown = false; 
			tintUp = true; 
			trace(btn06.alpha + "i think the alpha");
			
		}
		public function popup1(e:Event):void{
			swapChildren(popups, btns); 
			fadeInPopup(pop1); 
			p1 = true; 
		}	
		public function popup2(e:Event):void{
			swapChildren(popups, btns); 
			fadeInPopup(pop2); 
			p2 = true; 
		}	
		public function popup3(e:Event):void{ 
			swapChildren(popups, btns); 
			fadeInPopup(pop3); 
			p3 = true; 
		}	
		public function popup4(e:Event):void{
			swapChildren(popups, btns); 
			fadeInPopup(pop4); 
			p4 = true; 
		}	
		public function popup5(e:Event):void{
			swapChildren(popups, btns); 
			fadeInPopup(pop5); 
			p5 = true; 

		}	
		public function popup6(e:Event):void{
			swapChildren(popups, btns); 
			fadeInPopup(pop6); 
			p6 = true; 

		}	
		
		public function popup7(e:Event):void{
			swapChildren(popups, btns); 
			fadeInPopup(pop7); 
			p7 = true; 
 
		}		
		
		public function changeLang(s:String):void 
		{
			pop1.setLang(s); 
			pop2.setLang(s); 
			pop3.setLang(s); 
			pop4.setLang(s); 
			pop5.setLang(s); 
			pop6.setLang(s); 
			pop7.setLang(s); 
		}
		
		public const lerp:Function = function( amount:Number , start:Number, end:Number ):Number 
		{ 
			//tintVal = (1-amount) * start + (amount) * end;
			//return tintVal; 
		}		
	}
}