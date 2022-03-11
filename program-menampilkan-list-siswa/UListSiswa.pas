program ListSiswa;
uses crt,sysutils;
const
     maks=1000;
     namafile='ListSiswa.TXT';
type
    TSiswa=record
                 nis:string[8];
                 nama:string[20];
                 jurusanPilihan:string[20];
                 tahunLulus:integer;
                 keterangan:string;
            end;
    TSiswaList=array[1..Maks] of TSiswa;
var
   siswa:TSiswaList;
   banyakData:integer;
   pilihanMenu:byte;

// tambah data
procedure tambahData;
var
   dicari:string;
   i:integer;
begin
     clrscr;
     if banyakData<Maks then
     begin
          banyakData:=banyakData+1;
          writeln('PEMASUKAN DATA KE-',banyakData);
          with siswa[banyakData] do
          begin
               writeln('------------------------');
               writeln('Sebelum melakukan penambahan data,');
               writeln('cek dahulu apakah anda sudah pernah');
               writeln('melakukan tambah data sebelumnya.');
               writeln('------------------------');

               write(' Masukan NIS Anda : ');readln(dicari);
               i:=1;
               while (siswa[i].nis<>dicari)and(i<banyakData) do
               i:=i+1;
               if siswa[i].nis=dicari then
               begin
                    writeln('======================================================');
                    writeln(' Data ditemukan di posisi ke-',i);
                    writeln('[Anda sudah pernah melakukan tambah data sebelumnya.]');
                    writeln('======================================================');
               end
               else
               begin
                    writeln('========================================================');
                    writeln('Data tidak ditemukan, silahkan lakukan penambahan data.');
                    writeln;
                    write(' NIS             : ');readln(nis);
                    write(' Nama            : ');readln(nama);
                    write(' Jurusan Pilihan : ');readln(jurusanPilihan);
                    write(' Tahun Lulus     : ');readln(tahunLulus);
                    writeln('========================================================');
                    writeln('**Penambahan Data Sukses**');
                    nama:=upcase(nama);
                    jurusanPilihan:=upcase(jurusanPilihan);
               end;

               if (tahunLulus>=2019)and(tahunLulus<=2021) then
                  keterangan:= 'SUKSES'
               else
                   keterangan:= 'GAGAL';
          end;
     end
     else
         writeln('Data telah penuh.');
     writeln;
     writeln('>> ENTER UNTUK KEMBALI KE MENU...');
     readln;
end;

// view data
procedure viewData;
var
   i:integer;
begin
     clrscr;
     gotoxy(29,1);writeln('LIST SISWA YANG MENGIKUTI SBMPTN 2021');
     gotoxy(38,2);writeln('Lulusan 2019 - 2021');
     writeln(' --------------------------------------------------------------------------------------------');
     //       123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123
     writeln(' |  NO  |    NIS   |         NAMA         |   JURUSAN  PILIHAN   | TAHUN LULUS | KETERANGAN |');
     writeln(' --------------------------------------------------------------------------------------------');
     for i:=1 to banyakData do
     begin
          writeln(' | ',i:4,'',
                  ' | ',format('%-8s',[siswa[i].nis]),'',
                  ' | ',format('%-20s',[siswa[i].nama]),'',
                  ' | ',format('%-20s',[siswa[i].jurusanPilihan]),'',
                  ' | ',siswa[i].tahunLulus:11,'',
                  ' |   ',format('%-9s',[siswa[i].keterangan]),'|');
     end;
     writeln(' --------------------------------------------------------------------------------------------');
     writeln;
     writeln('>> ENTER UNTUK KEMBALI KE MENU...');
     readln;
end;

// simpan data ke file
procedure simpanDataKeFile;
var
   f:file of TSiswa;
   i:integer;
begin
     clrscr;
     writeln('PENYIMPANAN DATA KE FILE');
     writeln('-----------------------------------------');
     assign(f,namafile);
     rewrite(f);
     for i:=1 to banyakData do
         write(f,siswa[i]);
     close(f);
     writeln(' Penyimpanan ',banyakData,' data ke file telah selesai');
     writeln;
     writeln('>> ENTER UNTUK KEMBALI KE MENU...');
     readln;
end;

// baca data dari file
procedure bacaDataDariFile;
var
   f:file of TSiswa;
begin
     clrscr;
     writeln('PEMBACAAN DATA DARI FILE');
     writeln('------------------------------------------');
     assign(f,namafile);
     {$i-}
     reset(f);
     {$i+}
     if IOResult<>0 then
        rewrite(f);

     banyakData:=0;
     while not eof(f) do
     begin
          banyakData:=banyakData+1;
          read(f,siswa[banyakData]);
     end;
     close(f);
     writeln(' Pembacaan ',banyakData,' data dari file telah selesai.');
     writeln;
     writeln('>> ENTER UNTUK KEMBALI KE MENU...');
     readln;
end;

// edit data
procedure editData;
var
   dicari:string;
   i:integer;
