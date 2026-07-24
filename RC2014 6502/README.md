Change the pcb sch to RC2014 6502 compatible. 

And change the VIA 6522 I/O address to $8000, enable ping from 65C51 board ping 37

The 65C51 I/O address change the pic sch to get $8400

6502 Monitor RC2014 v0.2.2
?           Print this help
D XXXX      Dump memory from XXXX
E XXXX      Edit memory from XXXX
G XXXX      Go execute from XXXX
U           Upload Intel HEX file
            ESC to quit when upload is done
115200 bps 

RUN Ehbasic   >G C100 


![alt text][def1]

[def1]: images/IMG_5690.jpg

![alt text][def2]

[def2]: images/IMG_5691.jpg
