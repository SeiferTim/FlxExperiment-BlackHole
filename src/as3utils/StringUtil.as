/***************************************************************************
* Class made by: Josh Chernoff, http://gfxcomplex.com)
* Methods made by: The Flash Community 
* =============================================================
* 
* This program is free software; you can redistribute it and/or modify it.
* 
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; 
*
* Thank you all in the community who have contributed to the code that provided this class. 
*
* ************************************************************************
*/
package as3utils{
   public class StringUtil{      
      /**
      * A function used for replacing portions of a string with a new one.
      * Note that this function does not modify the original string.  
      * 
      * @usage   var str:String = "Hello World!";
      *         trace(strReplace(str, "Hello", "Goodbye")); //outputs Goodbye World!
      *         trace(str); //outputs Hello World! 
      *
      * @prams   str:String       The string to have portions replaced.
      * @prams   search:String   The string to search for and replace in str.
      * @prams   replace:String    The string which is placed where the search string is found.
      *
      * @return   String          The original string with portions replaced.
      */      
      static public function strReplace(str:String, search:String, replace:String):String {
         return str.split(search).join(replace);
      }
      
      /**
      * Returns the amount of words in the string argument.
      * 
      * @usage   trace(wordcount("An apple a day keeps the doctor away")); //8 
      *
      * @prams   string:String   The string in which the wordcount will be taken.
      *
      * @return   Number         number of words in the string
      */
      static public function wordcount(string:String):Number {
         var tmp:Array = string.split(" ");
         for (var i = tmp.length; i>0; i--) {
            if (tmp[i] == "") {
               tmp.splice(i,1);
            }
         }
         return tmp.length;
      }      
      /**
      * autoFormat : String
      * Formats a text string. All sentences are started with a capital, all Is are capitalised       
      * (ie: so I did this) and sentences can all be spaced to a specified amount of spaces.
      * 
      * @usage   
      *
      * @prams   what:String         The string to format.
      * @prams   numSpaces:Number    How many space to insert 
      *                        after full stops, default is 1.
      * @return   String            Formated text string
      */
      static public function autoFormatString(what:String, numSpaces:Number):String {
         var tmp:Array = what.split(".");
         if (!numSpaces) {
            numSpaces = 1;
         }
         var tmpStr:String = "";
         for (var i:int = numSpaces; i > 0; i--) {
             tmpStr += " ";
         }
          for each(var z in tmp) {
            while (tmp[i].charAt(0) === " ") {
                  tmp[z] = tmp[z].slice(1, tmp[z].length);
              }
              tmp[z] = tmp[z].charAt(0).toUpperCase()+tmp[z].slice(1, tmp[z].length);
          }
          return tmp.join("."+tmpStr).split(" i ").join(" I ").split(" i'").join(" I'");
      }
      
      public function StringUtil(){
         //nothing here
      }
   }
}