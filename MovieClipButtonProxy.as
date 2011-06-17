package org.nodihsop.bbgame.component
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	
	import org.nodihsop.bbgame.util.SoundHelper;
	
	/**
	 * movieclip按钮组件,通过设置btSource来开启按钮 
	 * <li>可以通过设置songNameForClick,songNameForMoveOver的值来设置点击和moveOver时的声音名
	 * <li>鼠标事件:BT_MOUSE_CLICK
	 * <li>useOneTime 默认值为true
	 * <li>通过dispose()来卸载
	 * @author sun
	 * 
	 */
	public class MovieClipButtonProxy extends EventDispatcher
	{
		private var _btSource:MovieClip;
		private var _useOneTime:Boolean;
		private var _songNameForClick:String;
		private var _songNameForMoveOver:String;
		
		public static const BT_MOUSE_CLICK:String="MOUSE_CLICK";
		
		public function MovieClipButtonProxy(value:Boolean = true)
		{
			_useOneTime = value;
		}
		
		
		
		/*private function handleRemoveChild(event:Event = null):void
		{
			dispose();
		}
		*/
		
		
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
			
			if(this._btSource.currentFrame != 3)
			{
				_btSource.gotoAndStop(3);
			}
			if(_useOneTime)
			{
				this.dispose();
			}
			
			this.dispatchEvent(new Event(BT_MOUSE_CLICK));
		}
		
		private function onMouseDown(event:MouseEvent):void
		{
			event.stopImmediatePropagation();
			_btSource.gotoAndStop(3);
		}
		
		private function onMouseOut(event:MouseEvent):void
		{
			event.stopImmediatePropagation();
			_btSource.gotoAndStop(1);
		}
		private function onMouseOver(event:MouseEvent):void
		{
			event.stopImmediatePropagation();
			if(this._songNameForMoveOver)
			{
				SoundHelper.playSound(_songNameForMoveOver);
			}
			_btSource.gotoAndStop(2);
		}
		private function onMouseUp(event:MouseEvent):void
		{
			event.stopImmediatePropagation();
			_btSource.gotoAndStop(1);
		}
		
		
		public function UpState():void
		{
			removeBtAlllListeners();
			addBtAllListeners();
			if(_btSource)
			{
				_btSource.gotoAndStop(1);
			}
		}
		/**
		 *该状态下不发送任何事件 
		 * 
		 */
		public function DownState():void
		{
			removeBtAlllListeners();
			if(_btSource)
			{
				_btSource.gotoAndStop(3);
			}
		}
		public function OverState():void
		{
			if(_btSource)
			{
				_btSource.gotoAndStop(2);
			}
		}
		 
		public function disableButton():void
		{
			if(_btSource)
			{
				_btSource.gotoAndStop(1);
				_btSource.buttonMode=false;
				_btSource.userHandCursor=false;
				removeBtAlllListeners();
				
			}
			
		}
		private function removeBtAlllListeners():void
		{
			if (_btSource != null)
			{
				_btSource.buttonMode=false;
				_btSource.userHandCursor=false;
				
				if (_btSource.hasEventListener(MouseEvent.CLICK))
				{
					_btSource.removeEventListener(MouseEvent.CLICK, onMouseClick);
				}
				
				if (_btSource.hasEventListener(MouseEvent.MOUSE_OVER))
				{
					_btSource.removeEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
				}
				
				if (_btSource.hasEventListener(MouseEvent.MOUSE_UP))
				{
					_btSource.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
				}
				if (_btSource.hasEventListener(MouseEvent.MOUSE_OUT))
				{
					_btSource.removeEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
				}
				
				/*if(_btSource.hasEventListener(Event.REMOVED_FROM_STAGE))
				{
					_btSource.removeEventListener(Event.REMOVED_FROM_STAGE,handleRemoveChild);
				}*/
				
				if(_btSource.hasEventListener(MouseEvent.MOUSE_DOWN))
				{
					_btSource.removeEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
				}
			}
		}
		
		
		
		private function addBtAllListeners():void
		{
			if(_btSource)
			{
				_btSource.gotoAndStop(1);
				_btSource.buttonMode=true;
				_btSource.userHandCursor=true;
				_btSource.addEventListener(MouseEvent.CLICK,onMouseClick);
				_btSource.addEventListener(MouseEvent.MOUSE_OVER,onMouseOver);
				_btSource.addEventListener(MouseEvent.MOUSE_OUT,onMouseOut);
				_btSource.addEventListener(MouseEvent.MOUSE_UP,onMouseUp);
				_btSource.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
			}
			
		}
		
		
		/**
		 * 删除全部监听器
		 * 
		 */
		public function dispose():void
		{
			removeBtAlllListeners();
			if(_btSource && _btSource.stage)
			{
				_btSource.stage.focus=null;
			}
			
			_btSource=null;
			
		}
		
		public function set soundNameWhenClick(soundName:String):void
		{
			_songNameForClick = soundName;
		}
		
		public function set soundNameWhenMoveOver(soundName:String):void
		{
			this._songNameForMoveOver = soundName;
		}
		
		public function get btSource():MovieClip
		{
			return _btSource;
		}
		
		/**
		 * 设置按钮指定的mc
		 * @param v
		 */
		public function set btSource(v:MovieClip):void
		{
			removeBtAlllListeners();
			_btSource = v;
			addBtAllListeners();
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