begin
     clrscr;
     writeln('PENGEDITAN DATA DARI FILE');
     writeln('*Masukan NIS untuk mengedit data yang diinginkan.');
     writeln('--------------------------');
     write(' Masukan NIS : ');readln(dicari);
     i:=1;
     while (siswa[i].nis<>dicari) and (i<>banyakData) do
           i:=i+1;
     if siswa[i].nis=dicari then
     begin
         writeln;
         writeln(' NIS Siswa        : ',siswa[i].nis);
         writeln(' Nama Siswa       : ',siswa[i].nama);
         writeln(' Jurusan Pilihan  : ',siswa[i].jurusanPilihan);
         writeln(' Tahun Lulus      : ',siswa[i].tahunLulus);
         writeln('--------------------------');
         write(' Edit Data NIS Siswa       : ');readln(siswa[i].nis);
         write(' Edit Data Nama Siswa      : ');readln(siswa[i].nama);
         write(' Edit Data Jurusan Pilihan : ');readln(siswa[i].jurusanPilihan);
         write(' Edit Data Tahun Lulus     : ');readln(siswa[i].tahunLulus);
         siswa[i].nama:=upcase(siswa[i].nama);
         siswa[i].jurusanPilihan:=upcase(siswa[i].jurusanPilihan);
         writeln;
         writeln('**UBAH DATA SELESAI**');
     end
     else
         writeln('DATA TIDAK DITEMUKAN');
     writeln;
     writeln('>> ENTER UNTUK KEMBALI KE MENU...');
     readln;
end;

// hapus data
procedure hapusData;
var
   dicari:string;
   i:integer;
begin
     clrscr;
     writeln('PENGHAPUSAN DATA DARI FILE');
     writeln('*Masukan NIS untuk menghapus data yang diinginkan.');
     writeln('--------------------------');
     write(' Masukan NIS : ');readln(dicari);
     i:=1;
     while (siswa[i].nis<>dicari) and (i<>banyakData) do
           i:=i+1;
     if siswa[i].nis=dicari then
     begin
         writeln;
         writeln(' NIS Siswa       : ',siswa[i].nis);
         writeln(' Nama Siswa      : ',siswa[i].nama);
         writeln(' Jurusan Pilihan : ',siswa[i].jurusanPilihan);
         writeln(' Tahun Lulus     : ',siswa[i].tahunLulus);
         writeln('--------------------------');
         banyakData:=banyakData-1;
         writeln;
         writeln('**Hapus Data Selesai**');
     end
     else
         writeln('Data tidak ditemukan');
     writeln;
     writeln('>> ENTER UNTUK KEMBALI KE MENU...');
     readln;
end;

// pencarian data
procedure pencarianNis;
var
   dicari:string;
   i:integer;
begin
     clrscr;
     writeln('PENCARIAN BERDASARKAN NIS');
     writeln('*Masukan NIS untuk mencari data yang diinginkan.');
     writeln('--------------------------');
     write(' Masukan NIS : ');readln(dicari);
     writeln;
     i:=1;
     while (siswa[i].nis<>dicari)and(i<banyakData) do
     i:=i+1;
     if siswa[i].nis=dicari then
        writeln(' Data ditemukan di posisi ke-',i)
     else
         writeln(' Data tidak ditemukan');
     writeln;
     writeln('>> ENTER UNTUK KEMBALI KE MENU...');
     readln;
end;

//pengurutan NIS
procedure pengurutanNis;
var
   i,j,indexMin:integer;
   temp:TSiswa;
begin
    for i:=1 to banyakData-1 do
    begin
         indexMin:=i;
         for j:=i+1 to banyakData do
         begin
              if siswa[j].nis<siswa[indexMin].nis then
                 indexMin:=j;
         end;
         if i<>indexMin then
         begin
              temp:=siswa[i];
              siswa[i]:=siswa[indexMin];
              siswa[indexMin]:=temp;
         end;
    end;
    writeln;
    writeln('**Pengurutan NIS Selesai**');
    writeln;
    writeln('>> ENTER UNTUK MELANJUTKAN...');
    readln;
end;

// identitas
procedure identitas;
begin
     clrscr;
     writeln('IDENTITAS PEMBUAT PROGRAM');
     writeln('---------------------------------');
     writeln(' NIM   : 10120175');
     writeln(' KELAS : IF-5');
     writeln(' NAMA  : I WAYAN WIDI PASTIKA');
     writeln;
     writeln('>> ENTER UNTUK KEMBALI KE MENU...');
     readln;
end;

// program utama
begin
     banyakData:=0;
     repeat
           clrscr;
           gotoxy(7,1);writeln('DAFTAR PILIHAN');
           writeln('--------------------------');
           writeln('[1] Penambahan Data');
           writeln('[2] Menampilkan Data');
           writeln('[3] Penyimpanan Data Ke File');
           writeln('[4] Pembacaan Data Dari File');
           writeln('[5] Pengeditan Data');
           writeln('[6] Penghapusan Data');
           writeln('[7] Pencarian Berdasarkan NIS');
           writeln('[8] Pengurutan Berdasarkan NIS');
           writeln('[9] Identitas Pembuat Program');
           writeln('[0] Keluar Dari Aplikasi');
           writeln('--------------------------');
           write('*Pilihan Anda : ');readln(pilihanMenu);
           case pilihanMenu of
            1:tambahData;
            2:viewData;
            3:simpanDataKeFile;
            4:bacaDataDariFile;
            5:editData;
            6:hapusData;
            7:pencarianNis;
            8:pengurutanNis;
            9:identitas;
           end;
     until  pilihanMenu=0;
end.
