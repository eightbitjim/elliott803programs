     * 
     * Reads the contents of tape punch 2 and outputs to the teletype.
     * Skips initial blank space and then terminates on the next blank
     *
              @entry               * Define the entry address
       
     begin:                                                 
     loop:   22 index / 30 message   * Get next character 
             42 end   : 40 write   * Check for zero at end of string or write char 
     write:  20 char  / 74 4096    * Write character to teletype
             40 loop               * Loop back to next character  
     end:    74 4125  : 74 4126    * Write CR and LF to finish line   
     
     taperead:
              * First skip the leading zeros
              06 0    : 26 char    * acc := 0 , char := 0
     skip:    71 2048 : 42 skip    * acc |= tape2, if acc = 0 goto skip
     loop2:    20 char / 74 4096    * char := acc, punch(char + 4096)
              06 0    : 71 2048    * acc := 0 , acc |= tape2
              42 tapeend : 40 loop2 * if acc = 0 goto tapeend , goto loop
              
     tapeend:
      
     done:   72 8191               * Exit when finished     
     
     entry:  30 m1    : 20 index   * Program entry point
             40 begin              * Initialize 'index' and begin output     
              
     char:   0                     * Character workspace
     index:  0                     * Index into string 
     message: 'Content of tape punch 2...'
             0                     * Zero marks end of string 
     m1:    -1, 2, +4              * A few constant values (not all used!) 
     