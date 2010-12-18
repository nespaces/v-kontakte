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

package org.udaaff.social.vkontakte.net
{
	
	import com.adobe.crypto.MD5;
	
	import flash.net.URLVariables;
	
	/**
	 * Класс предназначен для задания параметров, передаваемых в запросе, а также 
	 * для генерации сигнатуры на основании этих параметров.
	 */
	public dynamic class VkontakteVariables extends URLVariables
	{
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * Создает объект <code>VkontakteVariables</code>. 
		 * 
		 */		
		public function VkontakteVariables()
		{
			super();
		}
	
	
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * Генерирует сигнатуру на основании заданных переменных. Необходимо вызывать
		 * после задания всех необходимых параметров.
		 *  
		 * @param viewer_id		Id пользователя.
		 * @param privateKey	Приватный ключ со страницы редактирования.
		 * 
		 */		
		public function buildSignature(viewer_id:String, privateKey:String):void
		{
			// необходимо удалить, иначе неправильно вычислится hash при повторном
			// вызове
			delete this['sig'];
			
			var array:Array = [];
			for (var field:String in this)
			{
				array.push({ name: field, value: this[field] });
			}
			array.sortOn("name");
			
			var sig:String = viewer_id;
			for each (var o:Object in array)
			{
				sig += o.name + "=" + o.value;
			}
			sig += privateKey;
			
			this['sig'] = MD5.hash(sig);
		}
		
	}
	
}