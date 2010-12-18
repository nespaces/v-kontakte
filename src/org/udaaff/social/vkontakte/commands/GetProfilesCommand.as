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
	
	import org.udaaff.social.vkontakte.data.UserData;
	import org.udaaff.social.vkontakte.events.VkontakteResponseEvent;
	import org.udaaff.social.vkontakte.net.VkontakteCall;
	import org.udaaff.social.vkontakte.vkontakte_internal;
	
	use namespace vkontakte_internal;
	
	/**
	 * Возвращает расширенную информацию о пользователях. 
	 */
	public class GetProfilesCommand extends VkontakteCall
	{
		
		private static const METHOD:String = "getProfiles";
		
		
		/**
		 * Создает объект <code>GetProfilesCommand</code>.
		 *  
		 * @param uids		  Массив содержащий Id пользователей (максимум 1000 штук).
		 * @param fields		Массив полей анкет, необходимых для получения. 
		 *					  Значения uid, first_name и last_name всегда определены, 
		 *					  вне зависимости от выбранных полей и их количества в запросе.
		 * @param name_case	 Падеж для склонения имени и фамилии пользователя. 
		 *					  Определяется набором констант из класса <code>Case</code>
		 * 
		 * @see org.udaaff.social.vkontakte.commands.ProfileField
		 * @see org.udaaff.social.vkontakte.commands.Case
		 */		
		public function GetProfilesCommand(uids:Array /* of String */, 
										   fields:Array /* of String */ = null, 
										   name_case:String = null)
		{
			super(METHOD);
			
			_variables.uids = uids.join(",");
			
			if (fields)
				_variables.fields = fields.join(",");
			
			if (name_case)
				_variables.name_case = name_case;
		}		
		
		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		//----------------------------------
		//  uids
		//----------------------------------
		
		/**
		 * Параметр запроса.
		 * Массив содержащий Id пользователей (максимум 1000 штук).
		 */
		public function get uids():Array
		{
			return _variables.uids;
		}
		
		/**
		 * @private
		 */
		public function set uids(value:Array):void
		{
			if (value)
				_variables.uids = value.join(",");
		}
		
		//----------------------------------
		//  fields
		//----------------------------------
		
		private var _fields:Array;
		
		/**
		 * Параметр запроса.
		 * Массив полей анкет, необходимых для получения.
		 * 
		 * @see org.udaaff.social.vkontakte.commands.ProfileField
		 */
		public function get fields():Array
		{
			return _fields;
		}
		
		/**
		 * @private
		 */
		public function set fields(value:Array):void
		{
			_fields = value;
		}
		
		//----------------------------------
		//  name_case
		//----------------------------------
		
		private var _name_case:String;
		
		/**
		 * Параметр запроса.
		 * Падеж для склонения имени и фамилии пользователя.
		 * 
		 * @see org.udaaff.social.vkontakte.commands.Case
		 */
		public function get name_case():String
		{
			return _name_case;
		}
		
		/**
		 * @private
		 */
		public function set name_case(value:String):void
		{
			_name_case = value;
		}
		
		//----------------------------------
		//  users
		//----------------------------------
		
		private var _users:Array /* of UserData */;
		
		/**
		 * Содержит массив объектов UserData.
		 * Данное свойство заполняется только после операции загрузки ответа.
		 * 
		 * @see org.udaaff.social.vkontakte.data.UserData
		 */		
		public function get users():Array
		{
			return _users;
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Overridden methods
		//
		//--------------------------------------------------------------------------
		
		/*<?xml version="1.0" encoding="utf-8"?>
		<response list="true">
			<user>
				<uid>1</uid>
				<first_name>Павел</first_name>
				<last_name>Дуров</last_name>
				<photo>httр://cs109.vkоntakte.ru/u00001/c_df2abf56.jpg</photo>
			</user>
			<user>
				<uid>6492</uid>
				<first_name>Andrew</first_name>
				<last_name>Rogozov</last_name>
				<photo>httр://cs537.vkоntakte.ru/u06492/c_28629f1d.jpg</photo>
			</user>
		</response>*/
		
		/**
		 * @private
		 */
		override protected function responseHandler(xml:XML):void
		{
			_users = [];
			for each (var node:XML in xml.user) 
			{
				_users.push(new UserData(node));
			}
			
			dispatchEvent(new VkontakteResponseEvent(xml, _users));
		}
		
		/**
		 * @private
		 */
		override vkontakte_internal function execute():void
		{
			super.vkontakte_internal::execute();
			
			_users = null;
		}
		
	}
	
}