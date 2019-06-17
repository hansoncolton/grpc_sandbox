package api

import (
	"log"

	"golang.org/x/net/context"
)

// Server represents the gRPC server
type Server struct {
}

// SayHello generates response to a Ping request
//func (s *Server) SayHello(ctx context.Context, in *PingMessage) (*PingMessage, error) {
func (s *Server) SayHello(ctx context.Context, in *NoParam) (*PingMessage, error) {
	log.Printf("Received ping")
	return &PingMessage{Greeting: "hello"}, nil
}
