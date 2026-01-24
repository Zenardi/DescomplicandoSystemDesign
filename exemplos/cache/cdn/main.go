package main

import (
	"crypto/sha1"
	"encoding/hex"
	"fmt"
	"io/ioutil"
	"log"
	"net/http"
	"os"
	"path/filepath"
	"time"
)

const port = 8080
const cacheDir = "cache"
const origem = "https://uol.com.br"

func CacheHandler(w http.ResponseWriter, r *http.Request) {

	cachePath := filepath.Join(cacheDir, generateHash(fmt.Sprintf("%s%s%s", r.Method, r.URL.Path, r.URL.RawQuery)))

	var body []byte
	startTime := time.Now()

	// Verifica se o arquivo já existe no cache
	_, err := os.Stat(cachePath)
	if os.IsNotExist(err) {
		fmt.Printf("Cache miss %s\n", cachePath)

		// Buscar do servidor de origem
		url := fmt.Sprintf("%s%s", origem, r.URL.Path)
		resp, err := http.Get(url)
		if err != nil {
			http.Error(w, "Error fetching from origin", http.StatusInternalServerError)
			return
		}
		defer resp.Body.Close()

		body, err = ioutil.ReadAll(resp.Body)
		if err != nil {
			http.Error(w, "Error reading response body", http.StatusInternalServerError)
			return
		}

		// Salvar no cache
		err = ioutil.WriteFile(cachePath, body, 0644)
		if err != nil {
			http.Error(w, "Error writing to cache", http.StatusInternalServerError)
			return
		}

	} else {
		// Cache hit
		fmt.Printf("Cache hit %s\n", cachePath)
		body, err = ioutil.ReadFile(cachePath)
		if err != nil {
			http.Error(w, "Error reading from cache", http.StatusInternalServerError)
			return
		}
	}
	elapsed := time.Since(startTime)
	log.Printf("Tempo total da resquição %s %s took %s\n", r.Method, r.URL.Path, elapsed)
	w.Write(body)
	return
}

func generateHash(input string) string {
	hash := sha1.New()
	hash.Write([]byte(input))
	return hex.EncodeToString(hash.Sum(nil))
}

func main() {

	// Criar o diretorio "cache" se não existir
	if _, err := os.Stat(cacheDir); os.IsNotExist(err) {
		os.Mkdir(cacheDir, os.ModePerm)
	}

	http.HandleFunc("/", CacheHandler)
	log.Printf("Starting server on port %d", port)

	log.Fatal(http.ListenAndServe(fmt.Sprintf(":%d", port), nil))
}
