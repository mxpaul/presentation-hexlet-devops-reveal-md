---
title: Vagrant RevealMD
theme: serif
revealOptions:
  #transition: 'slide'
  controls: true
  mouseWheel: false
  progress: true
---

# Vagrant
## Хекслет: devops-for-programmers

---

# Знакомство
### Максим Поляков

- C 2000 года занимался администрировнием Linux-серверов 
- Опыт backend разработки в `Mail.Ru` с 2013 года
- Большой опыт автоматизации процессов выкатки кода на бой
- Помню журнал Infected Voice :-)

Note:
- Со школьных лет занимался разработкой и администрированием Linux
- Побывал в обоих лагерях (Development и Operation)
- Долгое время занимался разработкой высоконогруженных сервисов в большой компании
- В работе большое унимание уделяю взаимодействию с эксплуатацией
- Работал с множеством технологий, часть из которых сегодня уже отмерли, а часть выходит на арену
- git, subversion, c/c++, objective C, Java, PHP, Perl, NodeJS, LUA, Golang,
Asm, nginx, apache, sendmail, qmail, exim, rageircd, unrealircd, bind(named), vsftp, chroot, 
openvz, centos, slackware, rpmbuild, LVM, lilo, grub, docker, vagrant, make, bash, gcc, automake,
iptables, ipchains, openvpn, pptp, dhcpd, pppoe, ppp, mysql, postgres, mongodb, tarantool, kafka,
k8s, gitlab, buildbot, puppet, ansible, virtualbox, android, protobuf, ipset, samba, sed, mdadm,
patch, python, neural networks


---

# Что будем изучать 3 месяца

- Модуль 1: Автоматизация ~~разворачивания~~ развёртывания окружения на машине разработчика
- Модуль 2: Deploy и эксплуатация
- Модуль 3: Управление инфраструктурой

Note:
- В первом модуле мы разберем те инструменты и практики которые позволяют разработчику упростить себе жизнь
  - повысить качество кода
  - разрабатывать локально, но максимально приблизиться к боевому окружению
  - снизить порог вхождения для новых разработчиков (onboarding, ЛитРес)
Первый модуль поможет даже если в вашей компании с DevOps все плохо, но вы хотите для себя делать
сразу хорошо
- Второй модуль посвящен тому как эффективно раскатываться на бой
  - поднять скорость выкатки на новую высоту
  - эффективное масштабирование при росте нагрузки

---

# Зачем нужен DevOps

- Большой пласт рутинных операций автоматизирован на этапе разработки
- Взаимное проникновение best practices (code-review, Configuration Management Systems)
- Облегчение тестирования за счет сближения боевого и тестового окружений
- Понимание особенностей эксплуатации на ранних этапах проектирования, меньше цена ошибки
- Повышение качества софта
- Ускоренный цикл разработки, низкие значения Time-to-Market
- Снижение затрат на эксплуатацию
- Снижение входного порога для новых разработчиков (onboarding)

Note:
DevOps помогает перенести ощутимую часть работы с админов на разработчиков и тестировщиков.
При этом процесс организован не за счет увеличения нагрузки, а за счет погружения разработчика
в специфику эксплуатации. Эксплуатация при этом тоже больше участвует в жизни разработки,
перенимает полезные практики которые можно использовать, частично берет на себя разработку 
частей инфраструктуры - мониторинг, кубер, опенстек - разработчики получают как сервисы.

----

# Зачем нужен DevOps

## Как была организована разработка на заре времен (200x)?
<!-- .slide: data-transition="none" -->

