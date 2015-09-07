     * 
     * Tests the full 8k of memory apart from the memory occupied by this program
     *
              @entry               * Define the entry address
          
     begin:            
             26 index                                     
     loop:   22 index / 30 message * Get next character 
             42 end   : 40 write   * Check for zero at end of string or write char 
     write:  20 char  / 74 4096    * Write character to teletype
             40 loop               * Loop back to next character  
     end:     
               
             * Start memory testing
             30 m1 : 20 mempos     * mempos := m1                      
     blockloop:                      
             * Start new block
             26 wordsdoneinblock    * wordsdoneinblock := 0
             30 testwordtouse : 05 testword1 * acc := testwordtouse - testword1
             42 useword2 : 40 useword1 * if acc := 0 goto useword2, goto useword1
     useword2:
             30 testword2 : 20 testwordtouse
             40 wordloop
     useword1:
             30 testword1 : 20 testwordtouse
             40 wordloop        
     wordloop:
             30 testwordtouse          * acc := testwordtouse
             22 mempos / 20 0      * mempos++ / *mempos := acc
             06 00                 * acc := 0
             30 mempos / 30 0        * acc := mempos / acc := *mempos
             05 testwordtouse : 42 correct
             40 printerror         * there was a problem. Print the error
     correct:
             30 startlocation : 05 mempos  * acc := startlocation - mempos
             42 finished : 22 wordsdoneinblock  * if acc = 0 goto finshed, wordsdoneinblock++
             30 wordsdoneinblock : 05 blocksize * acc := wordsdoneinblock - blocksize
             42 blockloop : 40 wordloop * if acc = 0 goto blockloop, goto wordloop
         
     finished:
             26 index              * index := 0
     loop2:   22 index / 30 endmsg * Get next character 
             42 end2   : 40 write2   * Check for zero at end of string or write char 
     write2:  20 char  / 74 4096    * Write character to teletype
             40 loop2               * Loop back to next character  
     end2:    74 4125  : 74 4126    * Write CR and LF to finish line   
             40 done               * exit program             
     
     printerror:
             26 index              * index := 0
     loop3:   22 index / 30 errmsg * Get next character 
             42 end3   : 40 write3   * Check for zero at end of string or write char 
     write3:  20 char  / 74 4096    * Write character to teletype
             40 loop3               * Loop back to next character  
     end3:    74 4125  : 74 4126    * Write CR and LF to finish line   
             40 done               * exit program           
             
     entry:  
             40 begin              * goto begin
              
     done:   72 8191               * Exit when finished     

    *************************************************************
     char:   0                     * Character workspace
     index:  0                     * Index into string
     message: 'Testing 0 to 4095... '
             0                     * Zero marks end of string 
     endmsg: 'Success'
             0                     * Zero marks end of string 
     errmsg: 'Error'
             0                     * Zero marks end of string 
     m1:    2                      * The first word to be tested - 1
     zero:   0
     mempos: 0                     * Current position in memory
     testword1: 65535              * First word to write to memory
     testword2:  -1                * Second word to write to memory
     testwordtouse: 0
     blocksize: 512                * Size in words to test before printing output
     wordsdoneinblock: 0           * Number of words left in the current block
     startlocation: 4095              * The first word of this program, stored at the beginning
     