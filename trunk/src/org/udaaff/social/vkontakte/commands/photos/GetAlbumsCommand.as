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
	 * Возвращает список альбомов пользователя.
	 */
	public class GetAlbumsCommand extends VkontakteCall
	{
		
		private static const METHOD:String = "photos.getAlbums";
		
		
		/**
		 * Создает объект <code>GetAlbumsCommand</code>.
		 * 
		 * @param uid		 Id пользователя, которому принадлежат альбомы. 
		 *					По умолчанию Id текущего пользователя.
		 * @param aids		Массив Id альбомов.
		 * 
		 */		
		public function GetAlbumsCommand(uid:String = null, aids:Array /* of String */ = null)
		{
			super(METHOD);
				
			if (uid)
				_variables.uid = uid;
			
			if (aids)
				_variables.aids = aids.join(",");
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
		 * ID пользователя, которому принадлежат альбомы. Параметр запроса.
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
		//  aids
		//----------------------------------
		
		/**
		 * Параметр запроса.
		 * Массив ID альбомов. Параметр запроса.
		 * 
		 * @default null
		 */
		public function get aids():Array
		{
			return _variables.aids;
		}
		
		/**
		 * @private
		 */
		public function set aids(value:Array):void
		{
			if (!value)
				return;
			
			_variables.aids = value.join(",");
		}
		
		//----------------------------------
		//  albums
		//----------------------------------
		
		private var _albums:Array /* of AlbumData */;
		
		/**
		 * Содержит информацию об альбомах пользователя в виде 
		 * массива объектов <code>AlbumData</code>.
		 * Данное свойство заполняется только после операции загрузки ответа.
		 * 
		 * @see org.udaaff.social.vkontakte.data.photos.AlbumData
		 */
		public function get albums():Array
		{
			return _albums;
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Overridden methods
		//
		//--------------------------------------------------------------------------
		
		/*<?xml version="1.0" encoding="utf-8"?>
		<response list="true">
			<album>
				<aid>16178407</aid>
				<thumb_id>96509883</thumb_id>
				<owner_id>6492</owner_id>
				<title/>
				<description/>
				<created>1203967836</created>
				<updated>1238072451</updated>
				<size>3</size>
				<privacy>3</privacy>
			</album>
			<album>
				<aid>17071606</aid>
				<thumb_id>98054577</thumb_id>
				<owner_id>6492</owner_id>
				<title/>
				<description/>
				<created>1204576880</created>
				<updated>1229532461</updated>
				<size>3</size>
				<privacy>0</privacy>
			</album>
		</response>*/
		/**
		 * @private
		 */
		override protected function responseHandler(xml:XML):void
		{
			_albums = [];
			for each (var node:XML in xml.album)
			{
				_albums.push(new AlbumData(node));
			}
			
			dispatchEvent(new VkontakteResponseEvent(xml, _albums));
		}
		
		/**
		 * @private
		 */
		override vkontakte_internal function execute():void
		{
			super.vkontakte_internal::execute();
			
			_albums = null;
		}
		
	}
	
}