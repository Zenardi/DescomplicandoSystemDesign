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

func ordersHandler(w http.ResponseWriter, r *http.Request) {
	port := os.Getenv("PORT")
	if port == "" {
		port = "8083"
	}

	response := Response{
		App:       "App 3 - Orders Service",
		Message:   "Orders Service V1",
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
		"app":    "orders-service",
	})
}

func main() {
	port := os.Getenv("PORT")
	if port == "" {
		port = "8083"
	}

	http.HandleFunc("/orders", ordersHandler)
	http.HandleFunc("/health", healthHandler)

	log.Printf("Orders Service running on port %s", port)
	log.Fatal(http.ListenAndServe(":"+port, nil))
}
