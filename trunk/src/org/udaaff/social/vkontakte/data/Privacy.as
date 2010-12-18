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
	 * Набор констант, определяющих уровень доступа.
	 */
	public class Privacy
	{
		
		/**
		 * Доступ имеют друзья и друзья друзей.
		 */		
		public static const MY_FRIENDS_AND_FRIENDS_OF_FRIENDS:uint = 0;
		
		/**
		 * Доступ имеют все пользователи. 
		 */		
		public static const ALL_USERS:uint = 1;
		
		/**
		 * Доступ имеют только друзья. 
		 */		
		public static const ONLY_MY_FRIENDS:uint = 2;
	}
	
}