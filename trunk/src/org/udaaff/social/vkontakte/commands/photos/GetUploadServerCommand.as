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
	
	import org.udaaff.social.vkontakte.data.photos.UploadServerData;
	import org.udaaff.social.vkontakte.events.VkontakteResponseEvent;
	import org.udaaff.social.vkontakte.net.VkontakteCall;
	import org.udaaff.social.vkontakte.vkontakte_internal;
	
	use namespace vkontakte_internal;
	
	/**
	 * Возвращает адрес сервера для загрузки фотографий.
	 */
	public class GetUploadServerCommand extends VkontakteCall
	{
		
		private static const METHOD:String = "photos.getUploadServer";
		
		/**
		 * Создает объект <code>GetUploadServerCommand</code>.
		 * 
		 * @param aid	   Id альбома, в который необходимо загрузить фотографии.
		 * @save_big		Если этот параметр равен <code>true</code>, 
		 *				  то помимо стандартных размеров, фотографии будут сохранены 
		 *				  в больших размерах – 807 и 1280 точек в ширину. 
		 *				  По умолчанию равен <code>false</code>.
		 * 
		 */		
		public function GetUploadServerCommand(aid:String, save_big:Boolean = false)
		{
			super(METHOD);
			
			_variables.aid = aid;
			_variables.save_big = save_big;
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		//----------------------------------
		//  aid
		//----------------------------------
		
		/**
		 * Параметр запроса.
		 * Id альбома, в который необходимо загрузить фотографии.
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
		//  save_big
		//----------------------------------
		
		/**
		 * Параметр запроса.
		 * Если это свойство равно <code>true</code>, то помимо стандартных размеров, 
		 * фотографии будут сохранены в больших размерах – 807 и 1280 точек в ширину.
		 * 
		 * @default false
		 */
		public function get save_big():Boolean
		{
			return _variables.save_big;
		}
		
		/**
		 * @private
		 */
		public function set save_big(value:Boolean):void
		{
			_variables.save_big = value;
		}
		
		//----------------------------------
		//  uploadServerData
		//----------------------------------
		
		private var _uploadServerData:UploadServerData;
		
		/**
		 * Содержит объект <code>UploadServerData</code>.
		 * Данное свойство заполняется только после операции загрузки ответа.
		 * 
		 * @see org.udaaff.social.vkontakte.data.photos.UploadServerData
		 */
		public function get uploadServerData():UploadServerData
		{
			return _uploadServerData;
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Overridden Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 */
		override protected function responseHandler(xml:XML):void
		{
			_uploadServerData = new UploadServerData(xml);
			
			dispatchEvent(new VkontakteResponseEvent(xml, _uploadServerData));
		}
		
		/**
		 * @private
		 */
		override vkontakte_internal function execute():void
		{
			super.vkontakte_internal::execute();
			
			_uploadServerData = null;
		}
		
	}
	
}