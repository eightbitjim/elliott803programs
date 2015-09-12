# elliott803
Programs for the Elliott 803B computer with 8K of RAM, freely available to anyone with one of these computers. Oh, hang on, there's only one working Elliott 803B left in existence. It's at the National Museum Of Computing at Bletchley Park, UK. Well, if anyone else finds one of these computers, here are some new programs.

Sources are either in ALGOL-60 or assembler. The tape files are pre-compiled and can be loaded straight in using the "initial instructions", which are a few words of ROM at the start of memory. Run by switching the computer on and entering "40 0" on the control panel.

Currently there are the following programs:

1. <b>Hello:</b> a simple hello world program. Source in ALGOL-60
2. <b>Quest:</b> an algorithmically generated adventure game written in ALGOL-60
3. <b>Typetape:</b> a simple program that reads a file from punch tape reader 1 and types the result to the teletype. Source in assembler.
4. <b>Memtest:</b> a not-very-rigorous memory tester, which tests all of the memory except that used to run the program. Source in assembler.

Files are as follows:

<b>/*.algol : </b>Source code in ALGOL-60. Text file not in Elliott telecode format, and contains characters not in the Elliott character set. Requires conversion before using on a real Elliott computer.

<b>/*.asm : </b>Source code in assembler. There was no assembler for the original Elliott computer. This source can be compiled using the assembler included with this simulator: http://elliott803.sourceforge.net

<b>tapes/*.algol.tap : </b>Source code in ALGOL-60 stored as a tape file suitable for input to an Elliott computer. Only the bottom 5 bits of each byte are used, and these correspond to the bits on a 5 punch paper tape. Files in Elliott telecode format with shifts as neccessary.

<b>tapes/*.bootable.tap : </b>A compiled program stored as a tape file suitable for input to an Elliott computer. Only the bottom 5 bits of each byte are used. The program can be loaded from initial instructions (40 0) without the need for the Algol compiler to have been loaded. Once loaded, flip the left-most bit on function 2 on the console to run the program.


