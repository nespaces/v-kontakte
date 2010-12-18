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

package org.udaaff.social.vkontakte.commands
{
	
	import org.udaaff.social.vkontakte.events.VkontakteResponseEvent;
	import org.udaaff.social.vkontakte.net.VkontakteCall;
	import org.udaaff.social.vkontakte.vkontakte_internal;
	
	use namespace vkontakte_internal;
	
	/**
	 * Возвращает список id групп текущего пользователя.
	 */
	public class GetGroupsCommand extends VkontakteCall
	{
		
		private static const METHOD:String = "getGroups";
		
		
		/**
		 * Создает объект <code>GetGroupsCommand</code>.
		 */		
		public function GetGroupsCommand()
		{
			super(METHOD);
		}
	
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		//----------------------------------
		//  gids
		//----------------------------------
		
		private var _gids:Array /* of String */;
		
		/**
		 * Содержит массив id групп текущего пользователя.
		 * Данное свойство заполняется только после операции загрузки ответа.
		 */
		public function get gids():Array
		{
			return _gids;
		}
		
		
		/*<?xml version="1.0" encoding="utf-8"?>
		<response list="true">
			<gid>1</gid>
			<gid>55</gid>
			<gid>103</gid>
			<gid>354</gid>
		</response>*/
		
		/**
		 * @private
		 */
		override protected function responseHandler(xml:XML):void
		{
			_gids = [];
			for each (var node:XML in xml.gid)
			{
				_gids.push(node.toString());
			}
			
			dispatchEvent(new VkontakteResponseEvent(xml, _gids));
		}
		
		/**
		 * @private
		 */
		override vkontakte_internal function execute():void
		{
			super.vkontakte_internal::execute();
			
			_gids = null;
		}
	}
	
}