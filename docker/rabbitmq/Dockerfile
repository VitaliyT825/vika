FROM rabbitmq:3.8.9-management-alpine

RUN apk update && apk add curl

RUN curl -L -o plugins/elixir-1.8.2.ez https://github.com/noxdafox/rabbitmq-message-deduplication/releases/download/0.4.5/elixir-1.8.2.ez
RUN curl -L -o plugins/rabbitmq_message_deduplication-v3.8.x_0.4.5.ez https://github.com/noxdafox/rabbitmq-message-deduplication/releases/download/0.4.5/rabbitmq_message_deduplication-v3.8.x_0.4.5.ez
RUN curl -L -o plugins/rabbitmq_delayed_message_exchange-3.8.9-0199d11c.ez https://github.com/rabbitmq/rabbitmq-delayed-message-exchange/releases/download/3.8.9/rabbitmq_delayed_message_exchange-3.8.9-0199d11c.ez

RUN rabbitmq-plugins enable rabbitmq_delayed_message_exchange
RUN rabbitmq-plugins enable rabbitmq_message_deduplication
