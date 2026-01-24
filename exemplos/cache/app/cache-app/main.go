// cmd/server/main.go
package main

import (
	"app/routines"
	"fmt"
	"os"

	"github.com/gofiber/fiber/v2"
	"github.com/gofiber/fiber/v2/middleware/compress"
	jsoniter "github.com/json-iterator/go"
)

func main() {

	routines.DatabaseMigration()

	port := getEnv("PORT", "8080")

	app := fiber.New(fiber.Config{
		JSONEncoder: jsoniter.ConfigCompatibleWithStandardLibrary.Marshal,
		JSONDecoder: jsoniter.ConfigCompatibleWithStandardLibrary.Unmarshal,
		Immutable:   true,
		Prefork:     false,
	})

	app.Use(compress.New(compress.Config{
		Level: compress.LevelBestSpeed, // 1
	}))

	// rota básica
	app.Get("/", func(c *fiber.Ctx) error {
		return c.SendString("Hello, World 👋 with Fiber")
	})

	// rota de healthcheck
	app.Get("/ping", func(c *fiber.Ctx) error {
		return c.Status(200).SendString("pong")
	})

	fmt.Printf("🚀 Servindo em http://localhost:%s\n", port)
	if err := app.Listen(":" + port); err != nil {
		panic(err)
	}
}

func getEnv(key, def string) string {
	if v := os.Getenv(key); v != "" {
		return v
	}
	return def
}
