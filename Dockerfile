FROM nginx:alpine

ARG SITE_NAME
ARG TAGLINE
ARG LAUNCH_DATE
ARG OWNER_NAME
ARG CONTACT_EMAIL
ARG RUNTIME_ENV

ENV RUNTIME_ENV=${RUNTIME_ENV}

COPY html/ /usr/share/nginx/html/

RUN apk add --no-cache --virtual .build-deps tzdata && \
    BUILD_TIME=$(TZ=Asia/Jakarta date "+%d %b %Y %H:%M WIB") && \
    sed -i \
    -e "s|SITE_NAME_PLACEHOLDER|${SITE_NAME}|g" \
    -e "s|TAGLINE_PLACEHOLDER|${TAGLINE}|g" \
    -e "s|LAUNCH_DATE_PLACEHOLDER|${LAUNCH_DATE}|g" \
    -e "s|OWNER_NAME_PLACEHOLDER|${OWNER_NAME}|g" \
    -e "s|CONTACT_EMAIL_PLACEHOLDER|${CONTACT_EMAIL}|g" \
    -e "s|RUNTIME_ENV_PLACEHOLDER|${RUNTIME_ENV}|g" \
    -e "s|BUILD_TIME_PLACEHOLDER|${BUILD_TIME}|g" \
    /usr/share/nginx/html/index.html && \
    apk del .build-deps

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
