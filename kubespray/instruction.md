В первую очередь, необходмо открыть 22 порт для исходящего подключение от сервера, который будет производить установку Кубера.

Подготавливаем окружение сервера:
<code>yum install python-pip</code>

Далее, отключаем своп и файрвол:
<code>
swapoff -a 
firewall-cmd --state
systemctl stop firewalld
systemctl disable firewalld
</code>

Зайти на узлы и сгенерить для них ssh-ключи:
ssh-keygen -t rsa

Скопируйте сгенерированный ключи с каждого узла на сервер, от куда будет производится установка кубера:
ssh-copy-id root@host


