FROM maven:3.3.3

ENV CATALINA_HOME /usr/local/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH
RUN mkdir -p "$CATALINA_HOME"
WORKDIR $CATALINA_HOME

RUN gpg --keyserver pool.sks-keyservers.net --recv-keys \
F22C4FED \
86867BA6 \
E86E29AC \
307A10A5 \
564C17A3 \
0x7C037D42 \
0BECE548 \
5E763BEC \
2F6059E7 \
288584E7 \
4B6FAEFB \
286BACF1 \
731FABEE \
461B342D \
0D498E23 \
DC3D1B18 \
D63011C7 \
30480593
	
ENV TOMCAT_VERSION 8.5.64
ENV TOMCAT_TGZ_URL https://www.apache.org/dist/tomcat/tomcat-8/v$TOMCAT_VERSION/bin/apache-tomcat-$TOMCAT_VERSION.tar.gz

RUN set -x \
	&& curl -fSL "$TOMCAT_TGZ_URL" -o tomcat.tar.gz \
	&& curl -fSL "$TOMCAT_TGZ_URL.asc" -o tomcat.tar.gz.asc \
	&& gpg --verify tomcat.tar.gz.asc \
	&& tar -xvf tomcat.tar.gz --strip-components=1 \
	&& rm bin/*.bat \
	&& rm tomcat.tar.gz*
	
EXPOSE 8080
CMD ["catalina.sh", "run"]	
