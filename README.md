Using BE6502 board testing 6502 assembler.

BE6502 監督程式用 Ben Eater 分享的 wozmon 

編譯程式 vasm

vasm.sh 檔案批次內容

  var=$1
  rm $1.bin
  vasm -Fbin -dotdir -o $var.bin $var.asm
  hexdump $var.bin
  hexdump -e '"1%03_ax: " 16/1 "%02X " "\n"' $var.bin | awk '{print toupper($0)}'

配合 hexdump 轉換位址在 1000: 開始，複製貼上到 wozmon 後執行
