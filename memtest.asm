     * Copyeight 2017 James Lean
     *
     * This program is free software: you can redistribute it and/or modify
     * it under the terms of the GNU General Public License as published by
     * the Free Software Foundation, either version 3 of the License, or
     * (at your option) any later version.

     * This program is distributed in the hope that it will be useful,
     * but WITHOUT ANY WARRANTY; without even the implied warranty of
     * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
     * GNU General Public License for more details.

     * You should have received a copy of the GNU General Public License
     * along with this program.  If not, see <http://www.gnu.org/licenses/>.
     
     * 
     * Tests the full 8k of memory apart from the memory occupied by this program
     * Writes all 1's on first pass, then all 0's on second pass, checking that the
     * write was apparently successful. Not the most rigourous test, but it only takes
     * two minutes to run.
     *
     * Run from tape using initial instructions 40 0
     *
     
              @entry               * Define the entry address
          
     begin:            
             73 m2 : 30 mask       * Store address of this instruction to mark as the end of memory to test
             23 m2 : 26 index      * Mask to keep bottom bits for comparison later
                                            
     loop:   22 index / 30 message * Get next character 
             42 end   : 40 write   * Check for zero at end of string or write char 
     write:  20 char  / 74 4096    * Write character to teletype
             40 loop               * Loop back to next character  
     end:     
         
     memtest:      
             * Start memory testing
             30 m1 : 20 mempos     * mempos := m1                      
     wordloop:
             ** Test using first test byte
             30 testword           * acc := testword1
             22 mempos / 20 0      * ++mempos / *mempos := acc
             06 00                 * acc := 0
             30 mempos / 30 0      * acc := mempos / acc := *mempos
             05 testword : 42 correct
             40 printerror         * there was a problem. Print the error
     correct:
             30 m2 : 05 mempos           * acc := m2 - mempos
             42 finished : 40 wordloop   * if acc = 0 goto finshed, wordsdoneinblock++
         
     finished:
             ** If this was the first pass, switch to the second test word and run again, testing the
             ** opposite bits to last time
             22 passes : 30 passes       * acc := ++passes
             05 totalpasses : 42 exit    * if acc := 2 goto exit
             30 testword2 : 20 testword  * testword := testword2
             40 memtest                  * goto memtest
     
     exit:
             ** Print success and then exit
             26 index                    * index := 0
     loop2:   22 index / 30 endmsg       * Get next character 
             42 end2   : 40 write2       * Check for zero at end of string or write char 
     write2:  20 char  / 74 4096         * Write character to teletype
             40 loop2                    * Loop back to next character  
     end2:    74 4125  : 74 4126         * Write CR and LF to finish line   
             40 done                     * exit program             
     
     printerror:
             26 index                    * index := 0
     loop3:   22 index / 30 errmsg       * Get next character 
             42 end3   : 40 write3       * Check for zero at end of string or write char 
     write3:  20 char  / 74 4096         * Write character to teletype
             40 loop3                    * Loop back to next character  
     end3:    74 4125  : 74 4126         * Write CR and LF to finish line   
             40 done                     * exit program           
             
     entry:  
             26 passes: 40 begin         * passes := 0, goto begin
              
     done:   40 done                     * Spin loop

    *************************************************************
    
     char:   0                     * Character workspace
     index:  0                     * Index into string
     message: 'Testing '
             0                     * Zero marks end of string 
     endmsg: 'Success'
             0                     * Zero marks end of string 
     errmsg: 'Error'
             0                     * Zero marks end of string 
     m1:     3                     * The first word to be tested - 1
     m2:     0                     * The last word to be tested, determined at runtime
     zero:   0
     mempos: 0                     * Current position in memory
     testword: 1099511627775       * First word to write to memory. 2^40-1
     testword2: 0                  * Word to write on second pass
     startlocation: 4095           * The first word of this program, stored at the beginning
     passes:  0                    * Number of passes completed
     totalpasses: 2                * Total number of passes we want
     mask:   8191                  * Mask for address
