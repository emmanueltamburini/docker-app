FROM nginx:stable-alpine

# Define volume
VOLUME /tmp

# Install web app on nginx server
RUN rm -rf /usr/share/nginx/html/*
COPY nginx.conf /etc/nginx/nginx.conf
COPY dist/billingApp /usr/share/nginx/html
COPY mime.types /etc/nginx/mime.types

# Install OpenJDK 17, this is posible because ngnix image is based on alpine (linux distribution) I can use this kind of commands
RUN apk --no-cache add openjdk17-jre

# Define JAVA_HOME environment variable
ENV JAVA_HOME /usr/lib/jvm/java-17-openjdk
ENV PATH $JAVA_HOME/bin:$PATH

# Check installation
RUN java -version

# Install JAVA app
ENV JAVA_OPTS=""
ARG JAR_FILE
ADD ${JAR_FILE} app.jar

# Copy the init script
COPY appshell.sh appshell.sh

# The ports that it will show
EXPOSE 80 7080

ENTRYPOINT [ "sh", "appshell.sh" ]