package  org.nodihsop.bbgame.util
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;

	/**
	 * 用于setter的绑定
	 * <li>解除调用dispose()函数</li>
	 * @author sun
	 * 
	 */
	public class setterBinder
	{
		private var _id:String;
		private var _hasBind:Boolean;

		private var _sourceGetterName:String;
		private var _targetSetterName:String;
		private var _sourceTarget:IEventDispatcher;
		private var _DataChangeEventName:String;
		private var _tagrget:Object;
		private var _getterValue:*;
		
		public function setterBinder()
		{
			_id = NameTool.getUniqueName();
		}

		
		/**
		 * 将事件绑定到set函数上,注意get和set函数的类型应该一致 
		 * @param sourceTarget 被监听者
		 * @param sourceGetterName 被监听者得get函数名
		 * @param tagrget 接收者
		 * @param targetSetterName 接收者setter函数名 
		 * @param DataChangeEventName 事件源数据发生改变的事件名
		 * 
		 */
		public function bindSetter(sourceTarget:IEventDispatcher,sourceGetterName:String,tagrget:Object,targetSetterName:String,DataChangeEventName:String = "dataChanged"):void
		{
			if(!_hasBind)
			{
				_hasBind = true;
				
				_sourceTarget = sourceTarget;
				_tagrget = tagrget;
				
				_sourceGetterName = sourceGetterName;
				_targetSetterName = targetSetterName;
				
				_DataChangeEventName = DataChangeEventName;
				_getterValue = _sourceTarget[_sourceGetterName];
				_sourceTarget.addEventListener(_DataChangeEventName,handleDataChange);
				
			}
					
		}
		
		private function handleDataChange(e:Event):void
		{
			//(e as Event).stopImmediatePropagation();
			if(_getterValue != _sourceTarget[_sourceGetterName])
			{
				_tagrget[_targetSetterName] = _sourceTarget[_sourceGetterName];
			}
		}
		
		public function dispose():void
		{
			if(_sourceTarget)
			{
				_sourceTarget.removeEventListener(_DataChangeEventName,handleDataChange);
			}
			
			if(_hasBind) _hasBind = false;
			this._sourceGetterName = null;
			this._sourceTarget = null;
			this._targetSetterName = null;
			this._tagrget = null;
			_getterValue = null;
		}
		
		public function get id():String
		{
			return _id;
		}
		
		public function get hasBind():Boolean
		{
			return _hasBind;
		}

	}
}