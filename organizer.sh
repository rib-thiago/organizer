#!/usr/bin/env bash
# ---------------------------------------------------------------
# Script    : organizer.sh
# Descrição : Organiza arquivos de um diretório segundo sua extensão.
# Autor     : Thiago Ribeiro <thiago.bernardes@aluno.ifsp.edu.br>
# Data      : 02/06/22
# Licença   : 
# ---------------------------------------------------------------
# Uso: ./organizer.sh <diretórios> 
# ---------------------------------------------------------------
# Versão 0.1: Primeira versão do script

msg1="Não é um diretório"

arquivo="$1"

corrigirNomes () {

find "$arquivo" -type f -iname "* *" -exec bash -c 'mv "$0" "${0// /_}"' {} \;

}


criarDiretorios () {

[ -d audios ] || mkdir "$1"/audios 
[ -d videos ] || mkdir "$1"/videos 
[ -d documentos ] || mkdir "$1"/documentos 
[ -d imagens ] || mkdir "$1"/imagens 
[ -d compactados ] || mkdir "$1"/compactados 
[ -d scripts ] || mkdir "$1"/scripts 

}

distribuirArquivos (){

vetor_arquivos=($(find $arquivo -type f))
vetor_diretorio=($(find $arquivo -type d))
lenght=${#vetor_arquivos[*]}

for ((i=0; i<lenght; i++)); do

#extrai a extensão dos arquivos
aux=${vetor_arquivos[i]}
# todo o início da string será aparado até
# a última ocorrência do padrão
ext=${aux##*.}

case "$ext" in
      ogg | mp3) mv "$aux" "$1"/audios ;;
                     mp4) mv "$aux" "$1"/videos  ;;
png | jpeg | jpg |  webp) mv "$aux" "$1"/imagens  ;;
xlsx | doc | pdf | odt | docx) mv "$aux" "$1"/documentos  ;;
kml | kmz | sql| py | sh) mv "$aux" "$1"/scripts/ ;;
               zip | tar) mv "$aux" "$1"/compactados ;;
esac
done

}




[ -d $arquivo ] && corrigirNomes $arquivo || echo $msg1
criarDiretorios $arquivo 2> /dev/null
distribuirArquivos $arquivo 2> /dev/null

read -p "Pressione enter para encerrar"
exit
