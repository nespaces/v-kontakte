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

package org.udaaff.social.vkontakte
{
	
	import org.udaaff.social.vkontakte.data.SettingsData;
	import org.udaaff.social.vkontakte.data.VkontakteData;
	
	/**
	 * Класс-обертка для параметров приложения.
	 */
	public class ApplicationParameters extends VkontakteData
	{
		
		/**
		 * Создает объект <code>ApplicationParameters</code>.
		 *  
		 * @param parameters	Объект содержащий следующие параметры: <code>api_url, 
		 *					  api_id, user_id, group_id, viewer_id, is_app_user, 
		 *					  viewer_type, auth_key, language, 
		 *					  api_result, api_settings</code>.
		 * 
		 */		
		public function ApplicationParameters(parameters:Object)
		{
			super(parameters);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Основные параметры
		//
		//--------------------------------------------------------------------------
		
		/**
		 * Адрес сервиса API, по которому необходимо осуществлять запросы.  
		 */		
		public var api_url:String;
		
		/**
		 * Id запущенного приложения. 
		 */		
		public var api_id:String;
		
		/**
		 * Id пользователя, со страницы которого было запущено приложение. 
		 * Если приложение запущено не со страницы пользователя, то значение равно <code>'0'</code>.
		 */		
		public var user_id:String;
		
		/**
		 * Id сессии для осуществления запросов к API.
		 */
		public var sid:String;
		
		/**
		 * Секрет, необходимый для осуществления подписи запросов к API.
		 */
		public var secret:String;
		
		/**
		 * Id группы, со страницы которой было запущено приложение. 
		 * Если приложение запущено не со страницы группы, то значение равно <code>'0'</code>. 
		 */		
		public var group_id:String;
		
		/**
		 * Id пользователя, который просматривает приложение. 
		 */		
		public var viewer_id:String;
		
		/**
		 * Если пользователь установил приложение — <code>true</code>, иначе — <code>false</code>. 
		 */		
		public var is_app_user:Boolean;
		
		/**
		 * Тип пользователя, который просматривает приложение.
		 */		
		public var viewer_type:uint;
		
		/**
		 * Ключ, необходимый для авторизации пользователя на стороннем сервере. 
		 */		
		public var auth_key:String;
		
		/**
		 * Id языка пользователя, просматривающего приложение. 
		 */		
		public var language:uint;
		
		/**
		 * Результат первого API-запроса, который выполняется при загрузке приложения. 
		 */		
		public var api_result:String;
		
		/**
		 * Битовая маска настроек текущего пользователя в данном приложении.
		 */
		public var api_settings:SettingsData;
		
		//--------------------------------------------------------------------------
		//
		//  Дополнительные параметры
		//
		//--------------------------------------------------------------------------
		
		/**
		 * Содержит строку с информацией о том, откуда было запущено приложение.
		 * Параметр referrer может принимать следующие значения: 
		 * menu – если приложение запущено в результате перехода через левое меню. 
		 * wall_post_inline – если приложение запущено через меню публикации новой записи на стене. 
		 * wall_post – если приложение запущено через меню публикации новой записи на стене и развернуто в новом окне. 
		 * wall_view_inline – если приложение запущено со стены пользователя для просмотра ранее размещенной записи. 
		 * wall_view – если приложение запущено со стены пользователя для просмотра ранее размещенной записи и развернуто в новом окне.
		 */		
		public var referrer:String;
		
		/**
		 * Id пользователя, разместившего запись на стене. 
		 */		
		public var poster_id:String;
		
		/**
		 * Id сохраненной на стене записи. 
		 */		
		public var post_id:String;
		
		override protected function parseData(data:*):void
		{
			var o:Object = Object(data);
			
			api_url = o.api_url;
			api_id = o.api_id;
			user_id = o.user_id;
			sid = o.sid;
			secret = o.secret;
			group_id = o.group_id;
			viewer_id = o.viewer_id;
			is_app_user = Boolean(int(o.is_app_user));
			viewer_type = uint(o.viewer_type);
			auth_key = o.auth_key;
			language = uint(o.language);
			api_result = o.api_result;
			api_settings = new SettingsData(uint(o.api_settings));
			
			referrer = o.referrer;
			poster_id = o.poster_id;
			post_id = o.post_id;
		}
		
	}
	
}