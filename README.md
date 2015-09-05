# elliott803
Programs for the Elliott803B computer with 8K of RAM.

Compile on the Elliott 803 Algol-60 compiler to run on an 8K Elliott 803. Currently there are two programs:

1. <b>Hello:</b> a simple hello world program
2. <b>Quest:</b> an algorithmically generated adventure game written in ALGOL-60

Files are as follows:

<b>/*.algol : </b>Source code in ALGOL-60. Text file not in Elliott telecode format, and contains characters not in the Elliott character set. Requires conversion before using on a real Elliott computer.

<b>tapes/*.algol.tap : </b>Source code in ALGOL-60 stored as a tape file suitable for input to an Elliott computer. Only the bottom 5 bits of each byte are used, and these correspond to the bits on a 5 punch paper tape. Files in Elliott telecode format with shifts as neccessary.

<b>tapes/*.bootable.tap : </b>A compiled program stored as a tape file suitable for input to an Elliott computer. Only the bottom 5 bits of each byte are used. The program can be loaded from initial instructions (40 0) without the need for the Algol compiler to have been loaded. Once loaded, flip the left-most bit on function 2 on the console to run the program.


