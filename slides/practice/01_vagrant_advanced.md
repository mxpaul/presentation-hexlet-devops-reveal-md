---
title: Vagrant Advanced
theme: night
revealOptions:
  #transition: 'slide'
  controls: true
  mouseWheel: false
  progress: true
---

# Vagrant Advanced Technics

## Практическое занятие

---

# План занятия

- Что вы уже знаете
- Когда нужен vagrant
- Тонкая настройка vagrant
- Vagrant Multi-Machine
- Генерация ansible inventory

---

# Что вы уже знаете

- Vagrant автоматизирует создание виртуальных машин
- Разные провайдеры: virtualbox, vmware, docker
- Provisioning: file shell ansible puppet chef **docker**
- Проброс портов
- Проброс каталогов

---

# Когда нужен вагрант

- Docker ~~VS~~ & Vagrant
- Ядро OS или драйверы
- Загрузчик
- Windows, FreeBSD, Solaris
- Пакетные менеджеры: rpm, deb, etc
- Роли и плейбуки Ansible
- ...

---

# Vagrant tips

### DNS NAT

- Vagrant создает свою сеть
- DNS сервер может не разрешать запросы с неизвестных адресов
- Решение с подвохом: поменять адреса DNS внутри виртуалки через провиженинг
- Стабильный вариант: включить Network Address Translation для DNS запросов

Ссылка на github: https://github.com/mxpaul/vagrant_multimachine_docker/blob/v1.0.0/example/basic/Vagrantfile#L15-L16

---

# Vagrant tips

### Проброс каталогов
- Из коробки текущий каталог пробрасывается в /vagrant
- Можно монтировать любые другие пути
- Монтирование возможно через разные техники из числа доступных (nfs, rsync, shared folders, ...)
- Virtualbox shared folders работает только если установлен guest addition
- Если нет guest addition, теряется синхронизация

---

# Vagrant tips

###  Программирование на Vagrantfile

- Vagrantfile это код на ruby
- Можно улучшать читаемость через программирование
- А можно и ухудшать

---

# Vagrant Multi-Machine

## Пример 1. virtualbox + docker

- docker: контейнер с PostgreSQL
- virtualbox: виртуалка с окружением для разработки
- hostmanager обеспечивает доступность по имени
- bridge соединяет сети vagrant и docker

Ссылка на github: https://github.com/mxpaul/vagrant_multimachine_docker/tree/v1.0.0/

---

# Vagrant Multi-Machine

## Пример 2. infragrant

- Три виртуалки: два nameserver-а и один front
- Все машины накатываются ansible из одного плейбука
- Больше ansible

Ссылка на github: https://github.com/mxpaul/infragrant/tree/v1.0.0

---

#  Генерация ansible inventory

- Можно разбить хосты на группы
- Можно определять переменные для групп и хостов
- Разные группы хостов имеют свой набор ролей и переменных

---

# Вопросы

## Ссылки на код
- https://github.com/mxpaul/vagrant_multimachine_docker/tree/v1.0.0/
- https://github.com/mxpaul/infragrant/tree/v1.0.0

