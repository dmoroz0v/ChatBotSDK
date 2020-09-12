# CharBotSDK

## Создание нового проекта

1. Создать бота через @BotFather.

2. Установить Vapor.

https://docs.vapor.codes/4.0/install/macos/

3. Cоздать новый проект. Назвать его например `HelloBot`.

`vapor new HelloBot --template https://github.com/dmoroz0v/ChatBotSDKVaporTemplate -n`

4. Перейти в директорию проекта.

`cd HelloBot`

5. Скомпилировать проект. Это важный шаг, он нужен чтобы появились необходимые схемы в Xcode для запуска кода.

`swift build`

6. Оставаясь в директории с проектом запустить проект в Xcode.

`vapor xcode`

7. Перейти в файл `Sources/Run-long-polling/main.swift`.

8. В параметр token вписать токен бота полученого у @BotFather.

9. Запустить в Xcode схему `Run-long-polling`.

10. В новом проекте сразу реализованы несколько команд для примера. Всего реализовано 5 команд:

`/revert` - команда попросит ввести строку и развернёт её

`/pick` - команда предложит выбрать 1 из 8 элементов

`/insert` - команда предложит ввести текст, который необходимо записать в базу данных

`/select` - команда выведет записи из базы данных, которые были добавлены командой /insert

`/cancel` - команда для отмены текущей выполняемой команды

## Запуск через webhook

## Deploy используя Docker
