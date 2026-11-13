#!/usr/bin/env bash
set -euo pipefail

# Получаем занятое место в WSL (в байтах)
used_wsl=$(df -B1 / | awk 'NR==2 {print $3}')

# Получаем свободное место на диске C (в байтах)
# Если /mnt/c недоступен, скрипт завершится с ошибкой
free_c=$(df -B1 /mnt/c | awk 'NR==2 {print $4}')

# Считаем "реальный" общий размер
total=$((used_wsl + free_c))

# Переводим в гигабайты с двумя знаками после запятой
used_gb=$(awk "BEGIN {printf \"%.2f\", $used_wsl/1024/1024/1024}")
total_gb=$(awk "BEGIN {printf \"%.2f\", $total/1024/1024/1024}")

# Выводим результат
echo "${used_gb} GiB / ${total_gb} GiB"
