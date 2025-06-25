#!/bin/bash

PORT=8000
PLAYLIST="playlist.m3u"
URL_CACHE="url_cache.txt"

echo "#EXTM3U" > "$PLAYLIST"
touch "$URL_CACHE"

echo "🎧 正在持续监听端口 $PORT，等待猫抓发来歌曲信息..."

nc -lk $PORT | while read -r line; do
    # 累积 JSON 数据（以 { 开头判断）
    if [[ "$line" =~ ^\{ ]]; then
        JSON="$line"

        # 提取字段
        URL=$(echo "$JSON" | jq -r '.data.url')
        TITLE=$(echo "$JSON" | jq -r '.data.title')

        if [[ -z "$URL" || "$URL" == "null" || -z "$TITLE" || "$TITLE" == "null" ]]; then
            echo "⚠️ 未识别到有效链接或标题"
            continue
        fi

        # 去重
        if grep -qF "$URL" "$URL_CACHE"; then
            echo "🔁 已存在: $TITLE"
            continue
        fi

        echo "$URL" >> "$URL_CACHE"
        echo "#EXTINF:-1,$TITLE" >> "$PLAYLIST"
        echo "$URL" >> "$PLAYLIST"

        echo "✅ 收录: $TITLE"
    fi
done

