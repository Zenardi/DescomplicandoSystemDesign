#!/bin/bash

# Script para testar a API de Livros
# Execute após iniciar a API com docker-compose up

API_URL="http://localhost:3000"

echo "=== Testando Books API ==="
echo

# 1. Health Check
echo "1. Health Check:"
curl -s "$API_URL/health" | jq '.'
echo -e "\n"

# 2. Listar livros (deve estar vazio inicialmente)
echo "2. Listar livros (inicial):"
curl -s "$API_URL/api/v1/books" | jq '.'
echo -e "\n"

# 3. Criar primeiro livro
echo "3. Criar primeiro livro:"
BOOK1=$(curl -s -X POST "$API_URL/api/v1/books" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Clean Code",
    "author": "Robert C. Martin",
    "isbn": "978-0132350884",
    "published_year": 2008
  }')
echo "$BOOK1" | jq '.'
BOOK1_ID=$(echo "$BOOK1" | jq -r '.id')
echo -e "\n"

# 4. Criar segundo livro
echo "4. Criar segundo livro:"
BOOK2=$(curl -s -X POST "$API_URL/api/v1/books" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "The Pragmatic Programmer",
    "author": "David Thomas, Andrew Hunt",
    "isbn": "978-0201616224",
    "published_year": 1999
  }')
echo "$BOOK2" | jq '.'
BOOK2_ID=$(echo "$BOOK2" | jq -r '.id')
echo -e "\n"

# 5. Listar todos os livros
echo "5. Listar todos os livros:"
curl -s "$API_URL/api/v1/books" | jq '.'
echo -e "\n"

# 6. Buscar livro por ID
echo "6. Buscar livro por ID ($BOOK1_ID):"
curl -s "$API_URL/api/v1/books/$BOOK1_ID" | jq '.'
echo -e "\n"

# 7. Atualizar livro
echo "7. Atualizar livro ($BOOK1_ID):"
curl -s -X PUT "$API_URL/api/v1/books/$BOOK1_ID" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Clean Code - A Handbook of Agile Software Craftsmanship",
    "author": "Robert C. Martin",
    "isbn": "978-0132350884",
    "published_year": 2008
  }' | jq '.'
echo -e "\n"

# 8. Verificar atualização
echo "8. Verificar atualização:"
curl -s "$API_URL/api/v1/books/$BOOK1_ID" | jq '.'
echo -e "\n"

# 9. Deletar livro
echo "9. Deletar livro ($BOOK2_ID):"
curl -s -X DELETE "$API_URL/api/v1/books/$BOOK2_ID" -w "Status: %{http_code}\n"
echo -e "\n"

# 10. Listar livros final
echo "10. Listar livros (final):"
curl -s "$API_URL/api/v1/books" | jq '.'
echo -e "\n"

echo "=== Testes concluídos ==="