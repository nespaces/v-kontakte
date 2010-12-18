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
	
	import org.udaaff.social.vkontakte.net.VkontakteCall;
	
	/**
	 * Универсальный метод, который позволяет запускать последовательность 
	 * других методов, сохраняя и фильтруя промежуточные результаты. 
	 * Поддерживаются арифметические операции, массивы, списки, parseInt, 
	 * parseDouble, конкатенация (+), фильтр массива по параметру (@.), 
	 * создание массивов и списков ([X,Y]), вызовы методов API. 
	 * В данный момент не поддерживаются функции, логические операции, циклы и условия.
	 */	
	public class ExecuteCommand extends VkontakteCall
	{
		
		private static const METHOD:String = "execute";
		
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * Конструктор.
		 * 
		 * @param code	  Код алгоритма в VKScript — формате, похожем на JavaSсript 
		 *				  или ActionScript (предполагается совместимость с ECMAScript). 
		 *				  Алгоритм должен завершаться командой return %выражение%. 
		 *				  Операторы должны быть разделены точкой с запятой.
		 * 
		 */		
		public function ExecuteCommand(code:String)
		{
			super(METHOD);
			
			_variables.code = code;
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		//----------------------------------
		//  code
		//----------------------------------
		
		/**
		 * Код алгоритма в VKScript — формате, похожем на JavaSсript или ActionScript 
		 * (предполагается совместимость с ECMAScript). Алгоритм должен завершаться 
		 * командой return %выражение%. Операторы должны быть разделены точкой с запятой.
		 */ 
		public function get code():String
		{
			return _variables.code;
		}
		
		/**
		 * @private 
		 */		
		public function set code(value:String):void
		{
			_variables.code = value;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		
	}
	
}