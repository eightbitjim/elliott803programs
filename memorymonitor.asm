     * Copyeight 2019 James Lean
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

     * 1. load in from tape using initial instructions 40 0 : 0 0
     * 2. hit reset
     * 3. switch to "read", and set instruction 40 32 : 0 0
     * 4. hit "operate"
     * 5. switch to "normal"
     * 6. hit "operate"
     * 7. sit back and enjoy the clicking noises

     =32                   * Load the program into low memory

     begin:

     memtest:
             * Start memory testing
             06 linecounter
             30 start : 20 mempos     * mempos := start
             30 size : 20 index              * set counter size

     wordloop:
             * for each word, store the test word into it
             30 testword              * acc := testword

             * increase the write pointer and store the test word
             22 mempos / 20 0      * ++mempos / *mempos := acc

             * is this the start of a new line? yes if the line counter
             * is zero
             30 linecounter : 42 donewline
             05 one : 20 linecounter  * linecounter := linecounter - 1

    donenewline:
             * read back again. note, there may be a parity error here
             * TODO: what happens? does it just stop and you can continue?
             30 mempos / 30 0      * acc := mempos / acc := *mempos

             * 01 00 * negate accumulator to induce error

             * did what we read back match what we wrote?
             05 testword : 42 correct   * if acc == testword goto correct

             * faulty word. print  '-'
             30 one / 30 badchar
             20 char  / 74 4096    * Write character to teletype
             40 gotresult             * goto result

     correct:
             * good word. print  '.'
             30 one / 30 goodchar
             20 char  / 74 4096    * Write character to teletype

     gotresult:
             * have we reached the end?
             30 index : 05 one            * acc := index - 1
             20 index : 42 finished      * index := acc, if !acc goto finished
             40 wordloop                 * goto wordloop

     donewline:
             * print a new line
             30 zero / 30 newline
             20 char / 74 4096
             30 zero / 30 newline2
             20 char / 74 4096

            * print the address
            * first the number shift
             30 zero / 30 numberstring
             20 char / 74 4096

             * now the numbers
             30 address3 / 30 numberstring
             20 char / 74 4096
             30 address2 / 30 numberstring
             20 char / 74 4096
             30 address1 / 30 numberstring
             20 char / 74 4096
             30 address0 / 30 numberstring
             20 char / 74 4096

             * space
             30 zero / 30 space
             20 char / 74 4096

             * set the line counter
             30 linewidth : 20 linecounter * linecounter := linewidth

             * increase the numbers for next time
             30 address1 : 04 five
             20 address1 : 05 eleven
             41 donenewline : 20 address1  * if address1<10 goto donenewline else address1-=10
             22 address1
inc2:
             22 address2 : 30 address2
             05 eleven
             42 inc3 : 40 donenewline
inc3:
             30 one : 20 address2
             22 address3 : 30 address3
             40 donenewline

finished:
             * done
             40 finished

    *************************************************************

     char:   0                     * Character workspace
     index:  0                     * Index into string

     numberstring: '0123456789' * Used for printing out addresses
     address0: 7
     address1: 10
     address2: 1
     address3: 5

     start:    4095                * The first word to be tested - 1
     size:     4096                    * Number of words to test
     zero:   0
     one:    1
     two:    2
     five:   5
     ten:    10
     eleven:    11
     mempos: 0                     * Current position in memory
     testword: 60 *1099511627775   * First word to write to memory. 2^40-1
     startlocation: 4095           * The first word of this program, stored at the beginning
     mask:   8191                  * Mask for address
     linewidth: 50                * mask for bottom 6 bits
     linecounter: 0
     link:   0                     * address to return to
     goodchar: '.'
     badchar:  '-'
     newline: 29
     newline2: 30
     space: 28
