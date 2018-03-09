set PATH=F:\Tradvctores\Dev-C++ Portable\Dev-C++ Portable\MinGW32\bin
win_bison -d calc.y
win_flex calc.l
gcc lex.yy.c calc.tab.c -o MasssNahh.exe
MasssNahh.exe


