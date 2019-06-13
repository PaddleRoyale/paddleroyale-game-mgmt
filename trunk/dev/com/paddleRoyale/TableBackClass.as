﻿package paddleRoyale {		import soulwire.display.PaperSprite;	import paddleRoyale.PaddleUtilClass;	import paddleRoyale.PaddleRoyaleModel;	import paddleRoyale.PaddleEvents;	import paddleRoyale.XMLHandler;	import com.greensock.TweenMax;	import com.greensock.easing.*;	import flash.events.MouseEvent;	import flash.display.MovieClip;	import flash.geom.Point;	import flash.events.FocusEvent;		public class TableBackClass extends MovieClip{		private var _model:PaddleRoyaleModel;		private var _xmlObj:XMLHandler;		private var paperSpriteObj:PaperSprite;		private var idInput;		private var tableColorDelay:Number=5;				public function TableBackClass() {			_xmlObj = XMLHandler.getInstance();			_model = PaddleRoyaleModel.getInstance();			TweenMax.to(this.errorClip, 0, {autoAlpha:0});			TweenMax.to(this.updatingClip, 0, {autoAlpha:0});						this.tableBackInput.text="Enter ID";			this.tableBackInput.addEventListener(FocusEvent.FOCUS_IN, onFocusHandler);			this.tableBackInput.addEventListener(FocusEvent.FOCUS_OUT, onFocusOutHandler);			this.tableBackBtn.addEventListener(MouseEvent.CLICK, enterClickHandler);			this.tableBackBtn.buttonMode = true;			this.tableBackCancelBtn.addEventListener(MouseEvent.CLICK, cancelClickHandler);			this.tableBackCancelBtn.buttonMode = true;			this.errorClip.errorCloseBtn.addEventListener(MouseEvent.CLICK, errorCloseHandler);			this.errorClip.errorCloseBtn.buttonMode = true;		}				var temp; //utility variable must be set null after each call		public function remoteBackInput(matchID:int):void		{			temp=matchID;			this.tableBackInput.text = temp;			_xmlObj.updateMatchXML();			_model.addEventListener( PaddleEvents.XML_UPDATED, remoteLoadingHandler );		}				private function enterClickHandler(e:MouseEvent):void		{			e.currentTarget.parent.parent.front.disableHandlers();			//test id: 2114494			idInput = this.tableBackInput.text;						if( !isNaN(idInput) ){				temp=e.currentTarget;				_xmlObj.updateMatchXML();				_model.addEventListener( PaddleEvents.XML_UPDATED, loadingHandler );				TweenMax.to(this.updatingClip, .35, {autoAlpha:1, onComplete:closeError, onCompleteParams:[this.updatingClip, .5]});			}else{				throwError("Please Enter a valid MatchID Number.");			}			//this.tableBackInput.text="";			onFocusOutHandler();		}				private function remoteLoadingHandler(instance:PaddleEvents):void{			_model.removeEventListener( PaddleEvents.XML_UPDATED, remoteLoadingHandler );			var tmp = this.parent.parent;			trace("TABLEBACKCLASS >> tempID: " + temp);			tmp.updateInformation( temp );			temp=null;		}				private function loadingHandler(instance:PaddleEvents):void{			_model.removeEventListener( PaddleEvents.XML_UPDATED, loadingHandler );			temp.parent.parent.parent.updateInformation( idInput );			spinTable( temp.parent.parent );			temp.parent.parent.front.startPulseTable(0x6CB200, .5, tableColorDelay);			TweenMax.delayedCall(tableColorDelay, temp.parent.parent.front.enableHandlersDelay);			temp=null;		}				private function throwError( errorMsg:String="Error" ):void{			this.errorClip.errorText.text = errorMsg;			TweenMax.to(this.errorClip, .35, {autoAlpha:1, onComplete:closeError, onCompleteParams:[this.errorClip, 3]});			this.errorClip.errorText.text = errorMsg;		}				private function errorCloseHandler(e:MouseEvent):void{			closeError(this.errorClip, 0);		}				private function closeError(clip, delayVal:Number=0):void{			TweenMax.to(clip, .35, {autoAlpha:0, delay:delayVal});		}				private function cancelClickHandler(e:MouseEvent):void		{			//this.tableBackInput.text="";			onFocusOutHandler();			spinTable( e.currentTarget.parent.parent );			e.currentTarget.parent.parent.front.enableHandlersDelay(0);		}				private function onFocusHandler(e:FocusEvent):void		{			if(this.tableBackInput.text=="Enter ID")			{				this.tableBackInput.text="";			}		}		private function onFocusOutHandler(e:FocusEvent=null):void		{			if(this.tableBackInput.text=="" || this.tableBackInput.text==" " || this.tableBackInput.text=="  ")			{				this.tableBackInput.text="Enter ID";			}		}						private function spinTable(clip):void		{			//TweenMax.to(clip, Math.random() * 2+1, {rotationY:newRotationVal, onUpdate:flipClips, onUpdateParams:[clip]})			if(paperSpriteObj.isFrontFacing)			{				TweenMax.to(paperSpriteObj, Math.random() * .5 + .5, {rotationY:180*5})			}else{				TweenMax.to(paperSpriteObj, Math.random() * .5 + .5, {rotationY:0})			}		}					public function get paperObj():PaperSprite{	return paperSpriteObj;	}		public function set paperObj(val:PaperSprite):void{		paperSpriteObj = val;		}	}}