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
	 * Возвращает баланс текущего пользователя на счету приложения.
	 */
	public class GetUserBalanceCommand extends VkontakteCall
	{
		
		private static const METHOD:String = "getUserBalance";
		
		
		/**
		 * Создает объект <code>GetUserBalanceCommand</code>.
		 */		
		public function GetUserBalanceCommand()
		{
			super(METHOD);
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		//----------------------------------
		//  balance
		//----------------------------------
		
		private var _balance:Number;
		
		/**
		 * Возвращает количество голосов в сотых долях. 
		 * которые есть на балансе текущего пользователя в приложении.
		 * Данное свойство заполняется только после операции загрузки ответа.
		 */
		public function get balance():Number
		{
			return _balance;
		}
		
		
		/*<?xml version="1.0" encoding="utf-8"?>
		<response>
			<balance>350</balance> -- в сотых долях
		</response>*/
		
		/**
		 * @private
		 */
		override protected function responseHandler(xml:XML):void
		{
			_balance = Number(xml.balance.toString());
			
			dispatchEvent(new VkontakteResponseEvent(xml, _balance));
		}
		
		/**
		 * @private
		 */
		override vkontakte_internal function execute():void
		{
			super.vkontakte_internal::execute();
			
			_balance = NaN;
		}
	}
	
}