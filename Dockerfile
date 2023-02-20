FROM gradle:8.0.0-jdk11-alpine as build
WORKDIR /app
COPY --chown=gradle:gradle .gradle/ .gradle
COPY --chown=gradle:gradle gradlew ./
COPY --chown=gradle:gradle Jenkinsfile ./
COPY --chown=gradle:gradle build.gradle ./
COPY --chown=gradle:gradle src ./src
RUN gradle build
RUN gradle test
#COPY --chown=gradle:gradle . /app
RUN jdeps \
    --ignore-missing-deps \
    -q \
    --multi-release 17 \
    --print-module-deps \
    --class-path build/lib/* \
    build/libs/*.jar > jre-deps.info
RUN jlink \
    --output jre \
    --add-modules $(cat jre-deps.info)

FROM alpine:3.17.2
WORKDIR /app
COPY --from=build /app/jre jre
COPY --from=build /app/build/libs/* lib/
COPY --from=build /app/build/libs/caesar-cipher.jar caesar-cipher.jar
CMD [ "jre/bin/java", "-jar", "caesar-cipher.jar" ]

