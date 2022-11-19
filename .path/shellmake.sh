#!/bin/bash


outputfile=""
elffile=""
x32=false
optionoutput=false
copy=false
copyfile=""
showdisassembly=false
runelf=false
keepelf=false
testshellcode=false
standarddisplay=true


inputfile=$1
strace=""

shift 1

while getopts "xsdc:rtk:o:" option
do
	case $option in 
		x)
			x32=true
			;;
		s)
			strace="strace "
			;;
		c)
			copy=true
			standarddisplay=false
			copyfile=$OPTARG
			;;
		d)
			showdisassembly=true
			;;
		r)
			runelf=true
			;;
		t)
			testshellcode=true
			;;
		k)
			keepelf=true
			elffile=$OPTARG
			;;
		o)
			optionoutput=true
			outputfile=$OPTARG
			;;
	esac
done


# compile

if [ "$x32" = true ]; then
    nasm -f elf32 $inputfile -o shellmake_tmp.o 
    ld shellmake_tmp.o -o shellmake_tmp -m elf_i386
else
    nasm -f elf64 $inputfile -o shellmake_tmp.o 
    ld shellmake_tmp.o -o shellmake_tmp
fi
# shellcode=$(objdump -d shellmake_tmp | grep '[0-9a-f]:'|grep -v 'file'|cut -f2 -d:|cut -f1-6 -d' '|tr -s ' '|tr '\t' ' '|sed 's/ $//g'|sed 's/ /\\\\x/g'|paste -d '' -s |sed 's/^/\"/'|sed 's/$/\"/g' | sed 's/\\\\/\\/g')

GREEN='\033[1;32m'
RED='\033[1;31m'
YELLOW='\033[1;33m'
NC='\033[0m'
#SHELLCODE=$(objdump -d shellmake_tmp | grep '[0-9a-f]:'|grep -v 'file'|cut -f2 -d:|cut -f1-6 -d' '|tr -s ' '|tr '\t' ' '|sed 's/ $//g'|sed 's/ /\\\\x/g'|paste -d '' -s |sed 's/^/\"/'|sed 's/$/\"/g' | sed 's/\\\\/\\/g')
RAWSC=$(for i in `objdump -d shellmake_tmp	| tr '\t' ' ' | tr ' ' '\n' | egrep '^[0-9a-f]{2}$' ` ; do echo -n "\\x$i" ; done)
SHELLCODE="\"$RAWSC\""

if [[ $SHELLCODE =~ ^\"(\\x[0-9a-fA-F]{2})+\"$ ]]; then
  if [[ $SHELLCODE == *"x00"* ]]; then
    echo -e "${YELLOW}WARNING:${NC} shellcode contain null byte."
  fi
else
  echo -e "${RED}ERROR:${NC} Bad shellcode format"
fi

if [ "$standarddisplay" = true ];then
	echo -e "Shellcode lenght: ${GREEN}$(awk -F"x" '{print NF-1}' <<< "${SHELLCODE}")${NC}" 
	echo "$RAWSC"
fi

if [ "$optionoutput" = true ]; then
	echo -e $RAWSC > $outputfile
fi

if [ "$copy" = true ]; then
	echo "echo -e $SHELLCODE | $strace./$copyfile"
fi

if [ "$showdisassembly" = true ]; then
	objdump -d shellmake_tmp
fi

if [ "$runelf" = true ]; then
	$strace./shellmake_tmp
fi

if [ "$keepelf" = true ]; then
	cp shellmake_tmp $elffile
fi

if [ "$testshellcode" = true ]; then
	echo "#include <stdio.h>" > shellmake_tmp_c.c 
	echo "int main(int argc, char **argv) {" >> shellmake_tmp_c.c
	echo "unsigned char code[] = $SHELLCODE;" >> shellmake_tmp_c.c
	echo "int foo_value = 0;" >> shellmake_tmp_c.c
	echo "int (*foo)() = (int(*)())code;" >> shellmake_tmp_c.c
	echo "foo_value = foo();" >> shellmake_tmp_c.c
	echo "printf(\"%d\n\", foo_value);" >> shellmake_tmp_c.c
	echo "}" >> shellmake_tmp_c.c

	gcc -g -Wall -fno-stack-protector -z execstack shellmake_tmp_c.c -o shellmake_tmp_c
	$strace./shellmake_tmp_c
	#rm shellmake_tmp_c
	#rm shellmake_tmp_c.c
fi

# clean

rm shellmake_tmp
rm shellmake_tmp.o

exit 0

