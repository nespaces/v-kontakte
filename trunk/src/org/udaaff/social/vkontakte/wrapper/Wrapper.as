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
    
    import flash.events.EventDispatcher;
    import org.udaaff.social.vkontakte.data.SettingsData;
    import org.udaaff.social.vkontakte.events.BalanceEvent;
    import org.udaaff.social.vkontakte.events.LocationEvent;
    import org.udaaff.social.vkontakte.events.ResizeEvent;
    import org.udaaff.social.vkontakte.events.SettingsEvent;
    import org.udaaff.social.vkontakte.events.WrapperEvent;
    
    
    //--------------------------------------
    //  Events
    //--------------------------------------
    
    /**
     * Событие происходит, когда пользователь изменяет настройки приложений.
     * 
     * @eventType org.udaaff.social.vkontakte.events.SettingsEvent.ON_SETTINGS_CHANGED
     */    
    [Event(name="onSettingsChanged", type="org.udaaff.social.vkontakte.events.SettingsEvent")]
    
    /**
     * Событие происходит, когда пользователь положил или снял голоса с баланса приложения. 
     * Параметр <code>balance</code> содержит текущий баланс пользователя в сотых долях голоса. 
     * Этот параметр можно использовать только для вывода пользователю. 
     * Достоверность баланса всегда нужно проверять с помощью метода <code>secure.getBalance</code>.
     * 
     * @eventType org.udaaff.social.vkontakte.events.BalanceEvent.ON_BALANCE_CHANGED
     */    
    [Event(name="onBalanceChanged", type="org.udaaff.social.vkontakte.events.BalanceEvent")]
    
    /**
     * Событие происходит, когда пользователь добавляет приложение к себе на страницу.
     * 
     * @eventType org.udaaff.social.vkontakte.events.WrapperEvent.ON_APPLICATION_ADDED
     */    
    [Event(name="onApplicationAdded", type="org.udaaff.social.vkontakte.events.WrapperEvent")]
    
    /**
     * Событие происходит, когда пользователь подтвердил сохранение фотографии в окне, 
     * вызванном с помощью функции <code>showProfilePhotoBox</code>.  
     * 
     * @eventType org.udaaff.social.vkontakte.events.WrapperEvent.ON_PROFILE_PHOTO_SAVE
     */    
    [Event(name="onProfilePhotoSave", type="org.udaaff.social.vkontakte.events.WrapperEvent")]
    
    /**
     * Событие происходит, когда окно с приложением теряет фокус. 
     * Например, когда пользователь открывает окно с настройками приложения. 
     * 
     * @eventType org.udaaff.social.vkontakte.events.WrapperEvent.ON_WINDOW_BLUR
     */    
    [Event(name="onWindowBlur", type="org.udaaff.social.vkontakte.events.WrapperEvent")]
    
    /**
     * Событие происходит, когда окно с приложением получает фокус. 
     * Например, когда пользователь закрывает окно с настройками приложения. 
     * 
     * @eventType org.udaaff.social.vkontakte.events.WrapperEvent.ON_WINDOW_FOCUS
     */    
    [Event(name="onWindowFocus", type="org.udaaff.social.vkontakte.events.WrapperEvent")]
    
    /**
     * Событие происходит, когда пользователь переносит указатель мыши за пределы окна приложения. 
     * Это событие является аналогом <code>Event.MOUSE_LEAVE</code> объекта <code>stage</code>.
     * 
     * @eventType org.udaaff.social.vkontakte.events.WrapperEvent.ON_MOUSE_LEAVE
     */    
    [Event(name="onMouseLeave", type="org.udaaff.social.vkontakte.events.WrapperEvent")]
    
    /**
     * Событие происходит, когда размер окна приложения был изменен. 
     * Параметры <code>width</code> и <code>height</code> содержат новые размеры приложения в пикселах.
     * 
     * @eventType org.udaaff.social.vkontakte.events.ResizeEvent.ON_WINDOW_RESIZED
     */
    [Event(name="onWindowResized", type="org.udaaff.social.vkontakte.events.ResizeEvent")]
    
    /**
     * Событие происходит, когда изменяется значение хеша после символа # 
     * в адресной строке браузера. Например, это происходит в результате 
     * использования кнопок "назад" и "вперед" в браузере. 
     * Данное событие происходит всегда при запуске приложения.
     * 
     * @eventType org.udaaff.social.vkontakte.events.LocationEvent.ON_LOCATION_CHANGED
     */
    [Event(name="onLocationChanged", type="org.udaaff.social.vkontakte.events.LocationEvent")]
    
    /**
     * Класс-обертка для объекта vk.APIWrapper.
     */
    public class Wrapper extends EventDispatcher
    {
        
        //--------------------------------------------------------------------------
        //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
         * Конструктор.
         *  
         * @param source    Объект APIWrapper.
         * 
         */        
        public function Wrapper(source:Object)
        {
            super();
            
            _source = source;
            
            _source.addEventListener(ResizeEvent.ON_WINDOW_RESIZED, onWindowResizedHandler);
            _source.addEventListener(LocationEvent.ON_LOCATION_CHANGED, onLocationChangedHandler);
            _source.addEventListener(WrapperEvent.ON_APPLICATION_ADDED, wrapperEventHandler);
            _source.addEventListener(WrapperEvent.ON_PROFILE_PHOTO_SAVE, wrapperEventHandler);
            _source.addEventListener(WrapperEvent.ON_MOUSE_LEAVE, wrapperEventHandler);
            _source.addEventListener(WrapperEvent.ON_WINDOW_BLUR, wrapperEventHandler);
            _source.addEventListener(WrapperEvent.ON_WINDOW_FOCUS, wrapperEventHandler);
            _source.addEventListener(BalanceEvent.ON_BALANCE_CHANGED, onBalanceChangedHandler);
            _source.addEventListener(SettingsEvent.ON_SETTINGS_CHANGED, onSettingsChangedHandler);
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
        //  version
        //----------------------------------
        
        private var _source:Object;
        
        public function get source():Object
        {
            return _source;
        }
        
        //----------------------------------
        //  version
        //----------------------------------
        
        /**
         * Недокументированное свойство. 
         * Версия враппера.
         */        
        public function get version():String
        {
            return _source.VERSION;
        }
        
        //----------------------------------
        //  external
        //----------------------------------
        
        private var _external:External;
        
        /**
         * Содержит объект External.
         */
        public function get external():External
        {
            if (!_external)
                _external = new External(_source.external);
            
            return _external;
        }
        
        //----------------------------------
        //  application
        //----------------------------------
        
        private var _application:Application;
        
        /**
         * Содержит объект Application.
         */
        public function get application():Application
        {
            if (!_application)
                _application = new Application(_source.application);
            
            return _application;
        }
        
        //----------------------------------
        //  lang
        //----------------------------------
        
//        private var _lang:Lang;
        
        /**
         * 
         */
        public function get lang():Lang
        {
//            if (!_lang)
//                _lang = new Lang(source.lang);
//            
//            return _lang;
            return _source.lang;
        }
        
        private function onWindowResizedHandler(event:Object):void
        {
            dispatchEvent(new ResizeEvent(event.width, event.height));
        }
        
        private function onLocationChangedHandler(event:Object):void
        {
            dispatchEvent(new LocationEvent(event.location));
        }
        
        private function onBalanceChangedHandler(event:Object):void
        {
            dispatchEvent(new BalanceEvent(event.balance));
        }
        
        private function onSettingsChangedHandler(data:Object):void
        {
            dispatchEvent(new SettingsEvent(new SettingsData(uint(data.settings))));
        }
        
        private function wrapperEventHandler(event:Object):void
        {
            dispatchEvent(new WrapperEvent(event.type));
        }
        
    }
    
}