﻿////////////////////////////////////////////////////////////////////////////////
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

package org.udaaff.social.vkontakte.net
{

	import org.udaaff.social.vkontakte.ApplicationParameters;
	import org.udaaff.social.vkontakte.errors.VkontakteErrorEvent;
	import org.udaaff.social.vkontakte.events.VkontakteResponseEvent;
	import org.udaaff.social.vkontakte.vkontakte_internal;

	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	
	use namespace vkontakte_internal;
	
	/**
	 * Отправляется, когда запрос возвращает ошибку.
	 * 
	 * @eventType org.udaaff.social.vkontakte.errors.VkontakteErrorEvent.ERROR
	 */
	[Event(name="error", type="org.udaaff.social.vkontakte.errors.VkontakteErrorEvent")]
	
	/**
	 * Отправляется, когда запрос возвращает ответ.
	 * 
	 * @eventType org.udaaff.social.vkontakte.events.VkontakteResponseEvent.RESPONSE
	 */	
	[Event(name="response", type="org.udaaff.social.vkontakte.events.VkontakteResponseEvent")]
	
	/**
	 * 
	 */
	public class VkontakteCall extends URLLoader
	{
		
		public static const V:String = "3.0";
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * Создает объект <code>VkontakteCall</code>.
		 * 
		 * @param method		Название метода API из общего списка функций.
		 * @param verision	  Версия API.
		 */		
		public function VkontakteCall(method:String)
		{
			super();
			
			_method = method;
			
			_variables = new VkontakteVariables();
			_variables.method = method;
			_variables.v = V;
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Variables 
		//
		//--------------------------------------------------------------------------
		
		/**
		 * Переменные отправляемые в запросе. 
		 */		
		protected var _variables:VkontakteVariables;
		
		private var _method:String;
		
		vkontakte_internal var parameters:ApplicationParameters;
//		vkontakte_internal var isTestMode:Boolean;
//		vkontakte_internal var privateKey:String;
		
		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		//----------------------------------
		//  name
		//----------------------------------
		
		/**
		 * Имя метода.
		 */
		public function get name():String
		{
			return _method;
		}
		
		//----------------------------------
		//  data
		//----------------------------------
		
		/**
		 * Полученные данные в формате XML
		 */		
		private var _xml:XML;
		
		public function get xml():XML
		{
			return _xml;
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Methods vkontakte_internal, private, protected
		//
		//--------------------------------------------------------------------------
		
		vkontakte_internal function execute():void
		{
			_variables.api_id = parameters.api_id;
//			if (isTestMode)
//				_variables.test_mode = 1;
			
//			_variables.buildSignature(parameters.viewer_id, privateKey);
			_variables.buildSignature(parameters.viewer_id, parameters.secret);
			_variables.sid = parameters.sid;
			
			var request:URLRequest = new URLRequest(parameters.api_url);
			request.data = _variables;
			request.method = URLRequestMethod.POST;
			
			addEventListener(Event.COMPLETE, urlLoader_completeHandler);
			load(request);
		}
		
		private function urlLoader_completeHandler(event:Event):void
		{
			_xml = new XML(URLLoader(event.target).data);
			if (_xml.localName() == "response")
				responseHandler(_xml);
			else if (_xml.localName() == "error")
				errorHandler(_xml);
			
		}
		
		/**
		 * Метод служит для обработки исходных данных ответа в формате XML,
		 * и отправки события <code>response</code> основанного на этих
		 * данных.
		 * Обычно переопределяется в дочерних классах.
		 * 
		 * @param row		Исходные данные ответа.
		 * 
		 */		
		protected function responseHandler(row:XML):void
		{
			dispatchEvent(new VkontakteResponseEvent(row, row));
		}
		
		/*<error>
			<error_code>4</error_code>
			<error_msg>Incorrect signature</error_msg>
			<request_params list="true">
				<param>
					<key>fields</key>
					<value>photo,nickname</value>
				</param>
				<param>
					<key>uids</key>
					<value>10189183</value>
				</param>
				<param>
					<key>v</key>
					<value>2.0</value>
				</param>
				<param>
					<key>api_id</key>
					<value>1688569</value>
				</param>
				<param>
					<key>method</key>
					<value>getProfiles</value>
				</param>
				<param>
					<key>sig</key>
					<value>29122b5c693decde3fdbe50d818daa44</value>
				</param>
			</request_params>
		</error>*/
		
		/**
		 * Метод служит для обработки исходных данных ошибки в формате XML,
		 * и отправки события <code>error</code> основанного на этих
		 * данных.
		 *  
		 * @param row	 Исходные данные ошибки в формате XML.
		 * 
		 */		
		protected function errorHandler(row:XML):void
		{
			var params:Object = {};
			for each (var node:XML in row.request_params.*)
			{
				params[node.key] = node.value.toString();
			}
			
			dispatchEvent(new VkontakteErrorEvent(row, 
					row.error_msg, row.error_code, params));
		}
		
	}
	
}