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

# Вопросы?

---

# Полезные ссылки

## Vagrnt plugins

- [`vagrant-vbguest`: автоматическая установка guest additions](https://github.com/dotless-de/vagrant-vbguest)
- [`vagrant-hostmanager`: синхронизация /etc/hosts снаружи vagrant](https://github.com/devopsgroup-io/vagrant-hostmanager)
- [`vagrant-env`: установка переменных окружения из файла](https://github.com/gosuri/vagrant-env)
- [https://github.com/hashicorp/vagrant/wiki/Available-Vagrant-Plugins](https://github.com/hashicorp/vagrant/wiki/Available-Vagrant-Plugins) - полный список плагинов vagrant
- [Создание приватных `vagrant-box`-ов](https://github.com/hollodotme/Helpers/blob/master/Tutorials/vagrant/self-hosted-vagrant-boxes-with-versioning.md)

