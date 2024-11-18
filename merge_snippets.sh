#!/bin/bash

# スニペットが保存されているディレクトリ
SNIPPETS_DIR="$HOME/.config/nvim/snips"

# UltiSnipsが参照するディレクトリ
ULTISNIPS_DIR="$HOME/.config/nvim/UltiSnips"

# UltiSnipsディレクトリを作成（存在しない場合）
mkdir -p "$ULTISNIPS_DIR"

# 一時的に統合ファイルを削除
rm -f "$ULTISNIPS_DIR/"*.snippets

# スニペットをファイルタイプごとに統合
find "$SNIPPETS_DIR" -type f -name "*.snippets" | while read -r snippet_file; do
  # スニペットファイルのパスからファイルタイプを取得
  # 'snips' ディレクトリの直下にあるディレクトリ名をファイルタイプとする
  relative_path="${snippet_file#$SNIPPETS_DIR/}"
  filetype=$(echo "$relative_path" | cut -d'/' -f1)
  
  # ファイルをファイルタイプごとのスニペットファイルに追加
  cat "$snippet_file" >> "$ULTISNIPS_DIR/$filetype.snippets"
done

