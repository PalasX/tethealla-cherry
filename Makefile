CC=gcc
CFLAGS=-I. -L/usr/lib/mysql -lmysqlclient -march=native -O3

%.o: %.c
	$(CC) -c -o $@ $< $(CFLAGS)
all: clean account_add char_export convert_quest convert_unitxt login_server make_key newtable patch_server ship_server
clean:
	rm -f src/*/*.o
md5: src/md5/md5.o
prs: src/prs/prs.o
account_add: md5
	$(CC) -o bin/account_add src/md5/md5.o src/account_add/account_add.c $(CFLAGS)
char_export:
	$(CC) -o bin/char_export src/char_export/char_export.c $(CFLAGS)
convert_quest:
	$(CC) -o bin/convert_quest src/convert_quest/convert_quest.c $(CFLAGS)
convert_unitxt: prs
	$(CC) -o bin/convert_unitxt src/prs/prs.o src/convert_unitxt/convert_unitxt.c $(CFLAGS)
login_server: prs md5
	$(CC) -o bin/login_server src/md5/md5.o src/prs/prs.o src/login_server/login_server.c $(CFLAGS)
make_key:
	$(CC) -o bin/make_key src/make_key/make_key.c $(CFLAGS)
newtable:
	$(CC) -o bin/newtable src/newtable/newtable.c $(CFLAGS)
patch_server:
	$(CC) -o bin/patch_server src/patch_server/patch_server.c $(CFLAGS)
ship_server: prs md5
	$(CC) -o bin/ship_server src/prs/prs.o src/md5/md5.o src/ship_server/ship_server.c $(CFLAGS)