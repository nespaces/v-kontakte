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
	
	/**
	 * Класс-обертка для информации о рекорде пользователя.
	 */
	public class ScoreInfoData extends VkontakteData
	{
		
		/**
		 * Конструктор
		 */
		public function ScoreInfoData(xml:XML)
		{
			super(xml);
		}
		
		/**
		 * Счет пользователя.
		 */		
		public var score:Number;
		
		/**
		 * Id пользователя.
		 */		
		public var user_id:uint;
		
		/**
		 * Имя пользователя.
		 */				
		public var user_name:String;
		
		/*<score_info>
			<score>1240000</score>
			<user_id>1</user_id>
			<user_name>Павел Дуров</user_name>
		</score_info>*/
		/**
		 * @private
		 */
		override protected function parseData(data:*):void
		{
			var xml:XML = XML(data);
			
			score = Number(xml.score.toString());
			user_id = uint(xml.user_id.toString());
			user_name = xml.user_name;
		}

	}
	
}