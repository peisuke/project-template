# ベースイメージとしてPythonを使用
FROM python:3.12-slim

# 必要なパッケージのインストール
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    wget \
    && apt-get clean

# ホストユーザーのUIDとGIDを環境変数として設定
ARG USER_ID
ARG GROUP_ID

# グループとユーザーの作成（GIDがすでに存在する場合に備える）
RUN if getent group ${GROUP_ID} > /dev/null; then \
        adduser --disabled-password --gecos '' --uid ${USER_ID} user; \
        adduser user $(getent group ${GROUP_ID} | cut -d: -f1); \
    else \
        addgroup --gid ${GROUP_ID} usergroup && \
        adduser --disabled-password --gecos '' --uid ${USER_ID} --gid ${GROUP_ID} user; \
    fi

# ユーザーを切り替え
USER user

# Poetryのインストールをユーザーレベルで行う
ENV POETRY_HOME="/home/user/.local"
ENV PATH="$POETRY_HOME/bin:$PATH"
RUN curl -sSL https://install.python-poetry.org | python3 -

# 作業ディレクトリを設定
WORKDIR /app

# プロジェクトの依存関係ファイルをコピー
COPY pyproject.toml poetry.lock ./

# 依存関係のインストール
RUN poetry install

# ソースコードと.envファイルをコピー
COPY --chown=${USER_ID}:${GROUP_ID} . .

# Jupyter Labの起動
CMD ["poetry", "run", "jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.token=''"]
