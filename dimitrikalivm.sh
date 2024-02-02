wget -O ng.sh https://raw.githubusercontent.com/dimitriprojetos/dimitrikalivm/main/ngrok.sh > /dev/null 2>&1
chmod +x ng.sh
./ng.sh


function goto
{
    label=$1
    cd 
    cmd=$(sed -n "/^:[[:blank:]][[:blank:]]*${label}/{:a;n;p;ba};" $0 | 
          grep -v ':$')
    eval "$cmd"
    exit
}


: ngrok
clear
echo "Kali - Acesso Remoto (VM)"
echo "By Dimitri"
echo "Acesse o Ngrok para obter o token de autenticação."
read -p "Insira o token de autenticação: " CRP
./ngrok authtoken $CRP 

clear
echo "Escolha a região do Ngrok:"
echo "___________________________"
echo "us - Estados Unidos"
echo "sa - Brasil"
echo "___________________________"
read -p "Sua região: " CRP
./ngrok tcp --region $CRP 4000 &>/dev/null &
sleep 1
if curl --silent --show-error http://127.0.0.1:4040/api/tunnels  > /dev/null 2>&1; then echo OK; else echo "Erro Ngrok! Tente novamente." && sleep 1 && goto ngrok; fi
docker run --rm -d --network host --privileged --name nomachine-xfce4-kali -e PASSWORD=123456 -e USER=user --cap-add=SYS_PTRACE --shm-size=1g thuonghai2711/nomachine-kali-desktop:latest
clear
echo "Kali - Acesso Remoto (VM)"
echo "By Dimitri"
echo "Acesse o NoMachine para usar a máquina."
echo "Informações - NoMachine:"
echo Endereço IP:
curl --silent --show-error http://127.0.0.1:4040/api/tunnels | sed -nE 's/.*public_url":"tcp:..([^"]*).*/\1/p' 
echo Usuário: user
echo Senha: 123456
echo "Não conseguiu acessar a máquina? Reinicie a máquina e execute novamente a script."
seq 1 43200 | while read i; do echo -en "\r Em execução .     $i s /43200 s";sleep 0.1;echo -en "\r Em execução ..    $i s /43200 s";sleep 0.1;echo -en "\r Em execução ...   $i s /43200 s";sleep 0.1;echo -en "\r Em execução ....  $i s /43200 s";sleep 0.1;echo -en "\r Em execução ..... $i s /43200 s";sleep 0.1;echo -en "\r Em execução     . $i s /43200 s";sleep 0.1;echo -en "\r Em execução  .... $i s /43200 s";sleep 0.1;echo -en "\r Em execução   ... $i s /43200 s";sleep 0.1;echo -en "\r Em execução    .. $i s /43200 s";sleep 0.1;echo -en "\r Em execução     . $i s /43200 s";sleep 0.1; done
