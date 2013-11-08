/***************************************************************************
* Class made by: Josh Chernoff http://gfxcomplex.com)
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
   public class NumberUtil{         
      /**
      * Description: A function that returns the parity of a number. 
      * In mathematics, parity refers to whether a number is odd or even. 
      * 
      * @usage   trace(numParity(89)); // outputs odd
      *
      * @prams   num:Number   The number to analyze.
      *
      * @return   String      If the number is found odd, "odd" will be returned, otherwise, 
      *                  if the number is found even, "even" will be returned.
      */
      static public function numParity(num:uint):String {
         var parity:String;
         num % 2 ? parity = "odd" : parity = "even";
         return parity;
      }
      
      
      /**
      * A function that returns n! (factorial) from a positive integer or 
      * the amount of combinations possible from a set. nShriek is an informal way of saying nFactorial.
      * 
      * @usage   trace(factorial(0)); // outputs 1
      *         trace(factorial(1000)); // outputs Infinity
      *         trace(factorial(4); // outputs 24 
      *
      * @prams   num:Number    The number to analyze.
      *
      * @return   Number      n! or the amount of combinations possible.       
      */
      static public function factorial(num:Number):Number{
         var nShriek:Number = num;
         if (num > 0) {
            while (num > 1) {
               num--;
               nShriek *= num;
            }
            return nShriek;
         } else if (!num) {
            return 1;
         }
         return 1;
      }
      
      
      /**
      * A function for approximating the derivative of a function at a point.
      * 
      * @usage   function f(x):Number {
      *            return Math.pow(x, 2);
      *         }
      *         trace(numDerive(f, 3)); //6.00000100092757
      *         trace(numDerive(f, 0)); //1e-6 
      *
      * @prams   f:Function   The function to derivate.
      * @prams   x:Number   The x point of where to derivate.
      *
      * @return   Number - The derivative of f at x.
      *                  
      */
      static public function numDerive(f:Function, x:Number):Number {
         var h:Number = 0.00001;
         return (f(x + h) - f(x)) / h;
      }
      
      
      /**
      * A function for rounding a decimal number to a precision. 
      * Note that trailing zeros are not kept.
      * 
      * @usage   trace(numRoundTo(0.246, 2)); //0.25
      *         trace(numRoundTo(135, -1)); //140 
      *
      * @prams   n:Number   The number to round.
      * @prams   p:Number   The precision to round to.
      *
      * @return   Number      The rounded number n to p decimal places 
      *                  
      */
      static public function numRoundTo(n:Number, p:Number):Number {
         return Math.round(Math.pow(10, p) * n) / Math.pow(10, p);
      }
      
      
      /**
      * addCommas(number:Number) : String
      *   Converts the parameter to a string and formats 
      *    the number value correctly with decmals where necessary.
      * 
      * @usage   var comma_num:String = addCommas(33222111);
      *         trace(comma_num); // Outputs 33,222,111 
      *   
      * @prams   number:Number   The number to convert into a string and insert all the commas.
      *                     The function does not directly modify any variables.
      *
      * @return   String         The orginal number value, but with all necessary commas.               
      */
      static public function addCommas(number:Number):String {
         var num:String = String(number);
         if (num.length>3) {
            var mod:Number = num.length%3;
            var output:String = num.substr(0, mod);
            for (var i:Number = mod; i<num.length; i += 3) {
               output += ((mod == 0 && i == 0) ? "" : ",")+num.substr(i, 3);
            }
            return output;
         }
         return num;
      }
      
      
      /**
      * ordinalise(number:Number) : String
      * Reads the number parameter and converts it into an ordinalised String (ie: 1st, 2nd, 3rd.. 13th, etc..).
      * 
      * @usage   trace(ordinalise(21));// Outputs 21st
      *         trace(ordinalise(102));// Outputs 102nd
      *         trace(ordinalise(33));// Outputs 33rd
      *         trace(ordinalise(13));// Outputs 13th
      *         trace(ordinalise(11));// Outputs 102th
      *         trace(ordinalise(112));// Outputs 112th
      *         trace(ordinalise(1));// Outputs 1st 
      *         
      * @prams   number:Number   The numberthat you want to be ordinalised. The function does not directly modify any variables.
      *
      * @return   String         A String value, the ordinalised value of number.                
      */
      static public function ordinalise(number:Number):String {
          var tmp:String = String(number);
         var end:String;
          if (tmp.substr(-2, 2) != "13" && tmp.substr(-2, 2) != "12" && tmp.substr(-2, 2) != "11") {
              if (tmp.substr(-1, 1) == "1") {
                  end = "st";
              } else if (tmp.substr(-1, 1) == "2") {
                  end = "nd";
              } else if (tmp.substr(-1, 1) == "3") {
                  end = "rd";
              }
          }
          if (!end) {
              end = "th";
          }
          return tmp+end;
      }

      /**
      * distanceBetween : Number
      * Calculates the real distance between 2 points.
      * 
      * @usage   
      *         
      * @prams   x1 : Number      The x of the first point.
      * @prams   y1 : Number      The y of the first point.
      * @prams   x2 : Number      The x of the second point.
      * @prams   y2 : Number    The y of the second point.
      *
      * @return   Number         pixel distance between the two objects                  
      */
      static public function distanceBetween(x1:Number, y1:Number, x2:Number, y2:Number):Number {
         var xx:Number = x2-x1;
         var yy:Number = y2-y1;
         return Math.abs(Math.sqrt((xx*xx)+(yy*yy)));
      }
      public function NumberUtil(){
         //nothing here...
      }
   }
}