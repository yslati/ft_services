FROM alpine:latest

RUN apk add php7
RUN echo "<?php echo 'hello'; ?>" > index.php

CMD php -S 0.0.0.0:5000
