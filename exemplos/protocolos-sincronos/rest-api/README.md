# Books API - Exemplo de API REST

### Livros
- `GET /api/v1/books` - Listar todos os livros
- `GET /api/v1/books/:id` - Buscar livro por ID
- `POST /api/v1/books` - Criar novo livro
- `PUT /api/v1/books/:id` - Atualizar livro
- `DELETE /api/v1/books/:id` - Deletar livro

## Exemplos de Uso

### 1. Health Check
```bash
curl http://localhost:3000/health
```

### 2. Listar todos os livros
```bash
curl http://localhost:3000/api/v1/books
```

### 3. Criar um novo livro
```bash
curl -X POST http://localhost:3000/api/v1/books \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Clean Code",
    "author": "Robert C. Martin",
    "isbn": "978-0132350884",
    "published_year": 2008
  }'
```

### 4. Buscar livro por ID
```bash
curl http://localhost:3000/api/v1/books/1
```

### 5. Atualizar um livro
```bash
curl -X PUT http://localhost:3000/api/v1/books/1 \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Clean Code - Updated",
    "author": "Robert C. Martin",
    "isbn": "978-0132350884",
    "published_year": 2008
  }'
```

### 6. Deletar um livro
```bash
curl -X DELETE http://localhost:3000/api/v1/books/1
```

## Variáveis de Ambiente

| Variável | Padrão | Descrição |
|----------|--------|-----------|
| DB_HOST | localhost | Host do PostgreSQL |
| DB_PORT | 5432 | Porta do PostgreSQL |
| DB_USER | postgres | Usuário do PostgreSQL |
| DB_PASSWORD | password | Senha do PostgreSQL |
| DB_NAME | books_db | Nome do banco |
| PORT | 3000 | Porta da API |