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
	
	import org.udaaff.social.vkontakte.data.photos.AlbumData;
	import org.udaaff.social.vkontakte.events.VkontakteResponseEvent;
	import org.udaaff.social.vkontakte.net.VkontakteCall;
	import org.udaaff.social.vkontakte.vkontakte_internal;
	
	use namespace vkontakte_internal;
	
	/**
	 * Создает пустой альбом для фотографий.
	 */
	public class CreateAlbumCommand extends VkontakteCall
	{
		
		private static const METHOD:String = "photos.createAlbum";
		
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * Создает объект <code>CreateAlbumCommand</code>.
		 *  
		 * @param title		  Название альбома.
		 * @param privacy		Уровень доступа к альбому.
		 * @param description	Текст описания альбома.
		 * 
		 * @see org.udaaff.social.vkontakte.data.Privacy
		 */		
		public function CreateAlbumCommand(title:String, privacy:uint = 0, 
										   description:String = null)
		{
			super(METHOD);
			
			_variables.title = title;
			_variables.privacy = privacy;
			
			if (description)
				_variables.description = description;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		//----------------------------------
		//  title
		//----------------------------------
		
		/**
		 * Параметр запроса. 
		 * Название альбома.
		 */
		public function get title():String
		{
			return _variables.title;
		}
		
		/**
		 * @private
		 */
		public function set title(value:String):void
		{
			_variables.title = value;
		}
		
		//----------------------------------
		//  privacy
		//----------------------------------
		
		/**
		 * Параметр запроса.
		 * Уровень доступа к альбому.
		 * 
		 * @default Privacy.MY_FRIENDS_AND_FRIENDS_OF_FRIENDS
		 * @see org.udaaff.social.vkontakte.data.Privacy
		 */
		public function get privacy():uint
		{
			return _variables.privacy;
		}
		
		/**
		 * @private
		 */
		public function set privacy(value:uint):void
		{
			_variables.privacy = value;
		}
		
		//----------------------------------
		//  description
		//----------------------------------
		
		/**
		 * Параметр запроса.
		 * Текст описания альбома.
		 * 
		 * @default null
		 */
		public function get description():String
		{
			return _variables.description;
		}
		
		/**
		 * @private
		 */
		public function set description(value:String):void
		{
			_variables.description = value;
		}
		
		//----------------------------------
		//  album
		//----------------------------------
		
		private var _album:AlbumData;
		
		/**
		 * Содержит объект <code>AlbumData</code> со свойствами созданного альбома.
		 * Данное свойство заполняется только после операции загрузки ответа.
		 */
		public function get album():AlbumData
		{
			return _album;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		
		/*<?xml version="1.0" encoding="utf-8"?>
		<response list="true">
			<album>
				<aid>17071606</aid>
				<thumb_id>-1</thumb_id>
				<owner_id>6492</owner_id>
				<title>Новый альбом</title>
				<description/>
				<created>1204576880</created>
				<updated>1204576880</updated>
				<size>0</size>
				<privacy>0</privacy>
			</album>
		</response>*/
		/**
		 * @private
		 */
		override protected function responseHandler(row:XML):void
		{
			_album = new AlbumData(row.album[0]);
			
			dispatchEvent(new VkontakteResponseEvent(row, _album));
		}
		
		/**
		 * @private
		 */
		override vkontakte_internal function execute():void
		{
			super.vkontakte_internal::execute();
			
			_album = null;
		}
		
	}
	
}