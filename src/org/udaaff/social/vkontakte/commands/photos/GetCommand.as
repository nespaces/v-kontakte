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

package org.udaaff.social.vkontakte.commands.photos
{
	
	import org.udaaff.social.vkontakte.data.photos.PhotoData;
	import org.udaaff.social.vkontakte.events.VkontakteResponseEvent;
	import org.udaaff.social.vkontakte.net.VkontakteCall;
	import org.udaaff.social.vkontakte.vkontakte_internal;
	
	use namespace vkontakte_internal;
	
	/**
	 * Возвращает список фотографий в альбоме.
	 */
	public class GetCommand extends VkontakteCall
	{
		
		private static const METHOD:String = "photos.get";
		

		
		/**
		 * Создает объект <code>GetCommand</code>.
		 * 
		 * @param uid		 Id пользователя, которому принадлежит альбом с фотографиями.
		 * @param aid		 Id альбома с фотографиями.
		 * @param pids		Массив Id фотографий.
		 * 
		 */		
		public function GetCommand(uid:String, aid:String, pids:Array = null)
		{
			super(METHOD);
			
			_variables.uid = uid;
			_variables.aid = aid;
			
			if (pids)
				_variables.pids = pids.join(",");
			
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
		 * Id пользователя, которому принадлежит альбом с фотографиями.
		 */
		public function get uid():String
		{
			return _variables.uid;
		}
		
		/**
		 * @private
		 */
		public function set uid(value:String):void
		{
			_variables.uid = value;
		}
		
		//----------------------------------
		//  aid
		//----------------------------------
		
		/**
		 * Параметр запроса.
		 * Id альбома с фотографиями.
		 */
		public function get aid():String
		{
			return _variables.aid;
		}
		
		/**
		 * @private 
		 */		
		public function set aid(value:String):void
		{
			_variables.aid = value;
		}
		
		//----------------------------------
		//  pids
		//----------------------------------
		
		/**
		 * Параметр запроса.
		 * Массив Id фотографий.
		 */	
		public function get pids():Array
		{
			return _variables.pids;
		}
		
		/**
		 * @private 
		 */		
		public function set pids(value:Array):void
		{
			_variables.pids = value;
		}
		
		//----------------------------------
		//  photos
		//----------------------------------
		
		private var _photos:Array /* of PhotoData */;
		
		/**
		 * Содержит массив объектов <code>PhotoData</code>.
		 * Данное свойство заполняется только после операции загрузки ответа.
		 * 
		 * @see org.udaaff.social.vkontakte.data.photos.PhotoData
		 */
		public function get photos():Array
		{
			return _photos;
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Overridden Methods
		//
		//--------------------------------------------------------------------------
		
		/*<?xml version="1.0" encoding="utf-8"?>
		<response list="true">
			<photo>
				<pid>98054577</pid>
				<aid>17071606</aid>
				<owner_id>6492</owner_id>
				<src>httр://cs1262.vkоntakte.ru/u06492/17071606/m_c0e7ad8f.jpg</src>
				<src_big>httр://cs1262.vkоntakte.ru/u06492/17071606/x_61f9e881.jpg</src_big>
				<src_small>httр://cs1262.vkоntakte.ru/u06492/17071606/s_5ead0b2f.jpg</src_small>
				<created>1204577872</created>
			</photo>
			<photo>
				<pid>114535141</pid>
				<aid>17071606</aid>
				<owner_id>6492</owner_id>
				<src>httр://cs230.vkоntakte.ru/u06492/17071606/m_f50994e1.jpg</src>
				<src_big>httр://cs230.vkоntakte.ru/u06492/17071606/x_ab5678ea.jpg</src_big>
				<src_small>httр://cs230.vkоntakte.ru/u06492/17071606/s_1638d6d0.jpg</src_small>
				<created>1214984027</created>
			</photo>
		</response>*/
		
		/**
		 * @private
		 */
		override protected function responseHandler(xml:XML):void
		{
			_photos = [];
			for each (var node:XML in xml.photo)
			{
				_photos.push(new PhotoData(node));
			}
			
			dispatchEvent(new VkontakteResponseEvent(xml, _photos));
		}
		
		/**
		 * @private
		 */
		override vkontakte_internal function execute():void
		{
			super.vkontakte_internal::execute();
			
			_photos = null;
		}
	
	}
	
}