В первую очередь, необходмо открыть 22 порт для исходящего подключение от сервера, который будет производить установку Кубера.

Подготавливаем окружение сервера:
```sh
yum install epel-release python-pip git
```

Далее, отключаем своп и файрвол:
```sh
swapoff -a 
firewall-cmd --state
systemctl stop firewalld
systemctl disable firewalld
```

От рута зайти на узлы и сгенерить для них ssh-ключи:
```sh
ssh-keygen -t rsa
```

Скопировать сгенерированные ключи с каждого узла на сервер, от куда будет производится установка кубера:
```sh
ssh-copy-id root@host
```

Загрузить репозиторий Kubespray(в нашем случае, нужно позаботиться о том, как достать данный репо, ибо доступ к github закрыт):
```sh
git clone https://github.com/kubernetes-sigs/kubespray
```

Так же, необходимо позаботиться о том, как перетащить на сервер модули питона.
Если мы глянем в файл: requirements.txt, то увидим все необходимые зависимости, которые требуются для запуска Ansible:
```sh
ansible==3.4.0
ansible-base==2.10.15
cryptography==2.8
jinja2==2.11.3
netaddr==0.7.19
pbr==5.4.4
jmespath==0.9.5
ruamel.yaml==0.16.10
ruamel.yaml.clib==0.2.4
MarkupSafe==1.1.1
```

Установку пакетов производим с помощью pip:
```sh
pip install package_nam.py or package_name.whl
```

Редактируем файл inventory:
```sh
cp -R ~/kubespray/inventory/sample ~/kubespray/inventory/(название контура)
```

```sh
kub-master-1 ansible_host=192.168.0.100 ip=192.168.0.100
kub-master-2 ansible_host=ip=
kub-node-1 ansible_host= ip=
kub-node-2 ansible_host= ip=

[kube-master]
kub-master-1
kub-master-2

[etcd]
kub-master-1
kub-master-2

[kube-node]
kub-node-1
kub-node-2

[kube-ingress]
kub-ingress-1

[k8s-cluster:children]
kube-master
kube-node
```
