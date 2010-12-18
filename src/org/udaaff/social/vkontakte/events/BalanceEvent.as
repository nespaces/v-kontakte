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

package org.udaaff.social.vkontakte.events
{
	
	import flash.events.Event;
	
	/**
	 * 
	 */ 
	public class BalanceEvent extends Event
	{
		
		/**
		 * 
		 */		
		public static const ON_BALANCE_CHANGED:String = "onBalanceChanged";
		
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * Конструктор.
		 * 
		 * @param balance
		 * @param bubbles
		 * @param cancelable
		 * 
		 */		
		public function BalanceEvent(balance:Number, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(ON_BALANCE_CHANGED, bubbles, cancelable);
			
			this.balance = balance;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 
		 */		
		public var balance:Number;
		
		
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 
		 */	
		override public function clone():Event
		{
			return new BalanceEvent(balance, bubbles, cancelable);
		}
		
		/**
		 * 
		 */
		override public function toString():String
		{
			return formatToString("BalanceEvent", "type", "balance", "bubbles", "cancelable");
		}
		
	}
	
}