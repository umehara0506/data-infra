# EmBulkの実行にはJavaが必要なため、Javaが含まれているベースイメージを使用します
FROM openjdk:8-slim

# 作業ディレクトリを設定します
WORKDIR /usr/src/app

# install curl
RUN apt-get update && \
    apt-get install -y curl vim && \
    rm -rf /var/lib/apt/lists/*

# install jruby
RUN curl --create-dirs -o "./jruby-complete-9.4.5.0.jar" -L "https://repo1.maven.org/maven2/org/jruby/jruby-complete/9.4.5.0/jruby-complete-9.4.5.0.jar"
RUN chmod +x ./jruby-complete-9.4.5.0.jar

# Embulkをダウンロードして実行可能にする
RUN curl --create-dirs -o ~/.embulk/bin/embulk -L "https://github.com/embulk/embulk/releases/download/v0.11.5/embulk-0.11.5.jar" && \
    chmod +x ~/.embulk/bin/embulk && \
    echo 'export PATH="$HOME/.embulk/bin:$PATH"' >> ~/.bashrc


# install Ruby gems
COPY ./config/embulk.properties /root/.embulk/embulk.properties
RUN java -jar ~/.embulk/bin/embulk gem install embulk -v 0.11.5

# install embulk plugins
RUN java -jar ~/.embulk/bin/embulk gem install embulk-output-bigquery --no-document
RUN java -jar ~/.embulk/bin/embulk gem install embulk-input-google_spreadsheets --no-document
RUN java -jar ~/.embulk/bin/embulk gem install embulk-output-google_spreadsheets --no-document
RUN java -jar ~/.embulk/bin/embulk gem install embulk-filter-column --no-document
RUN java -jar ~/.embulk/bin/embulk gem install embulk-filter-eval --no-document
RUN java -jar ~/.embulk/bin/embulk gem install liquid -v 4.0.0 --no-document


# install digdag
RUN curl -o /usr/local/bin/digdag --create-dirs -L "https://dl.digdag.io/digdag-latest" \
    && chmod +x /usr/local/bin/digdag \
    && echo 'export PATH="$HOME/usr/local/bin/digdag/bin:$PATH"' >> ~/.bashrc


RUN . ~/.bashrc

WORKDIR /work
COPY ./workflows/ ./
COPY ./secrets/ ./secrets/



# RUN ./embulk gem install msgpack -v 1.7.2
# RUN ./embulk gem install bundler # if you need Bundler
# RUN ./embulk gem install liquid  # if you need Liquid

# Embulkのプラグインをインストール
# 以下の例ではMySQLのプラグインをインストールしています
# RUN ./embulk gem install embulk-input-mysql && \
#     ./embulk gem install embulk-output-mysql

# Embulkの実行コマンドを設定します
# ENTRYPOINT ["java","-jar","./embulk","run","./config/config.yml"]
