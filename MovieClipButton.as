package  org.nodihsop.bbgame.component
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	
	import org.nodihsop.bbgame.util.SoundHelper;
	
	
	/**
	 * 可以将movieclip代理成按钮
	 * <li>可以通过设置songNameForClick,songNameForMoveOver的值来设置点击和moveOver时的声音名
	 * <li>鼠标事件:BT_MOUSE_CLICK
	 * <li>useOneTime 默认值为 fasle
	 * <li>通过dispose()来卸载
	 * @author sun
	 * 
	 */
	public class MovieClipButton extends MovieClip
	{
		private var _useOneTime:Boolean;
		private var _songNameForClick:String;
		private var _songNameForMoveOver:String;
		
		public static const BT_MOUSE_CLICK:String="MOUSE_CLICK";
		
		public function MovieClipButton(value:Boolean = false)
		{
			_useOneTime = value;
			addBtAllListeners();
		}
		
		
		/*private function handleRemoveChild(event:Event = null):void
		{
			dispose();
		}*/
		
		
		private function onMouseClick(event:MouseEvent):void
		{
			event.stopImmediatePropagation();
			
			if(!_songNameForClick)
			{
				SoundHelper.playSound(_songNameForClick);
			}
			else
			{
			   SoundHelper.playSound(_songNameForClick);
			}
			
			if(this.currentFrame != 3)
			{
				this.gotoAndStop(3);
			}
			if(_useOneTime)
			{
				dispose();
			}
			
			this.dispatchEvent(new Event(BT_MOUSE_CLICK));
		}
		
		protected function onMouseDown(event:MouseEvent):void
		{
			event.stopImmediatePropagation();
			this.gotoAndStop(3);
		}
		
		protected function onMouseOut(event:MouseEvent):void
		{
			event.stopImmediatePropagation();
			this.gotoAndStop(1);
		}
		protected function onMouseOver(event:MouseEvent):void
		{
			event.stopImmediatePropagation();
			if(this._songNameForMoveOver)
			{
				SoundHelper.playSound(_songNameForMoveOver);
			}
			this.gotoAndStop(2);
		}
		protected function onMouseUp(event:MouseEvent):void
		{
			event.stopImmediatePropagation();
			this.gotoAndStop(1);
		}
		
		
		public function UpState():void
		{
			removeBtAlllListeners();
			addBtAllListeners();
			this.gotoAndStop(1);
		}
		/**
		 *该状态下不发送任何事件 
		 * 
		 */
		public function DownState():void
		{
			removeBtAlllListeners();
			this.gotoAndStop(3);
		}
		public function OverState():void
		{
			this.gotoAndStop(2);
		}
		 
		public function disableButton():void
		{
			this.gotoAndStop(1);
			this.buttonMode = false;
			this.useHandCursor = false;
			removeBtAlllListeners();
		}
		private function removeBtAlllListeners():void
		{
			this.buttonMode=false;
			this.useHandCursor = false;
			if (this.hasEventListener(MouseEvent.CLICK))
			{
				this.removeEventListener(MouseEvent.CLICK, onMouseClick);
			}
			
			if (this.hasEventListener(MouseEvent.MOUSE_OVER))
			{
				this.removeEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			}
			
			if (this.hasEventListener(MouseEvent.MOUSE_UP))
			{
				this.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			}
			if (this.hasEventListener(MouseEvent.MOUSE_OUT))
			{
				this.removeEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			}
			/*
			if(this.hasEventListener(Event.REMOVED_FROM_STAGE))
			{
				this.removeEventListener(Event.REMOVED_FROM_STAGE,handleRemoveChild);
			}*/
			
			if(this.hasEventListener(MouseEvent.MOUSE_DOWN))
			{
				this.removeEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
			}
		}
		
		
		
		private function addBtAllListeners():void
		{
			this.gotoAndStop(1);
			this.buttonMode=true;
			this.useHandCursor = true;
			this.addEventListener(MouseEvent.CLICK,onMouseClick);
			this.addEventListener(MouseEvent.MOUSE_OVER,onMouseOver);
			this.addEventListener(MouseEvent.MOUSE_OUT,onMouseOut);
			this.addEventListener(MouseEvent.MOUSE_UP,onMouseUp);
			this.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
		}
		
		
		/**
		 * 删除全部监听器
		 * 
		 */
		public function dispose():void
		{
			removeBtAlllListeners();
			if(this.stage)
			{
				this.stage.focus=null;
			}
			
		}
		
		public function set soundNameWhenClick(soundName:String):void
		{
			_songNameForClick = soundName;
		}
		
		public function set soundNameWhenMoveOver(soundName:String):void
		{
			this._songNameForMoveOver = soundName;
		}
		
		
		/**
		 * 在click事件后是否自动销毁该按钮 
		 * @return 
		 * 
		 */
		public function get useOneTime():Boolean
		{
			return _useOneTime;
		}
		
		/**
		 * 在click事件后是否自动销毁该按钮 
		 * @param value
		 * 
		 */
		public function set useOneTime(value:Boolean):void
		{
			_useOneTime = value;
		}
		
		
	}
}