#!/bin/bash

clear
numero=0

echo "Criando 10 usuários seguindo o padrão campolim-numero..."
echo

for ((i=1; i<=10; i++))
do
    nome_usuario="campolim-$numero"
    echo "Criando usuário: $nome_usuario"
    sudo useradd -m $nome_usuario
    ((numero++))
done

echo
echo "Deletando 9 usuários dos 10 criados..."
echo

numero=0
for ((i=1; i<=9; i++))
do
    nome_usuario="campolim-$numero"
    echo "Deletando usuário: $nome_usuario"
    sudo userdel -r $nome_usuario
    ((numero++))
done

echo
echo "Conectando no último usuário criado..."

nome_usuario="campolim-9"
echo "Usuário conectado: $nome_usuario"
sudo su $nome_usuario &

echo
echo "Criando 35 pastas na home do último usuário criado com nomes aleatórios..."
echo

cd ~
for ((i=0; i<35; i++))
do
    mkdir -v pasta$i
    # Tentando limpar buffer de saída da verbose do mkdir.
    # echo -e '\r'
done

echo
echo "Removendo 33 pastas criadas e seu respectivo conteúdo..."
echo

for ((i=0; i<33; i++))
do
    rm -rfv pasta$i
done

echo
echo "Acessando a pasta 34 e criando 10 arquivos do tipo pdf e 10 arquivos do tipo txt..."
echo

cd pasta34 || exit
for ((i=1; i<=10; i++))
do
    echo -e "Criando arquivo: arquivo$i.pdf"
    touch arquivo$i.pdf
    echo -e "Criando arquivo: arquivo$i.txt"
    touch arquivo$i.txt
done

echo
echo "Acessando a pasta 35 e copiando tudo que está na pasta 34..."
echo

cd ..
cp -rv pasta34 pasta35

echo
echo "Removendo a pasta 34..."
echo

rm -rfv pasta34

echo
echo "Alterando o dono da pasta 35 para o usuário que conectou no início..."
echo

echo "Proprietário antes:"
ls -ld pasta35
echo

sudo chown -R $nome_usuario pasta35

echo "Proprietário depois:"
ls -ld pasta35
echo

echo "Ações concluídas."
