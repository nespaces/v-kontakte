package by.typing.vkontakte.data.wall
{
    import by.typing.vkontakte.data.VkontakteData;
    
    /**
     * Class WallPostData ...
     * @author Yuriy (Mur4ik) Kulkoff
     * @version 0.1
     * @date 06.02.2010
     */
    public class WallPostData extends VkontakteData
    {
        
        /**
         * 
         */        
        public var wall_id:String;
        
        /**
         * 
         */        
        public var post_id:String;
        
        /**
         * 
         */        
        public var server:String;
        
        /**
         * 
         */        
        public var photo:String;
        
        /**
         * 
         */        
        public var hash:String;
        
        /**
         * 
         */        
        public var photo_id:String;
        
        /**
         * 
         */        
        public var message:String;
        
        /**
         * Создает объект <code>WallPostData</code>
         * 
         * @param xml
         * 
         */        
        public function WallPostData(xml:XML)
        {
            super(xml);
        }
        
        //---------------------------------------------------
        //  PRIVATE METHODS
        //---------------------------------------------------
        
        /*<photo>
            <pid>98054577</pid>
            <aid>17071606</aid>
            <owner_id>6492</owner_id>
            <src>httр://cs1262.vkоntakte.ru/u06492/17071606/m_c0e7ad8f.jpg</src>
            <src_big>httр://cs1262.vkоntakte.ru/u06492/17071606/x_61f9e881.jpg</src_big>
            <src_small>httр://cs1262.vkоntakte.ru/u06492/17071606/s_5ead0b2f.jpg</src_small>
            <created>1204577872</created> -- Время в секундах
        </photo>*/
        
        
        override protected function parseData(data:*):void
        {
            var xml:XML = XML(data);
            
            wall_id = xml.;
            post_id = xml.;
            server = xml.;
            photo = xml.;
            hash = xml.;
            photo_id = xml.;
            message = xml.;
        }
    }
}