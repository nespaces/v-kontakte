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
     * Делает фотографию обложкой альбома.
     */
    public class MakeCoverCommand extends VkontakteCall
    {
        
        private static const METHOD:String = "photos.makeCover";
        private static const V:String = "2.0";
        
        //--------------------------------------------------------------------------
        //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
         * Создает объект <code>MakeCoverCommand</code>.
         * 
         * @param pid       Id фотографии, которая должна стать обложкой альбома.
         * @param aid       Id альбома. 
         * @param oid       Id владельца альбома, по умолчанию id текущего пользователя.
         * 
         */        
        public function MakeCoverCommand(pid:String, aid:String, oid:String = "")
        {
            super(METHOD, V);
            
            variables.pid = pid;
            variables.aid = aid;
            
            if (oid)
                variables.oid = oid;
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
        //----------------------------------
        //  aid
        //----------------------------------
        //----------------------------------
        //  oid
        //----------------------------------
        
        //----------------------------------
        //  success
        //----------------------------------
        
        private var _success:Boolean;
        
        /**
         * Возвращает <code>true</code> в случае успеха.
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