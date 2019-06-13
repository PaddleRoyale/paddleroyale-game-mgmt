﻿package paddleRoyale{		import soulwire.display.PaperSprite;	import paddleRoyale.PaddleRoyaleModel;	import com.greensock.TweenMax;	import com.greensock.easing.*;	import flash.events.MouseEvent;	import flash.display.MovieClip;	import flash.geom.Point;		public class TableFrontClass extends MovieClip{		private var _model:PaddleRoyaleModel;		public var paperSpriteObj:PaperSprite;		private var indicatorButtons:Array;			public function TableFrontClass() {			_model = PaddleRoyaleModel.getInstance();			indicatorButtons= new Array();			indicatorButtons = [this.togglePower, this.togglePulse, this.toggleLastCall];			enableHandlers();			this.hitBox.addEventListener(MouseEvent.CLICK, tblClickHandler);			this.hitBox.buttonMode = true;			this.indicatorText.text="";			for(var i=0; i<indicatorButtons.length; i++){				indicatorButtons[i].scaleX=indicatorButtons[i].scaleY=.5;			}		}				private function tblOvrHandler(e:MouseEvent):void		{			TweenMax.to(e.currentTarget.parent.colorBG, .35, {tint:0x3a3a3a, scaleX:1.06, scaleY:1.06});					}		private function tblOutHandler(e:MouseEvent):void		{			TweenMax.to(e.currentTarget.parent.colorBG, .5, {tint:0x1d1d1d, scaleX:1, scaleY:1});		}		private function tblClickHandler(e:MouseEvent):void		{			this.parent.parent.parent.parent["playerCueClip"].hideNextUp();			spinTable( e.currentTarget.parent.parent );		}				public function enableHandlers():void		{			//this.hitBox.addEventListener(MouseEvent.MOUSE_OVER, tblOvrHandler);			//this.hitBox.addEventListener(MouseEvent.MOUSE_OUT, tblOutHandler);			this.hitBox.addEventListener(MouseEvent.CLICK, tblClickHandler);			this.hitBox.buttonMode = true;			for(var i=0; i<indicatorButtons.length; i++){				indicatorButtons[i].addEventListener(MouseEvent.MOUSE_OVER, indicatorOvr);				indicatorButtons[i].addEventListener(MouseEvent.MOUSE_OUT, indicatorOut);				indicatorButtons[i].buttonMode = true;				if(indicatorButtons[i] == this.togglePower){					indicatorButtons[i].description = "Table Indicator ON/OFF";					indicatorButtons[i].addEventListener(MouseEvent.CLICK, lightSwitchHandler);				}else if(indicatorButtons[i] == this.togglePulse){					indicatorButtons[i].description = "Pulse Table";					indicatorButtons[i].addEventListener(MouseEvent.CLICK, pulseSwitchHandler);				}else if(indicatorButtons[i] == this.toggleLastCall){					indicatorButtons[i].description = "Last Call";					indicatorButtons[i].addEventListener(MouseEvent.CLICK, lastCallSwitchHandler);				}			}		}				public function indicatorOvr(e:MouseEvent=null):void{			TweenMax.to(e.currentTarget, .3, {scaleX:1, scaleY:1});			this.indicatorText.text= e.currentTarget.description;		}		public function indicatorOut(e:MouseEvent=null):void{			TweenMax.to(e.currentTarget, .2, {scaleX:.5, scaleY:.5});			this.indicatorText.text= "";		}				public function enableHandlersDelay(delayVal:Number=0):void		{			TweenMax.to(this.colorBG, .5, {tint:0x1d1d1d, scaleX:1, scaleY:1, delay:delayVal, onComplete:enableHandlers});		}				public function disableHandlers():void		{			this.hitBox.removeEventListener(MouseEvent.CLICK, tblClickHandler);			this.hitBox.buttonMode = false;			this.hitBox.removeEventListener(MouseEvent.MOUSE_OVER, tblOvrHandler);			this.hitBox.removeEventListener(MouseEvent.MOUSE_OUT, tblOutHandler);						/*this.indicatorHitArea.removeEventListener(MouseEvent.MOUSE_OVER, indicatorBarOvrHandler);			this.indicatorHitArea.removeEventListener(MouseEvent.MOUSE_OUT, indicatorBarOutHandler);			this.indicatorBar.togglePower.removeEventListener(MouseEvent.CLICK, lightSwitchHandler);			this.indicatorBar.togglePulse.removeEventListener(MouseEvent.CLICK, pulseSwitchHandler);			this.indicatorBar.toggleLastCall.removeEventListener(MouseEvent.CLICK, lastCallSwitchHandler);*/		}						private function spinTable(clip):void{						//TweenMax.to(clip, Math.random() * 2+1, {rotationY:newRotationVal, onUpdate:flipClips, onUpdateParams:[clip]})			if(paperSpriteObj.isFrontFacing)			{				TweenMax.to(paperSpriteObj, Math.random() * .5 + .5, {rotationY:180*5})			}else{				TweenMax.to(paperSpriteObj, Math.random() * .5 + .5, {rotationY:0})			}		}						public function colorMarkTable(colorVal=0x1d1d1d, isOn:Boolean=false):void{  //LEAVES COLOR ON UNTIL TIRNED OFF			if(isOn){				TweenMax.to(this.colorBG, 1, {tint:colorVal});			}else{				TweenMax.to(this.colorBG, 1, {tint:0x1d1d1d});			}		}		public function flashTable(colorVal=0x1d1d1d, duration:Number=0):void{ //FLASHES COLOR ONCE FOR CERTAIN DURATION			TweenMax.to(this.colorBG, .5, {tint:colorVal});			TweenMax.delayedCall(duration, defaultTableColor);		}				public function startPulseTable(colorVal , pulseSpeed:Number ,duration:Number):void{ //PULSES COLOR CONTINUOUSLY FOR CERTAIN DURATION			TweenMax.to(this.colorBG, pulseSpeed, {tint:colorVal, yoyo:true, repeat:-1});			TweenMax.delayedCall(duration, defaultTableColor);		}		private function defaultTableColor():void{			TweenMax.to(this.colorBG, 1, {tint:0x1d1d1d});		}				var lightSwitch:int=-1;		public function lightSwitchHandler(e:MouseEvent=null):void{						//trace(lightSwitch)			lightSwitch*=-1;			if(lightSwitch == 1){				colorMarkTable(0x6CB200, true);			}else{				colorMarkTable(0x6CB200, false);			}		}		public function pulseSwitchHandler(e:MouseEvent=null):void{			flashTable(0x6CB200, 1);		}		public function lastCallSwitchHandler(e:MouseEvent=null):void{			startPulseTable(0xcc0000, .5, 3);		}						public function get paperObj():PaperSprite{			return paperSpriteObj;		}		public function set paperObj(val:PaperSprite):void{			paperSpriteObj = val;		}			}	}