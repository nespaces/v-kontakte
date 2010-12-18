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
	 * Возвращает информацию о том, установил ли текущий пользователь приложение или нет.
	 */
	public class IsAppUserCommand extends VkontakteCall
	{
		
		private static const METHOD:String = "isAppUser";
		
		
		/**
		 * Создает объект <code>IsAppUserCommand</code>.
		 *  
		 * @param uid	 Id пользователя. По умолчанию Id текущего пользователя.
		 * 
		 */		
		public function IsAppUserCommand(uid:String = null)
		{
			super(METHOD);
			
			if (uid)
				_variables.uid = uid;
		}		
		
		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		//----------------------------------
		//  uid
		//----------------------------------
		
		/**
		 * Параметр запроса.
		 * Id пользователя. По умолчанию Id текущего пользователя.
		 */
		public function get():String
		{
			return _variables.uid;
		}
		
		/**
		 * @private
		 */
		public function set(value:String):void
		{
			_variables.uid = value;
		}
		
		//----------------------------------
		//  isAppUser
		//----------------------------------
		
		private var _isAppUser:Boolean;
		
		/**
		 * Показывает, установил ли пользователь у себя данное приложение.
		 * Данное свойство заполняется только после операции загрузки ответа.
		 */
		public function get isAppUser():Boolean
		{
			return _isAppUser;
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Overridden methods
		//
		//--------------------------------------------------------------------------
		
		/*
			Response sample:
			<?xml version="1.0" encoding="UTF-8"?>
			<response>1</response>
		*/
		
		/**
		 * @private
		 */
		override protected function responseHandler(xml:XML):void
		{
			_isAppUser = Boolean(int(xml.toString()));
			dispatchEvent(new VkontakteResponseEvent(xml, _isAppUser));
		}
		
		/**
		 * @private
		 */
		override vkontakte_internal function execute():void
		{
			super.vkontakte_internal::execute();
			
			_isAppUser = false;
		}
		
	}
	
}