- Разрботка кода на локальной (часто Windows) машине.<span class="fragment fade-in"> Иногда на боевом сервере... </span><!-- .element: class="fragment"  -->
- Тестирование руками разработчика (Это яп исал, тестировать не нужно)<!-- .element: class="fragment"  -->
- Сервера полностью настраивают админы <!-- .element: class="fragment"  -->
  - Сборка и установка железа <!-- .element: class="fragment"  -->
  - Настройка сетей: vlan-ы, маршрутизация, резервирование каналов, firewall-ы <!-- .element: class="fragment"  -->
  - Установка ОС - разделы, RAID-ы, загрузчики, заливка базовых пакетов <!-- .element: class="fragment"  -->
  - Установка сервисов (DNS, Apache, mod_php)<!-- .element: class="fragment"  --> 
  - Мониторинг<!-- .element: class="fragment"  -->
  - Резервирвное копирование<!-- .element: class="fragment"  -->
  - Масштабирование нагрузки<!-- .element: class="fragment"  -->

### Это страшный антипаттерн, так делать не надо <!-- .element: class="fragment"  -->

----

# Зачем нужен DevOps

## Более взрослый подход из конца 200х (2007-2014)

- Разработка ведется на удаленной машине (виртуалка - openvz, proxmox, kvm, openstack)
- Тестирование отдельной командой - ручное, автоматизированное
- Автоматизация сборки из git
- Раскладка кода на бой пакетами (rpm, deb)
- Инженеры для сборки, установки, ремонта серверов в ДЦ
- Автоматизированная наливка ОС на железки (cobbler, tftp)
- Команда сетевых инженеров для настройки маршрутизаторов
- Системы управления конфигурацией (puppet, chef, salt, ansible)

### Это уже неплохо, но это можно делать по-разному, DevOps или Dev-VS-Ops

----

# Зачем нужен DevOps

## Сегодня

- Разрботка при помощи Docker
- Continious Integration / Continious Deployment
- Раскладка кода на бой через kubernetes (k8s, кубер)
- Системы управления конфигурацией (ansible)
- Облачные сервисы (AWS, Google Cloud Platform)

### Это гораздо лучше, но тоже можно делать по-разному

---

# Infrastructure-As-Code

Важная составляющая DevOps

- Выкидываем web-интерфейсы, не храним настройки окружения в базе данных
- Конфигурация хранится в git в виде текстовых файлов
- Декларативное описание окружения
- Позволяет управлять изменениями конфигурации, откатывать, делать review
- Обеспечивает повторяемость развёртывания в разных окружениях
  - vagrant
  - docker
  - kubernetes
  - ansible, puppet, chef, salt (Configuration Management Systems, CMS)
  - terraform
- Упрощает обмен опытом, воспроизведение проблем
- Дает возможность поддеривать тестовое окружение в актуальном состоянии
  

---

# Vagrant

## Infrastructure-as-Code для виртуалок

- Конфигурация хранится в текстовом файле в виде ruby-кода
- Поддержка разных систем виртуализации (providers)
- Настройка сетей, проброс портов
- Проброс каталогов в внутрь виртуалки
- Автоматическая настройка (provisioning) при помощи Configuration Management Systems
 

---

# Vagrant

## Почему не использовать просто Virtualbox

Виртуалки часто применяют для разработки, это альтернатива разработке на удаленной машине.
Но есть нюансы...

- Настройка сложного окружения руками может занимать несколько дней
- Многие настройки делаются через GUI, то есть невоспроизводимы
- То что делается через cli может делаться по-разному в зависимости от host OS
- Если вам для тестирования надо раздолбить всю систему, ее потом придется настраивать руками
- "У меня в dev-е работает" @Разработчик


Note:
Пример ЛитРес c тазами на развертывание которых по мануалу уходит у нового разработчика
два дня

---

# Vagrant

## Почему не использовать Docker?

Spoiler: docker можно и нужно использовать

Но есть применения где Vagrant либо лучше либо не хуже:

- Разработка драйверов ядра или просто проверка работы софта с разными ядрами
- Тестирование манифестов систем управления конфигурациями
- Разработка под ОС отличных от Linux - FreeBSD, Solaris, или под другую архитектуру (x86 vs x86_64)
- Специфичный софт который плохо работает в docker (например, Percona)
- Эмуляция различных сбоев на уровне OS
- docker можно запускать внутри vagrant
- Универсальное повторяемое окружение для разработчика

