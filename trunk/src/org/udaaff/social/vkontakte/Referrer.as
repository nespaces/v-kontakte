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
	
	/**
	 * Набор констант, определяющих значения параметра referrer.
	 */ 
	public final class Referrer
	{
		
		/**
		 * Приложение запущено в результате перехода через левое меню. 
		 */	 
		public static const MENU:String = "menu";
		
		/**
		 * Приложение запущено через меню публикации новой записи на стене. 
		 */		
		public static const WALL_POST_INLINE:String = "wall_post_inline";
		
		/**
		 * Приложение запущено через меню публикации 
		 * новой записи на стене и развернуто в новом окне. 
		 */		
		public static const WALL_POST:String = "wall_post";
		
		/**
		 * Приложение запущено со стены пользователя для просмотра ранее размещенной записи. 
		 */		
		public static const WALL_VIEW_INLINE:String = "wall_view_inline";
		
		/**
		 * Приложение запущено со стены пользователя для просмотра 
		 * ранее размещенной записи и развернуто в новом окне.
		 */			  
		public static const WALL_VIEW:String = "wall_view";
		
	}
	
}