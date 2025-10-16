#!/bin/bash

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
ARCH=$(uname -m)
if [[ "$ARCH" == "x86_64" ]]; then
    ARCH="amd64"
    ALT_ARCH="x86_64"
elif [[ "$ARCH" == "aarch64" ]] || [[ "$ARCH" == "arm64" ]]; then
    ARCH="arm64"
    ALT_ARCH="aarch64"
fi

TAG=$(date +%Y%m%d)
CONTAINER_NAME="dev-go-remote"
BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Functions
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

build_images() {
    log_info "Starting sequential container build for architecture: $ARCH with tag: $TAG"

    # Build 1: dev-base
    log_info "Building dev-base:$TAG..."
    container build \
        --no-cache \
        --platform linux/$ARCH \
        -t dev-base:$TAG \
        -f "$BASE_DIR/dev-containers/base/Dockerfile" \
        "$BASE_DIR/dev-containers/base"
    container tag dev-base:$TAG dev-base:latest
    log_success "dev-base:$TAG built successfully"

    # Build 2: dev-cli
    log_info "Building dev-cli:$TAG..."
    container build \
        --no-cache \
        --platform linux/$ARCH \
        --build-arg TAG=$TAG \
        --build-arg ARCH=$ARCH \
        --build-arg ALT_ARCH=$ALT_ARCH \
        -t dev-cli:$TAG \
        -f "$BASE_DIR/dev-containers/cli/Dockerfile" \
        "$BASE_DIR/dev-containers/cli"
    container tag dev-cli:$TAG dev-cli:latest
    log_success "dev-cli:$TAG built successfully"

    # Build 3: dev-go (architecture-aware)
    log_info "Building dev-go:$TAG for $ARCH..."
    if [[ "$ARCH" == "arm64" ]]; then
        GOLANG_DOCKERFILE="Dockerfile.arm64"
    else
        GOLANG_DOCKERFILE="Dockerfile"
    fi

    container build \
        --no-cache \
        --platform linux/$ARCH \
        --build-arg TAG=$TAG \
        --build-arg ARCH=$ARCH \
        --build-arg ALT_ARCH=$ALT_ARCH \
        -t dev-go:$TAG \
        -f "$BASE_DIR/dev-containers/golang/$GOLANG_DOCKERFILE" \
        "$BASE_DIR/dev-containers/golang"
    container tag dev-go:$TAG dev-go:latest
    log_success "dev-go:$TAG built successfully"

    # Build 4: dev-node
    log_info "Building dev-node:$TAG..."
    container build \
        --no-cache \
        --platform linux/$ARCH \
        --build-arg TAG=$TAG \
        -t dev-node:$TAG \
        -f "$BASE_DIR/dev-containers/node/Dockerfile" \
        "$BASE_DIR/dev-containers/node"
    container tag dev-node:$TAG dev-node:latest
    log_success "dev-node:$TAG built successfully"

    # Note: dev-python is commented out in original build.sh
    log_warning "dev-python build skipped (commented out in original build script)"

    log_success "All images built successfully!"
}

run_dev_container() {
    log_info "Setting up dev-go remote development container..."

    # Check if container already exists
    if container ps -a --format "{{.Names}}" | grep -q "^${CONTAINER_NAME}$"; then
        log_warning "Container '$CONTAINER_NAME' already exists"

        # Check if it's running
        if container ps --format "{{.Names}}" | grep -q "^${CONTAINER_NAME}$"; then
            log_info "Container is already running"
            return 0
        else
            log_info "Starting existing container..."
            container start "$CONTAINER_NAME"
            log_success "Container '$CONTAINER_NAME' started"
            return 0
        fi
    fi

    # Run new container
    log_info "Creating and starting new container '$CONTAINER_NAME'..."
    container run -d \
        --name "$CONTAINER_NAME" \
        --cpus 10 \
        --memory 32g \
        -e DOCKER_HOST=tcp://192.168.64.1:2375 \
        -v /var/run/docker.sock:/var/run/docker.sock \
        -v "$HOME/.config:/home/dev/.config" \
        -v "$HOME/.claude:/home/dev/.claude" \
        --restart unless-stopped \
        dev-go:latest \
        sleep infinity

    log_success "Container '$CONTAINER_NAME' is running in detached mode"
    log_info "Resources: 10 CPUs, 32GB RAM"
    log_info "Docker host: tcp://192.168.64.1:2375"
    log_info "To attach to the container, run: container exec -it $CONTAINER_NAME /bin/bash"
    log_info "To stop the container, run: container stop $CONTAINER_NAME"
    log_info "To remove the container, run: container rm -f $CONTAINER_NAME"
}

show_usage() {
    cat << EOF
Usage: $0 [OPTION]

Options:
    build       Build all container images sequentially
    run         Start detached dev-go container for remote development
    all         Build images and start dev-go container (default)
    stop        Stop the dev-go container
    restart     Restart the dev-go container
    status      Show status of dev-go container
    clean       Remove the dev-go container
    help        Show this help message

Examples:
    $0              # Build images and start container
    $0 build        # Only build images
    $0 run          # Only start container
    $0 stop         # Stop the running container
    $0 status       # Check container status

EOF
}

stop_container() {
    log_info "Stopping container '$CONTAINER_NAME'..."
    if container ps --format "{{.Names}}" | grep -q "^${CONTAINER_NAME}$"; then
        container stop "$CONTAINER_NAME"
        log_success "Container stopped"
    else
        log_warning "Container is not running"
    fi
}

restart_container() {
    log_info "Restarting container '$CONTAINER_NAME'..."
    if container ps -a --format "{{.Names}}" | grep -q "^${CONTAINER_NAME}$"; then
        container restart "$CONTAINER_NAME"
        log_success "Container restarted"
    else
        log_error "Container does not exist. Run '$0 run' first."
        exit 1
    fi
}

show_status() {
    log_info "Container status for '$CONTAINER_NAME':"
    if container ps -a --format "{{.Names}}" | grep -q "^${CONTAINER_NAME}$"; then
        container ps -a --filter "name=^${CONTAINER_NAME}$" --format "table {{.Names}}\t{{.Status}}\t{{.Image}}\t{{.Ports}}"
        echo ""
        log_info "Container is available"
        if container ps --format "{{.Names}}" | grep -q "^${CONTAINER_NAME}$"; then
            log_success "Status: RUNNING"
        else
            log_warning "Status: STOPPED"
        fi
    else
        log_warning "Container does not exist"
    fi
}

clean_container() {
    log_info "Removing container '$CONTAINER_NAME'..."
    if container ps -a --format "{{.Names}}" | grep -q "^${CONTAINER_NAME}$"; then
        container rm -f "$CONTAINER_NAME"
        log_success "Container removed"
    else
        log_warning "Container does not exist"
    fi
}

# Main
main() {
    case "${1:-all}" in
        build)
            build_images
            ;;
        run)
            run_dev_container
            ;;
        all)
            build_images
            echo ""
            run_dev_container
            ;;
        stop)
            stop_container
            ;;
        restart)
            restart_container
            ;;
        status)
            show_status
            ;;
        clean)
            clean_container
            ;;
        help|--help|-h)
            show_usage
            ;;
        *)
            log_error "Unknown option: $1"
            echo ""
            show_usage
            exit 1
            ;;
    esac
}

main "$@"
