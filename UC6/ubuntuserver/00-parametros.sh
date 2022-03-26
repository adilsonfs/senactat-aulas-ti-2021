#!/bin/bash
# Autor: Robson Vaamonde
# Site: www.procedimentosemti.com.br
# Facebook: facebook.com/ProcedimentosEmTI
# Facebook: facebook.com/BoraParaPratica
# YouTube: youtube.com/BoraParaPratica
# Linkedin: https://www.linkedin.com/in/robson-vaamonde-0b029028/
# Instagram: https://www.instagram.com/procedimentoem/?hl=pt-br
# Github: https://github.com/vaamonde
# Data de criação: 10/10/2021
# Data de atualização: 20/02/2022
# Versão: 0.49
# Testado e homologado para a versão do Ubuntu Server 20.04.x LTS x64
#
# Parâmetros (variáveis de ambiente) utilizados nos scripts de instalação dos Serviços de Rede
# no Ubuntu Server 20.04.x LTS, antes de modificar esse arquivo, veja os arquivos: BUGS, NEW e
# CHANGELOG para mais informações.
#
#=============================================================================================
#                    VARIÁVEIS GLOBAIS UTILIZADAS EM TODOS OS SCRIPTS                        #
#=============================================================================================
#
# Declarando as variáveis utilizadas na verificação e validação da versão do Ubuntu Server 
#
# Variável da Hora Inicial do Script, utilizada para calcular o tempo de execução do script
# opção do comando date: +%T (Time)
HORAINICIAL=$(date +%T)
#
# Variáveis para validar o ambiente, verificando se o usuário é "Root" e versão do "Ubuntu"
# opções do comando id: -u (user)
# opções do comando: lsb_release: -r (release), -s (short), 
USUARIO=$(id -u)
UBUNTU=$(lsb_release -rs)
#
# Variável do Caminho e Nome do arquivo de Log utilizado em todos os script
# opção da variável de ambiente $0: Nome do comando/script executado
# opção do redirecionador | (piper): Conecta a saída padrão com a entrada padrão de outro comando
# opções do comando cut: -d (delimiter), -f (fields)
LOGSCRIPT="/var/log/$(echo $0 | cut -d'/' -f2)"
#
# Exportando o recurso de Noninteractive do Debconf para não solicitar telas de configuração e
# nenhuma interação durante a instalação ou atualização do sistema via Apt ou Apt-Get. Ele 
# aceita a resposta padrão para todas as perguntas.
export DEBIAN_FRONTEND="noninteractive"
#
#=============================================================================================
#              VARIÁVEIS DE REDE DO SERVIDOR UTILIZADAS EM TODOS OS SCRIPTS                  #
#=============================================================================================
#
# Declarando as variáveis utilizadas nas configurações de Rede do Servidor Ubuntu 
#
# Variável do Usuário padrão utilizado no Servidor Ubuntu desse curso
USUARIODEFAULT="senac"
#
# Variável da Senha padrão utilizado no Servidor Ubuntu desse curso
SENHADEFAULT="123@senac"
#
# Variável do Nome (Hostname) do Servidor Ubuntu desse curso
NOMESERVER="wsSEU_NOME"
#
# Variável do Nome de Domínio do Servidor Ubuntu desse curso
# OBSERVAÇÃO IMPORTANTE: essa variável será utilizada em outras variáveis desse curso
DOMINIOSERVER="ALTERAR_PARA_O_SEU_DOMINIO.intra"
#
# Variável do Nome (Hostname) FQDN (Fully Qualified Domain Name) do Servidor Ubuntu desse curso
FQDNSERVER="$NOMESERVER.$DOMINIOSERVER"
#
# Variável do Endereço IPv4 principal (padrão) do Servidor Ubuntu desse curso
IPV4SERVER="172.16.??.20"
#
# Variável do Nome da Interface Lógica do Servidor Ubuntu Server desse curso
INTERFACE="enp0s3"
#
# Variável do arquivo de configuração da Placa de Rede do Netplan do Servidor Ubuntu
# CUIDADO!!! o nome do arquivo de configuração da placa de rede pode mudar dependendo da 
# versão do Ubuntu Server, verificar o conteúdo do diretório: /etc/netplan para saber o nome 
# do arquivo de configuração do Netplan e mudar a variável NETPLAN com o nome correspondente.
NETPLAN="/etc/netplan/00-installer-config.yaml"
#
#=============================================================================================
#                        VARIÁVEIS UTILIZADAS NO SCRIPT: 01-openssh.sh                       #
#=============================================================================================
#
# Arquivos de configuração (conf) do Serviço de Rede OpenSSH utilizados nesse script
# 01. /etc/netplan/00-installer-config.yaml = arquivo de configuração da placa de rede
# 02. /etc/hostname = arquivo de configuração do Nome FQDN do Servidor
# 03. /etc/hosts = arquivo de configuração da pesquisa estática para nomes de host local
# 04. /etc/nsswitch.conf = arquivo de configuração do switch de serviço de nomes de serviço
# 05. /etc/ssh/sshd_config = arquivo de configuração do Servidor OpenSSH
# 06. /etc/hosts.allow = arquivo de configuração de liberação de hosts por serviço de rede
# 07. /etc/hosts.deny = arquivo de configuração de negação de hosts por serviço de rede
# 08. /etc/issue.net = arquivo de configuração do Banner utilizado pelo OpenSSH no login
# 09. /etc/default/shellinabox = arquivo de configuração da aplicação Shell-In-a-Box
# 10. /etc/neofetch/config.conf = arquivo de configuração da aplicação Neofetch
# 11. /etc/cron.d/neofetch-cron = arquivo de atualização do Banner Motd o Neofetch
# 12. /etc/motd = arquivo de mensagem do dia gerado pelo Neofetch utilizando o CRON
# 13. /etc/rsyslog.d/50-default.conf = arquivo de configuração do Syslog/Rsyslog
#
# Arquivos de monitoramento (log) do Serviço de Rede OpenSSH Server utilizados nesse script
# 01. systemctl status ssh = status do serviço do OpenSSH
# 02. journalctl -t sshd = todas as mensagens referente ao serviço do OpenSSH
# 03. tail -f /var/log/syslog | grep sshd = filtrando as mensagens do serviço do OpenSSH
# 04. tail -f /var/log/auth.log | grep ssh = filtrando as mensagens de autenticação do OpenSSH
# 05. tail -f /var/log/tcpwrappers-allow-ssh.log = filtrando as conexões permitidas do OpenSSH
# 06. tail -f /var/log/tcpwrappers-deny.log = filtrando as conexões negadas do OpenSSH
#
# Variável das dependências do laço de loop do OpenSSH Server
SSHDEP="openssh-server openssh-client"
#
# Variável de instalação dos softwares extras do OpenSSH Server
SSHINSTALL="net-tools ipcalc sipcalc nmap tree pwgen neofetch shellinabox"
#
# Variável da porta de conexão padrão do OpenSSH Server
PORTSSH="22"
#
# Variável da porta de conexão padrão do Shell-In-a-Box
PORTSHELLINABOX="4200"
#
#=============================================================================================
#                        VARIÁVEIS UTILIZADAS NO SCRIPT: 02-lamp.sh                          #
#=============================================================================================
# 
# Arquivos de configuração (conf) do Serviço de Rede LAMP Server utilizados nesse script
# 01. /etc/apache2/apache2.conf = arquivo de configuração do Servidor Apache2
# 02. /etc/apache2/ports.conf = arquivo de configuração das portas do Servidor Apache2
# 03. /etc/apache2/envvars = arquivo de configuração das variáveis do Servidor Apache2
# 04. /etc/apache2/sites-available/000-default.conf = arquivo de configuração do site padrão HTTP
# 05. /etc/php/7.4/apache2/php.ini = arquivo de configuração do PHP
# 06. /etc/mysql/mysql.conf.d/mysqld.cnf = arquivo de configuração do Servidor MySQL
# 07. /etc/hosts.allow = arquivo de configuração de liberação de hosts por serviço
# 08. /var/www/html/phpinfo.php = arquivo de geração da documentação do PHP
# 09. /var/www/html/teste.html = arquivo de teste de páginas HTML
#
# Arquivos de monitoramento (log) do Serviço de Rede LAMP Server utilizados nesse script
# 01. systemctl status apache2 = status do serviço do Apache2
# 02. journalctl -t apache2.postinst = todas as mensagens referente ao serviço do Apache2
# 03. tail -f /var/log/apache2/* = vários arquivos de Log's do serviço do Apache2
# 04. systemctl status mysql = status do serviço do Oracle MySQL
# 05. tail -f /var/log/mysql/* = vários arquivos de Log's do serviço do MySQL
# 06. tail -f /var/log/tcpwrappers-allow-mysql.log = filtrando as conexões permitidas do MySQL
# 07. tail -f /var/log/tcpwrappers-deny.log = filtrando as conexões negadas do MySQL
# 08. journalctl -t phpmyadmin = todas as mensagens referente ao serviço do PhpMyAdmin
#
# Declarando as variáveis utilizadas nas configurações dos Serviços do LAMP-Server
#
# Variável do usuário padrão do MySQL (Root do Mysql, diferente do Root do GNU/Linux)
USERMYSQL="root"
#
# Variáveis da senha e confirmação da senha do usuário Root do Mysql 
SENHAMYSQL=$SENHADEFAULT
AGAINMYSQL=$SENHAMYSQL
#
# Variáveis de configuração e liberação da conexão remota para o usuário Root do MySQL
# opções do comando CREATE: create (criar), user (criação de usuário), user@'%' (usuário @ localhost), 
# identified by (identificado por - senha do usuário)
# opções do comando GRANT: grant (permissão), all (todos privilégios), on (em ou na | banco ou 
# tabela), *.* (todos os bancos/tabelas) to (para), user@'%' (usuário @ localhost), 
# opção do comando FLUSH: privileges (recarregar as permissões de privilégios)
CREATEUSER="CREATE USER '$USERMYSQL'@'%' IDENTIFIED BY '$SENHAMYSQL';"
GRANTALL="GRANT ALL ON *.* TO '$USERMYSQL'@'%';"
FLUSH="FLUSH PRIVILEGES;"
#
# Variável de configuração do usuário padrão de administração do PhpMyAdmin (Root do MySQL)
ADMINUSER=$USERMYSQL
#
# Variáveis da senha do usuário Root do Mysql e senha de administração o PhpMyAdmin
ADMIN_PASS=$SENHAMYSQL
APP_PASSWORD=$SENHAMYSQL
APP_PASS=$SENHAMYSQL
#
# Variável de configuração do serviço de hospedagem de site utilizado pelo PhpMyAdmin
WEBSERVER="apache2"
#
# Variável das dependências do laço de loop do LAMP Server
LAMPDEP=""
#
# Variável de instalação do serviço de rede LAMP Server 
# opção do caractere: ^ (circunflexo): expressão regular referente ao Tasksel, o uso do caractere ^ 
# significa que o que precede é um Metapacote. Ao instalar meta pacotes, vários outros pacotes também 
# serão instalados.
# opção do caractere: \ (contra barra): utilizado para quebra de linha em comandos grandes
LAMPINSTALL="lamp-server^ perl python apt-transport-https awstats libgeo-ip-perl libgeo-ipfree-perl \
libnet-ip-perl libgeoip1"
#
# Variável de instalação do serviço de rede PhpMyAdmin
PHPMYADMININSTALL="phpmyadmin php-bcmath php-mbstring php-pear php-dev php-json libmcrypt-dev pwgen"
#
# Variável da porta de conexão padrão do Apache2 Server
PORTAPACHE="80"
#
# Variável da porta de conexão padrão do MySQL Server
PORTMYSQL="3306"
#
#=============================================================================================
#                       VARIÁVEIS UTILIZADAS NO SCRIPT: 03-vsftpd.sh                         #
#=============================================================================================
#
# Arquivos de configuração (conf) do Serviço de Rede VSFTPd utilizados nesse script
# 01. /etc/vsftpd.conf = arquivo de configuração do servidor VSFTPd
# 02. /etc/vsftpd.allowed_users = arquivo de configuração da base de dados de usuários do VSFTPd
# 03. /etc/shells = arquivo de configuração do shells válidos
# 05. /bin/ftponly = arquivo de configuração da mensagem (banner) do VSFTPd
# 06. /etc/hosts.allow = arquivo de configuração de liberação de hosts por serviço
#
# Arquivos de monitoramento (log) do Serviço de Rede VSFTPd Server utilizados nesse script
# 01. systemctl status vsftpd = status do serviço do VSFTPd Server
# 02. tail -f /var/log/vsftpd.log = arquivo de Log's principal do serviço do VSFTPd Server
#
# Declarando as variáveis utilizadas nas configurações do Serviço do VSFTPd Server
#
# Variável de criação do Grupo dos Usuários de acesso ao VSFTPd Server
GROUPFTP="ftpusers"
#
# Variável de criação do Usuário de acesso ao VSFTPd Server
USERFTP="ftpuser"
#
# Variável da senha do Usuário de VSFTPd Server
PASSWORDFTP=$SENHADEFAULT
#
# Variável das dependências do laço de loop do VSFTPd Server
FTPDEP=""
#
# Variável de instalação do serviço de rede VSFTPd Server
FTPINSTALL="vsftpd"
#
# Variável da porta de conexão padrão do VSFTPd Server
PORTFTP="21"
#
#=============================================================================================
#                        VARIÁVEIS UTILIZADAS NO SCRIPT: 04-tomcat.sh                        #
#=============================================================================================
#
# Arquivos de configuração (conf) do Servidor Apache Tomcat utilizados nesse script
# 01. /etc/tomcat9/tomcat-users.xml = arquivo de configuração dos usuários do Tomcat
# 02. /etc/tomcat9/server.xml = arquivo de configuração do servidor Tomcat
#
# Arquivos de monitoramento (log) do Serviço de Rede Tomcat Server utilizados nesse script
# 01. systemctl status tomcat9 = status do serviço do Tomcat Server
# 02. journalctl -t tomcat9 = todas as mensagens referente ao serviço do Tomcat9
# 03. tail -f /var/log/syslog | grep tomcat9 = filtrando as mensagens do serviço do Tomcat9
# 04. tail -f /var/log/tomcat9/* = vários arquivos de Log's do serviço do Tomcat9
#
# Declarando as variáveis utilizadas nas configurações do Serviço do Apache Tomcat9 Server
#
# Variável das dependências do laço de loop do Apache Tomcat9 Server
TOMCATDEP=""
#
# Variável de instalação das dependências do Java do Apache Tomcat Server
TOMCATDEPINSTALL="openjdk-11-jdk openjdk-11-jre default-jdk"
#
# Variável de instalação do serviço de rede Apache Tomcat Server
TOMCATINSTALL="tomcat9 tomcat9-admin tomcat9-common tomcat9-docs tomcat9-examples tomcat9-user"
#
# Variáveis de localização do diretório de Configuração e do Webapp do Tomcat9
PATHTOMCAT9="/usr/share/tomcat9/"
PATHWEBAPPS="/var/lib/tomcat9/webapps"
#
# Variável da porta de conexão padrão do Apache Tomcat Server
PORTTOMCAT="8080"
#
# Variável de download da aplicação Agenda de Contatos em Java feita pelo Prof. José de Assis
# Github do projeto: https://github.com/professorjosedeassis/javaEE (Link atualizado em: 11/01/2022)
# OBSERVAÇÃO IMPORTANTE: Esse projeto você irá executar junto com o Docente de Programação JAVA.
AGENDAJAVAEE="https://github.com/professorjosedeassis/javaEE/raw/main/agendaVaamonde.war"
#
# Variáveis de criação da Base de Dados da Agenda de Contatos no MySQL
# opções do comando CREATE: create (criação), database (base de dados), base (banco de dados)
# opções do comando CREATE: create (criação), user (usuário), identified by (identificado por
# senha do usuário), password (senha)
# opções do comando GRANT: grant (permissão), usage (uso em | uso na), *.* (todos os bancos/
# tabelas), to (para), user (usuário), identified by (identificado por - senha do usuário), 
# password (senha)
# opões do comando GRANT: grant (permissão), all (todos privilégios), on (em ou na | banco ou 
# tabela), *.* (todos os bancos/tabelas), to (para), user@'%' (usuário @ localhost), identified 
# by (identificado por - senha do usuário), password (senha)
# opções do comando FLUSH: flush (atualizar), privileges (recarregar as permissões)
# opções do domando CREATE: create (criação), table (tabela), colunas da tabela, primary key
# (coluna da chave primária)
#
# OBSERVAÇÃO: NO SCRIPT: 10-TOMCAT.SH É UTILIZADO AS VARIÁVEIS DO MYSQL DE USUÁRIO E SENHA
# DO ROOT DO MYSQL CONFIGURADAS NO BLOCO DAS LINHAS: 147 até 150, VARIÁVEIS UTILIZADAS NO SCRIPT: 
# 02-lamp.sh LINHAS: 251 até 252
NAME_DATABASE_JAVAEE="dbagenda"
USERNAME_JAVAEE=$NAME_DATABASE_JAVAEE
PASSWORD_JAVAEE=$NAME_DATABASE_JAVAEE
CREATE_DATABASE_JAVAEE="CREATE DATABASE dbagenda;"
CREATE_USER_DATABASE_JAVAEE="CREATE USER 'dbagenda' IDENTIFIED BY 'dbagenda';"
GRANT_DATABASE_JAVAEE="GRANT USAGE ON *.* TO 'dbagenda';"
GRANT_ALL_DATABASE_JAVAEE="GRANT ALL PRIVILEGES ON dbagenda.* TO 'dbagenda';"
FLUSH_JAVAEE="FLUSH PRIVILEGES;"
CREATE_TABLE_JAVAEE="CREATE TABLE contatos (
	idcon int NOT NULL AUTO_INCREMENT,
	nome varchar(50) NOT NULL,
	fone varchar(15) NOT NULL,
	email varchar(50) DEFAULT NULL,
	PRIMARY KEY (idcon)
);"
#
#=============================================================================================
#                      VARIÁVEIS UTILIZADAS NO SCRIPT: 05-wordpress.sh                       #
#=============================================================================================
#
# Arquivos de configuração (conf) do Site CMS Wordpress utilizados nesse script
# 01. /var/www/html/wp/wp-config.php = arquivo de configuração do site Wordpress
# 02. /var/www/html/wp/.htaccess = arquivo de segurança de páginas e diretórios do Wordpress
# 03. /etc/vsftpd.allowed_users = arquivo de configuração da base de dados de usuários do VSFTPd
# 04. /etc/apache2/sites-available/wordpress.conf = arquivo de configuração do Virtual Host
#
# Arquivos de monitoramento (log) do Site do Wordpress utilizado nesse script
# 01. tail -f /var/log/apache2/access-wordpress.log = log de acesso ao Wordpress
# 02. tail -f /var/log/apache2/error-wordpress.log = log de erro de acesso ao Wordpress
#
# Declarando as variáveis utilizadas nas configurações do Site do Wordpress
#
# Variável de localização da instalação do diretório do Wordpress
PATHWORDPRESS="/var/www/html/wp"
#
# Variável do download do Wordpress (Link atualizado em: 11/01/2022)
WORDPRESS="https://br.wordpress.org/latest-pt_BR.zip"
#
# Variável do download do Wordpress Salt (Link atualizado em: 11/01/2022)
WORDPRESSSALT="https://api.wordpress.org/secret-key/1.1/salt/"
#
# Declarando as variáveis para criação da Base de Dados do Wordpress
# opções do comando CREATE: create (criação), database (base de dados), base (banco de dados)
# opções do comando CREATE: create (criação), user (usuário), identified by (identificado por
# senha do usuário), password (senha)
# opções do comando GRANT: grant (permissão), usage (uso em | uso na), *.* (todos os bancos/
# tabelas), to (para), user (usuário), identified by (identificado por - senha do usuário), 
# password (senha)
# opões do comando GRANT: grant (permissão), all (todos privilégios), on (em ou na | banco ou 
# tabela), *.* (todos os bancos/tabelas), to (para), user@'%' (usuário @ localhost), identified 
# by (identificado por - senha do usuário), password (senha)
# opções do comando FLUSH: flush (atualizar), privileges (recarregar as permissões)
#
# OBSERVAÇÃO: NO SCRIPT: 11-WORDPRESS.SH É UTILIZADO AS VARIÁVEIS DO MYSQL DE USUÁRIO E SENHA
# DO ROOT DO MYSQL CONFIGURADAS NO BLOCO DAS LINHAS: 147 até 150, VARIÁVEIS UTILIZADAS NO SCRIPT: 
# 02-lamp.sh LINHAS: 251 até 252
CREATE_DATABASE_WORDPRESS="CREATE DATABASE wordpress;"
CREATE_USER_DATABASE_WORDPRESS="CREATE USER 'wordpress' IDENTIFIED BY 'wordpress';"
GRANT_DATABASE_WORDPRESS="GRANT USAGE ON *.* TO 'wordpress';"
GRANT_ALL_DATABASE_WORDPRES="GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpress';"
FLUSH_WORDPRESS="FLUSH PRIVILEGES;"
#
# Variáveis de usuário e senha do FTP para acessar o diretório raiz da instalação do Wordpress
USERFTPWORDPRESS="wordpress"
PASSWORDFTPWORDPRESS=$SENHADEFAULT
#
# Variável da instalação das dependências do Wordpress
# opção do caractere: \ (contra barra): utilizado para quebra de linha em comandos grandes
WORDPRESSDEPINSTALL="unzip ghostscript libapache2-mod-php php-bcmath php-curl php-imagick \
php-intl php-json php-mbstring php-mysql php-xml php-zip php-soap zlibc zlib1g-dev"
#
# Variável das dependências do laço de loop do Wordpress
WORDPRESSDEP=""
#
#=============================================================================================
#                       VARIÁVEIS UTILIZADAS NO SCRIPT: 06-netdata.sh                        #
#=============================================================================================
#
# Arquivos de configuração (conf) do sistema Netdata utilizados nesse script
# 01. /usr/lib/netdata/conf.d/python.d/apache.conf = arquivo de monitoramento do Apache2
# 02. /usr/lib/netdata/conf.d/python.d/mysql.conf = arquivo de monitoramento do MySQL
# 03. /usr/lib/netdata/conf.d/python.d/tomcat.conf = arquivo de monitoramento do Tomcat
#
# Arquivos de monitoramento (log) do Serviço do Netdata utilizados nesse script
# 01. journalctl -t netdata = todas as mensagens referente ao serviço do Netdata
# 02. tail -f /var/log/netdata/* = vários arquivos de Log's do serviço do Netdata
# 03. tail -f /var/log/syslog | grep netdata = filtrando as mensagens do serviço do Netdata
#
# Declarando as variáveis utilizadas nas configurações do sistema de monitoramento Netdata
#
# Variável de download do Netdata (Link atualizado no dia 10/09/2022)
# opção do comando git clone --depth=100: Cria um clone superficial com um histórico truncado 
# para o número especificado de confirmações (somente os últimos commit geral do repositório)
NETDATA="https://github.com/netdata/netdata --depth=100"
#
# Variável das dependências do laço de loop do Netdata
NETDATADEP=""
#
# Variável de instalação das dependências do Netdata
# opção do caractere: \ (contra barra): utilizado para quebra de linha em comandos grandes
NETDATAINSTALL="zlib1g-dev gcc make git autoconf autogen automake pkg-config uuid-dev python3 \
python3-mysqldb python3-pip python3-dev libmysqlclient-dev python-ipaddress libuv1-dev netcat \
libwebsockets15 libwebsockets-dev libjson-c-dev libbpfcc-dev liblz4-dev libjudy-dev libelf-dev \
libmnl-dev autoconf-archive curl cmake protobuf-compiler protobuf-c-compiler lm-sensors \
python3-psycopg2 python3-pymysql"
#
# Variável da porta de conexão padrão do Netdata
PORTNETDATA="19999"
#
# Declarando as variáveis para criação do usuário de monitoramento do Netdata no MySQL
# opções do comando CREATE: create (criação), user (usuário)
# opções do comando GRANT: grant (permissão), usage (uso em | uso na), replication cliente (),
# *.* (todos os bancos/tabelas), to (para), user (usuário)
# opções do comando FLUSH: flush (atualizar), privileges (recarregar as permissões)
#
# OBSERVAÇÃO: NO SCRIPT: 13-NETDATA.SH É UTILIZADO AS VARIÁVEIS DO MYSQL DE USUÁRIO E SENHA
# DO ROOT DO MYSQL CONFIGURADAS NO BLOCO DAS LINHAS:147 até 150, VARIÁVEIS UTILIZADAS NO SCRIPT: 
# 02-lamp.sh LINHAS: 251 até 252
CREATE_USER_NETDATA="CREATE USER 'netdata'@'localhost';"
GRANT_USAGE_NETDATA="GRANT USAGE, REPLICATION CLIENT ON *.* TO 'netdata'@'localhost';"
FLUSH_NETDATA="FLUSH PRIVILEGES;"
#
#=============================================================================================
#                       VARIÁVEIS UTILIZADAS NO SCRIPT: 07-webmin.sh                         #
#=============================================================================================
#
# Arquivos de configuração (conf) do sistema Webmin e Usermin utilizados nesse script
# 01. /etc/apt/sources.list.d/webmin.list = arquivo de configuração do source list do Apt
#
# Arquivos de monitoramento (log) do Serviço do Webmin e do Usermin utilizados nesse script
# 01. journalctl -t webmin = todas as mensagens referente ao serviço do Webmin
# 02. tail -f /var/webmin/* = vários arquivos de Log's do serviço do Webmin
# 03. tail -f /var/usermin/* = vários arquivos de Log's do serviço do Usermin
#
# Declarando as variáveis utilizadas nas configurações do Webmin e do Usermin
# 
# Variável de download da Chave PGP do Webmin (Link atualizado no dia 30/11/2021)
WEBMINPGP="http://www.webmin.com/jcameron-key.asc"
#
# Variável da instalação das dependências do Webmin e do Usermin
# opção do caractere: \ (contra barra): utilizado para quebra de linha em comandos grandes
WEBMINDEP="perl libnet-ssleay-perl openssl libauthen-pam-perl libpam-runtime libio-pty-perl \
apt-show-versions python unzip apt-transport-https software-properties-common"
#
# Variável de instalação do serviço de rede Webmin e Usermin
WEBMINNSTALL="webmin usermin"
#
# Variáveis das portas de conexão padrão do Webmin e Usermin
PORTWEBMIN="10000"
PORTUSERMIN="20000"
#
#===========================================================================================
