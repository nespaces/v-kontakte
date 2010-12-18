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

package org.udaaff.social.vkontakte.data.wall
{
    
    import org.udaaff.social.vkontakte.data.VkontakteData;
    
    /**
     *
     */ 
    public class PostData extends VkontakteData
    {
        
        //--------------------------------------------------------------------------
        //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
         * 
         * @param data
         * 
         */        
        public function PostData(data:XML)
        {
            super(data);
        }
        
        /**
         * 
         */        
        public var post_hash:String;
        
        /**
         * 
         */        
        public var photo_src:String;
        
        //--------------------------------------------------------------------------
        //
        //  Methods
        //
        //--------------------------------------------------------------------------
        
        /*<?xml version="1.0" encoding="utf-8"?>
        <response list="true">
            <post_hash>264b5d004f5524e8c781cb9dafb75de1</post_hash>
            <photo_src>http://cs9231.vkontakte.ru/u06492/a_7b9c2b04.jpg</photo_src>
        </response>*/
        override protected function parseData(data:*):void
        {
            var xml:XML = new XML(data);
            
            post_hash = xml.post_hash;
            photo_src = xml.photo_src;
        }
        
    }
    
}