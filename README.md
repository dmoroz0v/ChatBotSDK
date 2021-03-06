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

1. Прописать токен.

1.1. Перейти в файл `Sources/App/routes.swift`.

1.2. В параметр token вписать токен бота полученого у `@BotFather`.

2. Настроить домен и порт.

2.1. Вам понадобится белый `ip` адрес.

2.2. Зарегистрировать домен. Предположим у нас такой домен `mybot.mydomain.ru`.

2.3. Прописать свой локальный ip адрес и домен в etc/hosts. У меня получилось вот так:

`192.168.0.110   mybot.mydomain.ru`

2.4. Прокинуть порт в своем роутере, я выбрал порт `8443`. Необходимо чтобы роутер редиректил входящий трафик по данному порту на ваш локальный `ip` адрес.

2.5. В `Sources/App/configure.swift` раcкоментировать строки и вписать в них домен и порт. У меня получилось вот так:

    app.http.server.configuration.hostname = "mybot.mydomain.ru"
    app.http.server.configuration.port = 8443

3. Сгенерировать сертификат.

3.1. Перейти в директорию проекта, если вы не в директории проекта.

`cd HelloBot`

3.2. Запустить команду `openssl`. Команда будет спрашивать ввод некоторых данных. Важно их все ввести и когда спросит домен, то ввести выбранный домен для бота `mybot.mydomain.ru`.

`openssl req -newkey rsa:2048 -new -nodes -x509 -days 3650 -keyout key.pem -out cert.pem`

3.3. В `Sources/App/configure.swift` раскоментировать строки. У меня получилось вот так:

    try app.http.server.configuration.tlsConfiguration = .forServer(
        certificateChain: [
            .certificate(.init(
                file: "cert.pem",
                format: .pem
            ))
        ],
        privateKey: .file("key.pem")
    )

4. Зарегистрировать `webhook`.

4.1. Перейти в директорию проекта, если вы не в директории проекта.

`cd HelloBot`

4.2. Перейти в директорию проекта, если вы не в директории проекта.

`curl -F "url=https://mybot.mydomain.ru:8443/webhook" -F "certificate=@cert.pem" https://api.telegram.org/bot<token>/setWebhook`

5. Прописать в схеме путь до рабочей директории.

5.1. Выбрать схеуму `Run`.

5.2. Нажать `Edit Scheme`.

5.3. Выбрать `Run` (между `Build` и `Test`).

5.4. Перейти во вкладку `Options`.

5.5. Поставить галочку `User custom working directory`.

5.6. Указать директорию проекта. У меня получилось `~/Projects/HelloBot`.

5.7. Нажать `Close`.

6. Запустить в Xcode схему `Run`.

7. Отправить боту одну из команд:

`/revert` - команда попросит ввести строку и развернёт её

`/pick` - команда предложит выбрать 1 из 8 элементов

`/insert` - команда предложит ввести текст, который необходимо записать в базу данных

`/select` - команда выведет записи из базы данных, которые были добавлены командой /insert

`/cancel` - команда для отмены текущей выполняемой команды

## Deploy используя Docker
