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

package by.typing.vkontakte.commands.photos
{
    
    import by.typing.vkontakte.events.VkontakteResponseEvent;
    import by.typing.vkontakte.net.VkontakteCall;
    import by.typing.vkontakte.vkontakte_internal;
    
    use namespace vkontakte_internal;
    
    /**
     * Меняет порядок альбома в списке альбомов пользователя.
     */
    public class ReorderAlbumsCommand extends VkontakteCall
    {
        
        private static const METHOD:String = "photos.reorderAlbums";
        private static const V:String = "2.0";
        
        //--------------------------------------------------------------------------
        //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
         * Создает объект <code>ReorderAlbumsCommand</code>.
         * 
         * @param aid       Id альбома, порядок которого нужно изменить. 
         * @param before    Id альбома, после которого следует поместить альбом. 
         * @param after     Id альбома, после которого следует поместить альбом. 
         * @param oid       Id владельца альбома, по умолчанию id текущего пользователя.
         * 
         */                       
        public function ReorderAlbumsCommand(aid:String, before:String, after:String, oid:String = "")
        {
            super(METHOD, V);
            
            variables.aid = aid;
            variables.before = before;
            variables.after = after;
            
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
        //  aid
        //----------------------------------
        //----------------------------------
        //  before
        //----------------------------------
        //----------------------------------
        //  after
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