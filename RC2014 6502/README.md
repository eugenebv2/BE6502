Change the pcb sch to RC2014 6502 compatible. <BR/>
And change the VIA 6522 I/O address to $8000, enable pin from 65C51 board TO rc2014 bus pin 37<BR/>
The ACIA 65C51 I/O address change the pic sch to get $8400<BR/>

6502 Monitor RC2014 v0.2.2<BR/>
?           Print this help<BR/>
D XXXX      Dump memory from XXXX<BR/>
E XXXX      Edit memory from XXXX<BR/>
G XXXX      Go execute from XXXX<BR/>
U           Upload Intel HEX file<BR/>
            ESC to quit when upload is done<BR/>
115200 bps <BR/>

RUN Ehbasic<BR/>   >G C100 

![alt text][def1]

[def1]: images/IMG_5690.jpg

![alt text][def2]

[def2]: images/IMG_5691.jpg
