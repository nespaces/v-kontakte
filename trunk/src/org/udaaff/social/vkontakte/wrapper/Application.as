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

package org.udaaff.social.vkontakte.wrapper
{
    
    import org.udaaff.social.vkontakte.ApplicationParameters;

    /**
     * Класс-обертка для объекта vk.Application.
     */ 
    public class Application
    {
        
        //--------------------------------------------------------------------------
        //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
         * Конструктор
         *  
         * @param source    Объект vk.Application.
         * 
         */        
        public function Application(source:Object)
        {
            super();
            
            this.source = source;
            
            _parameters = new ApplicationParameters(source.parameters);
        }
        
        //--------------------------------------------------------------------------
        //
        //  Variables
        //
        //--------------------------------------------------------------------------
        
        private var source:Object;
        
        
        //--------------------------------------------------------------------------
        //
        //  Properties
        //
        //--------------------------------------------------------------------------
        
        //----------------------------------
        //  parameters
        //----------------------------------
        
        private var _parameters:ApplicationParameters;
        
        /**
         * Параметры приложения.
         */ 
        public function get parameters():ApplicationParameters
        {
            return _parameters;
        }
        
        //----------------------------------
        //  frameRate
        //----------------------------------
        
        /**
         * Число кадров в секунду. По умолчанию 30.
         */ 
        public function get frameRate() : Number
        {
            return source.frameRate;
        }
        
        /**
         * @private
         */
        public function set frameRate(value:Number):void
        {
            source.frameRate = value;
        }
        
        //----------------------------------
        //  stageHeight
        //----------------------------------
        
        /**
         * Значение высоты сцены в пикселах.
         */ 
        public function get stageHeight():Number
        {
            return source.stageHeight;
        }
        
        //----------------------------------
        //  stageWidth
        //----------------------------------
        
        /**
         * Значение ширины сцены в пикселах.
         */ 
        public function get stageWidth():Number
        {
            return source.stageWidth;
        }
        
        //----------------------------------
        //  align
        //----------------------------------
        
        /**
         * Режим выравнивания содержимого сцены. 
         * Определяется константами из объекта StageAlign.
         */ 
        public function get align():String
        {
            return source.align;
        }
         
        /**
         * @private
         */ 
        public function set align(value:String):void
        {
            source.align = value;
        }
        
        //----------------------------------
        //  scaleMode
        //----------------------------------
        
        /**
         * Режим масштабирования сцены. 
         * Определяется константами из объекта StageScaleMode.
         */ 
        public function get scaleMode():String
        {
            return source.scaleMode;
        }
        
        /**
         * @private
         */ 
        public function set scaleMode(value:String):void
        {
            source.scaleMode = value;
        }
        
        //----------------------------------
        //  quality
        //----------------------------------
        
        /**
         * Качество отображения сцены. 
         * Определяется константами из объекта StageQuality.
         */ 
        public function get quality():String
        {
            return source.quality;
        }
        
        /**
         * @private
         */ 
        public function set quality(value:String):void
        {
            source.quality = value;
        }
        
    }
    
}