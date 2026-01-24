package main

import (
	"encoding/json"
	"log"
	"net/http"
	"os"
	"time"
)

type Response struct {
	App       string    `json:"app"`
	Message   string    `json:"message"`
	Timestamp time.Time `json:"timestamp"`
	Port      string    `json:"port"`
}

func usersHandler(w http.ResponseWriter, r *http.Request) {
	port := os.Getenv("PORT")
	if port == "" {
		port = "8081"
	}

	response := Response{
		App:       "App 1 - Users Service",
		Message:   "Users Service V1",
		Timestamp: time.Now(),
		Port:      port,
	}

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(response)
}

func healthHandler(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(map[string]string{
		"status": "healthy",
		"app":    "users-service",
	})
}

func main() {
	port := os.Getenv("PORT")
	if port == "" {
		port = "8081"
	}

	http.HandleFunc("/users", usersHandler)
	http.HandleFunc("/users/health", healthHandler)

	log.Printf("Users Service running on port %s", port)
	log.Fatal(http.ListenAndServe(":"+port, nil))
}
