#!/bin/bash

FILENAME=$1
EXT=${FILENAME##*.}
COM=""
CODE=""

com_name="@filename $FILENAME"
com_date="@date $(date)"
com_auth="@author $USER"

c_com="//"
py_com="#"
tex_com="%%"
sh_com="#"
asm_com=";"

bslash="\\"
tab='	'

comstring() {
    COM="$1\n$1 $com_name\n$1 $com_date\n$1 $com_auth\n$1\n\n"
}

if [ -e $FILENAME ];then
    echo Ce fichier existe déja
    exit 
fi

if [ "$EXT" = "c" ];then
    comstring $c_com
    CODE="#include <stdio.h>\n#include <stdlib.h>\n\nint main(int argc, char *argv[]) {\n\t\n\treturn 0;\n}"
fi

if [ "$EXT" = "py" ];then
    comstring $py_com
    CODE="def main():\n\t\n\nif __name__ == '__main__':\n\tmain()\n"
fi

if [ "$EXT" = "tex" ];then
    comstring $tex_com
    CODE="\\documentclass[a4paper, draft]{article}\n\\usepackage[utf8]{inputenc}\n\\usepackage[french]{babel} \n\n% Figures\n\\usepackage{graphicx}\n\\graphicspath{{./img/}}\n\n% Math\n\\usepackage{amsmath, amssymb}\n\\\newtheorem{defi}{Définition}\n\n% Algortihmes\n\\usepackage[vlined,lined,linesnumbered,boxed,french]{algorithm2e}\n\\DeclareMathOperator*{\\\argmin}{argmin}\n\\DeclareMathOperator{\myfunc}{myfunc}\n\\DeclareMathOperator*{\sign}{sign}\n\\DeclareMathOperator*{\imwh}{width}\n\\DeclareMathOperator*{\imht}{height}\n\n% Extra\n\\usepackage[left=3cm,right=3cm,top=2cm,bottom=2cm]{geometry}\n\\usepackage{url}\n\n\n\\\begin{document}\n\n\n\n\\\end{document}"

fi

if [ "$EXT" = "sh" ];then
    comstring $sh_com
    CODE="CMD=\$( basename \$0 )\nnbminparams=1\n\nusage()\n{\n\techo \"Usage: \$CMD ...\"\n}\n\nif [ \$# -lt \$nbminparams ];then\n\tusage\n\texit 1\nfi"
fi

if [ "$EXT" = "asm" ];then
    comstring $asm_com
    CODE="section .text\n\nglobal _start\n\nstart:\n\t"
fi

echo -e $COM$CODE > $FILENAME
vim $FILENAME
read -p "si vous ne voulez pas enregister, tapez Q : " answer

if [ "$answer" = "Q" ];then
    rm $FILENAME
fi
