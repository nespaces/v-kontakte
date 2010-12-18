////////////////////////////////////////////////////////////////////////////////
//
//  Copyright 2009 Vitali Sosnovski
//
//  NOTICE: You may distribute this class freely, 
//  provided it is not modified in any way (including
//  removing this header or changing the package path).
//
//  Please contact udaaff[at]gmail.com prior to distributing 
//  modified versions of this class.
//
////////////////////////////////////////////////////////////////////////////////

package org.udaaff.social.vkontakte.commands
{
	
	import org.udaaff.social.vkontakte.events.VkontakteResponseEvent;
	import org.udaaff.social.vkontakte.net.VkontakteCall;
	import org.udaaff.social.vkontakte.vkontakte_internal;
	
	use namespace vkontakte_internal;
	
	/**
	 * Возвращает значение переменной, номер которой задан в параметре key (0-4095).
	 */
	public class GetVariableCommand extends VkontakteCall
	{
		
		private static const METHOD:String = "getVariable";
		
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * Создает объект <code>GetVariableCommand</code>.
		 *  
		 * @param key		   Ключ от 0 до 4095, идентификатор первой переменной.
		 * @param user_id	   Id пользователя, переменные которого считываются 
		 *					  (если идёт обращение к переменным <code>user_vars</code> 
		 *					  с ключами от 1280 до 1791).
		 * @param session	   целочисленный идентификатор сеанса (комнаты). 
		 *					  Может быть использован для работы с переменными 
		 *					  <code>session_vars</code> и <code>instance_vars</code> с ключами от 2048 до 4095. 
		 *					  Если не указан, то равен 0.
		 * 
		 */		
		public function GetVariableCommand(key:uint, user_id:String = null, session:uint = 0)
		{
			super(METHOD);
			
			_variables.key = key;
			_variables.session = session;
			
			if (user_id)
				_variables.user_id = user_id;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		//----------------------------------
		//  key
		//----------------------------------
		
		/**
		 * Параметр запроса.
		 * Ключ от 0 до 4095, идентификатор переменной.
		 */
		public function get key():uint
		{
			return _variables.key;
		}
		
		/**
		 * @private
		 */		
		public function set key(value:uint):void
		{
			_variables.key = value;
		}
		
		//----------------------------------
		//  session
		//----------------------------------
		
		/**
		 * Параметр запроса.
		 * Целочисленный идентификатор сеанса (комнаты). 
		 * Может быть использован для работы с переменными 
		 * <code>session_vars</code> и <code>instance_vars</code> с ключами от 2048 до 4095. 
		 * Если не указан, то равен 0.
		 */		
		public function get session():uint
		{
			return _variables.session;
		}
		
		/**
		 * @private 
		 */		
		public function set session(value:uint):void
		{
			_variables.session = value;
		}
		
		//----------------------------------
		//  user_id
		//----------------------------------
		
		/**
		 * Параметр запроса.
		 * Id пользователя, переменные которого считываются 
		 * (если идёт обращение к переменным <code>user_vars</code> 
		 * с ключами от 1280 до 1791).
		 */		
		public function get user_id():String
		{
			return _variables.user_id;
		}
		
		/**
		 * @private 
		 */		
		public function set user_id(value:String):void
		{
			_variables.user_id = value;
		}
		
		//----------------------------------
		//  value
		//----------------------------------
		
		private var _value:String;
		
		/**
		 * Значение переменной.
		 * Данное свойство заполняется только после операции загрузки ответа.
		 */
		public function get value():String
		{
			return _value;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		
		/*<?xml version="1.0" encoding="UTF-8"?>
		<response>1205887037</response>*/
		/**
		 * @private
		 */
		override protected function responseHandler(row:XML):void
		{
			_value = row.toString();
			
			dispatchEvent(new VkontakteResponseEvent(row, _value));
		}
		
		/**
		 * @private
		 */
		override vkontakte_internal function execute():void
		{
			super.vkontakte_internal::execute();
			
			_value = null;
		}
		
	}
	
}