---

# Vagrant

Где искать образы (boxes): https://app.vagrantup.com/boxes/search

Минимальный рабочий Vagrantfile
```ruby
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64" # Download https://vagrantcloud.com/ubuntu/trusty64
end

```

Основные команды

- `vagrant init` - инициализация Vagrantfile с нуля
- `vagrant status` - показать состояние виртуалки
- `vagrant up` - запустить виртуалку в соответствии с описанием из Vagrantfile
- `vagrant ssh` - подключение к виртуальной машине по ssh
- `vagrant halt` - остановка виртуальной машины
- `vagrant destroy` - остановить виртуалку и удалить все данные
- `vagrant global-status` - показать status для всех vagrant-виртуалок независимо от каталога



---

# Vagrant

## Работа vagrant up 

![width:100px height:100px](vagrant_up_full.gif)

----

# Vagrant

## Текущий каталог проброшен внутрь виртуалки в /vagrant

![width:100px height:100px](vagrant_syncfolder.gif)

---

# Vagrant

## Synced Directory

- Текущий каталог (содержащий Vagrantfile) доступен внутри виртуалки как /vagrant
- Изменения сделанные внутри виртуалки синхронизируются на host и наоборот
- Для работы синхронизации нужен Virtualbox Guest Additions
- Можно задавать дополнительные каталоги для синхронизации
```ruby
Vagrant.configure("2") do |config|
	config.vm.box = "ubuntu/trusty64"
	config.vm.synced_folder "Hexlet/", "/home/vagrant/Hexlet", disabled: false,
		create: true,
		id: "Hexlet"
end
```

---

# Vagrant

## Проброс портов

```ruby
Vagrant.configure("2") do |config|
	config.vm.box = "ubuntu/trusty64"
	config.vm.network "forwarded_port", guest: 8080, host: 8080
end
```

---

# Vagrant
Provisioning (Shell)

```
$ tree
.
├── [drwxrwxr-x  4.0K]  provision/
│   └── [drwxrwxr-x  4.0K]  shell/
│       └── [-rw-rw-r--    50]  install.sh
└── [-rw-rw-r--   221]  Vagrantfile

2 directories, 2 files
```

```
$ cat provision/shell/install.sh 
#!/bin/bash
apt-get update && apt install -y tmux
```

```
$ cat Vagrantfile 
Vagrant.configure("2") do |config|
	config.vm.box = "ubuntu/trusty64"
	config.vm.network "forwarded_port", guest: 8080, host: 8081

	config.vm.provider :virtualbox do |vb|
		vb.customize [ "modifyvm", :id,
			#"--cpuexecutioncap", "50", # CPU 50%
			"--memory", "512", # Mb
		]
		vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
		vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
	end

	#config.vm.provision "shell", inline: "echo Hello"
	config.vm.provision "shell", 
		path: "provision/shell/install.sh", privileged: true
end
```

---

# Полезные ссылки

## Vagrnt plugins

- [`vagrant-vbguest`: автоматическая установка guest additions](https://github.com/dotless-de/vagrant-vbguest)
- [`vagrant-hostmanager`: синхронизация /etc/hosts снаружи vagrant](https://github.com/devopsgroup-io/vagrant-hostmanager)
- [`vagrant-env`: установка переменных окружения из файла](https://github.com/gosuri/vagrant-env)
- [https://github.com/hashicorp/vagrant/wiki/Available-Vagrant-Plugins](https://github.com/hashicorp/vagrant/wiki/Available-Vagrant-Plugins) - полный список плагинов vagrant
- [Создание приватных `vagrant-box`-ов](https://github.com/hollodotme/Helpers/blob/master/Tutorials/vagrant/self-hosted-vagrant-boxes-with-versioning.md)

