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
	
	import org.udaaff.social.vkontakte.events.VkontakteResponseEvent;
	import org.udaaff.social.vkontakte.net.VkontakteCall;
	import org.udaaff.social.vkontakte.vkontakte_internal;

	use namespace vkontakte_internal;
	
	/**
	 * Переносит фотографию из одного альбома в другой.
	 */ 
	public class MoveCommand extends VkontakteCall
	{
		
		private static const METHOD:String = "photos.move";
		
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * Конструктор.
		 * 
		 * @param pid		   Id переносимой фотографии.
		 * @param target_id	 Id альбома, куда переносится фотография.
		 * @param oid		   Id владельца переносимой фотографии, 
		 *					  если не задано, то id текущего пользователя.
		 * 
		 */		
		public function MoveCommand(pid:String, target_id:String, oid:String = "")
		{
			super(METHOD);
			
			_variables.pid = pid;
			_variables.target_id = target_id;
			
			if (oid)
				_variables.oid = oid;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		
		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		//----------------------------------
		//  pid
		//----------------------------------
		
		/**
		 * Id переносимой фотографии.
		 */
		public function get pid():String
		{
			return _variables.pid;
		}
		
		/**
		 * @private
		 */
		public function set pid(value:String):void
		{
			_variables.pid = value;
		}
		
		//----------------------------------
		//  target_id
		//----------------------------------
		
		/**
		 * Id альбома, куда переносится фотография.
		 */
		public function get target_id():String
		{
			return _variables.target_id;
		}
		
		/**
		 * @private
		 */
		public function set target_id(value:String):void
		{
			_variables.target_id = value;
		}
		
		//----------------------------------
		//  oid
		//----------------------------------
		
		/**
		 * Id владельца переносимой фотографии, 
		 * по умолчанию id текущего пользователя.
		 */
		public function get oid():String
		{
			return _variables.oid;
		}
		
		/**
		 * @private
		 */
		public function set oid(value:String):void
		{
			_variables.oid = value;
		}
		
		//----------------------------------
		//  success
		//----------------------------------
		
		private var _success:Boolean;
		
		/**
		 * Возвращает <code>true</code> в случае успешного перемещения изображения.
		 * Данное свойство заполняется только после операции загрузки ответа.
		 */
		public function get success():Boolean
		{
			return _success;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		
		/*
		<?xml version="1.0" encoding="utf-8"?>
		<response list="true">1</response>
		*/
		
		/**
		 * @private
		 */
		override protected function responseHandler(row:XML):void
		{
			_success = Boolean(int(row.toString()));
			dispatchEvent(new VkontakteResponseEvent(row, _success));
		}
		
		/**
		 * @private
		 */
		override vkontakte_internal function execute():void
		{
			super.vkontakte_internal::execute();
			
			_success = false;
		}
		
	}
	
}