////////////////////////////////////////////////////////////////////////////////
//
//  Copyright 2009 Vitali Sosnovski
//
//  NOTICE: You may distribute this class freely, 
//  provided it is not modified in any way (including
//  removing this header or changing the package path).
//
//  Please contact udaaff[at]gmail.com prior to 
//  distributing modified versions of this class.
//
////////////////////////////////////////////////////////////////////////////////

package org.udaaff.social.vkontakte.data
{
	
	/**
	 * Класс-обертка для данных пользователя. 
	 */
	public dynamic class UserData extends VkontakteData
	{
		
		/**
		 * Конструктор
		 */
		public function UserData(xml:XML)
		{
			super(xml);			
		}
		
		/**
		 * Имя пользователя.
		 */
		public var first_name:String;
		
		/**
		 * Фамилия пользователя. 
		 */		
		public var last_name:String;
		
		/**
		 * Id пользователя. 
		 */		
		public var uid:String;
		
		/**
		 * Никнейм пользователя.
		 */
		public var nickname:String;
		
		/**
		 * Пол пользователя.
		 * 
		 * @see org.udaaff.social.vkontakte.data.Sex
		 */	
		public var sex:int;
		
		/**
		 * Дата в формате: "23.11.1981" или "21.9" (если год скрыт).
		 */	
		public var bdate:String;
		
		/**
		 * Id города, указанного у пользователя в разделе "Контакты". 
		 * Название города по его id можно узнать при помощи класса GetCitiesCommand.
		 * 
		 * @see org.udaaff.social.vkontakte.commands.GetCitiesCommand 
		 */		
		public var city:String;
		
		/**
		 * Id страны, указанной у пользователя в разделе "Контакты". 
		 * Название страны по её id можно узнать при помощи класса GetCountriesCommand.
		 * 
		 * @see org.udaaff.social.vkontakte.commands.GetCountriesCommand 
		 */		
		public var country:String;
		
		/**
		 * Url фотографии пользователя, имеющей ширину 50 пикселей. 
		 * В случае отсутствия у пользователя фотографии вернет: "images/question_c.gif".
		 */	
		public var photo:String;
		
		/**
		 * Url фотографии пользователя, имеющей ширину 100 пикселей. 
		 * В случае отсутствия у пользователя фотографии вернет: "images/question_b.gif".  
		 */	
		public var photo_medium:String;
		
		/**
		 * Url фотографии пользователя, имеющей ширину 200 пикселей. 
		 * В случае отсутствия у пользователя фотографии вернет: "images/question_a.gif".  
		 */	
		public var photo_big:String;
		
		/**
		 * Показывает, известен ли номер мобильного телефона пользователя. 
		 * Рекомендуется перед вызовом метода secure.sendSMSNotification.  
		 */	
		public var has_mobile:Boolean;
		
		/**
		 * Рейтинг пользователя. 
		 */	
		public var rate:Number;
		
		/*<user>
			<uid>1</uid>
			<first_name>Павел</first_name>
			<last_name>Дуров</last_name>
			<photo>httр://cs109.vkоntakte.ru/u00001/c_df2abf56.jpg</photo>
		</user>*/
		/**
		 * @private
		 */
		override protected function parseData(data:*):void
		{
			var xml:XML = XML(data);
			
			first_name = xml.first_name;
			last_name = xml.last_name;
			uid = xml.uid.toString();
			nickname = xml.nickname;
			sex = xml.sex;
			bdate = xml.bdate;
			city = xml.city.toString();
			country = xml.country.toString();
			photo = xml.photo;
			photo_medium = xml.photo_medium;
			photo_big = xml.photo_big;
			has_mobile = Boolean(int(xml.has_mobile.toString()));
			rate = Number(xml.rate);
		}

	}
	
}