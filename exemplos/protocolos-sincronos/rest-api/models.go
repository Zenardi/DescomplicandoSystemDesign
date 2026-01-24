package main

import "time"

type Book struct {
	ID            int       `json:"id" db:"id"`
	Title         string    `json:"title" db:"title"`
	Author        string    `json:"author" db:"author"`
	ISBN          string    `json:"isbn" db:"isbn"`
	PublishedYear int       `json:"published_year" db:"published_year"`
	CreatedAt     time.Time `json:"created_at" db:"created_at"`
	UpdatedAt     time.Time `json:"updated_at" db:"updated_at"`
}

type CreateBookRequest struct {
	Title         string `json:"title"`
	Author        string `json:"author"`
	ISBN          string `json:"isbn"`
	PublishedYear int    `json:"published_year"`
}

type UpdateBookRequest struct {
	Title         string `json:"title"`
	Author        string `json:"author"`
	ISBN          string `json:"isbn"`
	PublishedYear int    `json:"published_year"`
}