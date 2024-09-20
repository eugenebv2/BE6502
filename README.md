Clone from: https://github.com/tebl/BE6502-Build-a-65c02-computer

BE6502 監督程式用 Ben Eater 分享的 msbasic + bios + wozmon 

8000 R 可進入 MS BASIC 
<hr>
Using BE6502 board testing 6502 assembler.

編譯程式 vasm

vasm.sh 檔案批次內容

  var=$1<br/>
  rm $1.bin<br/>
  vasm -Fbin -dotdir -o $var.bin $var.asm<br/>
  hexdump $var.bin<br/>
  hexdump -e '"1%03_ax:" 16/1 "%02X " "\n"' $var.bin | awk '{print toupper($0)}'<br/>

配合 hexdump 轉換位址在 1000: 開始，複製貼上到 wozmon 輸入 1000 R 後執行

<hr>

![alt text][def1]

[def1]: images/IMG_4448.jpg

![alt text][def2]

[def2]: images/IMG_4449.jpg

![alt text][def3]

[def3]: images/IMG_4450.jpg


