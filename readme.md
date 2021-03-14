Домашнее задание по nfs.

Файл Vagrantfile поднимает две виртуальные машины:

Сервер с IP адресом 192.168.100.40
Клиент с IP адресом 192.168.100.41

Файл nfss_script.sh создает на сервере необходимые директории для экспорта
/home/vagrant/share только для чтения,
/home/vagrant/share/upload для чтения и записи,
а также активирует и настраивает firewall.

Файл nfsc_script.sh создает на клиенте systemd units 
mnt-share.mount для доступа к директории сервера /home/vagrant/share,
mnt-share-reload.mount для доступа к директории сервера /home/vagrant/share.
Юниты создаются в директории администратора systemd /etc/systemd/system.
Далее эти юниты помещаются в автозагрузку.


После поднятия машин клиент получает доступ через  nfs к папке сервера /home/vagrant/share на чтение
в точке монтирования /mnt/share, и к папке сервера /home/vagrant/share/upload на чтение и запись
в точке монтирования /mnt/share/upload.

