#!/bin/bash

# インストールしたいライブラリをCookiecutter変数から取得
LIBRARIES="{{ cookiecutter.libraries }}"

# Poetryの依存関係をインストール
poetry install

# 指定したライブラリをインストール
poetry add $LIBRARIES
