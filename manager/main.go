package main

import (
	"context"
	"fmt"

	"github.com/compose-spec/compose-go/cli"
	"github.com/compose-spec/compose-go/loader"
)

func main() {
	// Call the function to start services
	if err := startDockerCompose(); err != nil {
		fmt.Printf("Error: %v\n", err)
	}
}

// startDockerCompose reads the provided docker-compose.yaml file and starts the services
func startDockerCompose() error {
	// Specify the path to the existing docker-compose.yaml file
	composeFile := "docker-compose.yaml"

	// Compose CLI project options
	options, err := cli.NewProjectOptions([]string{composeFile}, cli.WithEnvFile(".env"))
	if err != nil {
		return fmt.Errorf("failed to load docker-compose options: %v", err)
	}

	// Load the project from the options
	project, err := cli.ProjectFromOptions(options)
	if err != nil {
		return fmt.Errorf("failed to load project: %v", err)
	}

	// Create a context and start the compose project
	ctx := context.Background()
	service := loader.Load(project)
	if err := service.Up(ctx, project); err != nil {
		return fmt.Errorf("failed to start services: %v", err)
	}

	fmt.Println("Services started successfully.")
	return nil
}
