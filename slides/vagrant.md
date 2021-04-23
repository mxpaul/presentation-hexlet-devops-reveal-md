---
title: Vagrant RevealMD
theme: blood
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

- C 2000 года занимался администрировние Linux-серверов 
- Шестилетний опыт backend разработки в `Mail.Ru`
- Большой опыт автоматизации процессов выкатки кода на бой
- Помню журнал Infected Voice :-)

Note:
- Со школьных лет занимался разработкой и администрированием Linux
- Побывал в обоих лагерях (Development и Operation)
- Долгое время занимался разработкой высоконогруженных сервисов в большой компании
- В работе большое унимание уделяю взаимодействию с эксплуатацией
- Работал с множеством технологий, часть из которых сегодня уже омерли, а часть выходит на арену
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

----

# Зачем нужен DevOps

## Как была организована разработка на заре времен (200x)?
<!-- .slide: data-transition="none" -->

- Разрботка кода на локальной (часто Windows) машине.<span class="fragment fade-in"> Иногда на боевом сервере... </span><!-- .element: class="fragment"  -->
- Тестирование руками разработчика.<!-- .element: class="fragment"  -->
- Серера полностью настраивают админы <!-- .element: class="fragment"  -->
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

- Разрботка кода на удаленной машине (виртуалка - openvz, proxmox, kvm, openstack)
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

# Vagrant

<!--
![width:250px height:300px](hexlet.jpeg)
-->

- Цель, реальные примеры использования
- Инициализация/Уничтожение
- Synced Directory
- Ports Forwarding
- Provisioning (Shell)

---

# Полезные ссылки

## Vagrnt plugins

- [`vagrant-vbguest`: автоматическая установка guest additions](https://github.com/dotless-de/vagrant-vbguest)
- [`vagrant-hostmanager`: синхронизация /etc/hosts снаружи vagrant](https://github.com/devopsgroup-io/vagrant-hostmanager)
- [`vagrant-env`: установка переменных окружения из файла](https://github.com/gosuri/vagrant-env)
- [https://github.com/hashicorp/vagrant/wiki/Available-Vagrant-Plugins](https://github.com/hashicorp/vagrant/wiki/Available-Vagrant-Plugins) - полный список плагинов vagrant

