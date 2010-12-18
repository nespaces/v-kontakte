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

package org.udaaff.social.vkontakte.data
{
	
	public class AdData extends VkontakteData
	{
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		public function AdData(data:*)
		{
			super(data);
		}
		
		/**
		 * Заголовок объявления.
		 */		
		public var title:String;
		
		/**
		 * Описание объявления.
		 */		
		public var description:String;
		
		/**
		 * Путь к изображению объявления.
		 */		
		public var photo:String;
		
		/**
		 * Ссылка.
		 */		
		public var link:String;
		
		
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		/*<ad>
			<title>Sample ad</title>
			<description>Sample ad description</description>
			<photo>httр://cs152.vkоntakte.ru/u00001/75628422/s_5380d267.jpg</photo>
			<link>httр://vkоntakte.ru</link>
		</ad>*/
		override protected function parseData(data:*):void
		{
			var xml:XML = XML(data);
			
			title = xml.title;
			description = xml.description;
			photo = xml.photo;
			link = xml.link;
		}
		
	}
	
}