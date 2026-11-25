#!/usr/bin/env bash
set -euo pipefail

PROXY_URL="http://127.0.0.1:7890"

# Проверяем, слушает ли mihomo порт
if ! ss -tlnp | grep -q 7890; then
  echo -e "\e[38;2;255;50;112m❌ Mihomo is not listening on port 7890.\e[0m"
  exit 1
fi

echo -e "\e[38;2;255;0;85m🔄 Testing mihomo proxy...\e[0m"

# Делаем запрос через прокси
RESPONSE=$(curl -s -x "$PROXY_URL" "http://ip-api.com/json" || echo "")

# Если ответа нет или пришла ошибка — выходим
if [ -z "$RESPONSE" ] || echo "$RESPONSE" | grep -q '"status":"fail"'; then
  echo -e "\e[38;2;255;50;112m❌ Proxy request failed.\e[0m"
  exit 1
fi

# Извлекаем данные с помощью jq
COUNTRY=$(echo "$RESPONSE" | jq -r '.country')
CITY=$(echo "$RESPONSE" | jq -r '.city')
IP=$(echo "$RESPONSE" | jq -r '.query')
ISP=$(echo "$RESPONSE" | jq -r '.isp')

# Цвета из нашей киберпанк-палитры (ANSI TrueColor)
CYAN='\e[38;2;0;255;200m'
WHITE='\e[38;2;238;255;255m'
RESET='\e[0m'

echo -e "\e[38;2;0;255;156m✅ Proxy is working!\e[0m"
echo -e "   ${WHITE}Location:${RESET} ${CYAN}$CITY, $COUNTRY${RESET}"
echo -e "   ${WHITE}IP:${RESET}       ${CYAN}$IP${RESET}"
echo -e "   ${WHITE}ISP:${RESET}      ${CYAN}$ISP${RESET}"
