# Claude Code CLI Docker Container

Run Claude Code CLI in a secure, sandboxed Docker environment with elevated permissions for seamless development workflows.

## Key Features

- **Sandboxed Environment**: Isolated Docker container prevents system-level conflicts
- **Privileged Mode**: Runs with `--dangerously-skip-permissions` flag for full filesystem access
- **Docker Integration**: Direct access to host Docker daemon for container operations via mounted socket
- **Project Isolation**: Independent configurations per project directory
- **Zero Setup**: Pre-configured with all required dependencies (Node.js, Python, ripgrep, git)
- **Cross-Platform**: Works on any system with Docker installed

## Why Use This Container?

- **Security**: Isolate Claude Code CLI operations from your host system
- **Consistency**: Same environment across different machines and teams
- **Permissions**: Bypass permission restrictions that might block CLI operations
- **Convenience**: No need to install Claude Code CLI dependencies on your host
- **Multi-Project**: Maintain separate Claude configurations for different projects

## Perfect For

- Development teams requiring consistent tooling
- CI/CD pipelines needing Claude Code CLI access
- Environments where installing CLI tools directly isn't preferred
- Projects requiring elevated filesystem permissions
- Multi-project workflows with isolated configurations

This containerized approach provides the full power of Claude Code CLI while maintaining system isolation and security boundaries.

# Usage

## Build image
```
docker build --no-cache -t claude-code-cli:latest . -f Dockerfile
```

## Run Claude Code CLI in a Docker container

### Basic usage

#### Mounting persistent volumes
Mount a persistent volume so that Claude Code CLI can persist its configuration (auth token) and cache across container restarts.

#### Mounting workspace directories
Using `-v $(pwd):$(pwd)` and `-w $(pwd)` ensures that Claude Code shares the same project path inside the container as on the host. This allows Claude Code to maintain independent configurations for each project, remembering settings and context across different projects when switching between them.

#### Docker socket mounting
The `-v /var/run/docker.sock:/var/run/docker.sock` mount provides Claude Code CLI with direct access to the host machine's Docker daemon. This enables Claude Code to:
- Build and run Docker containers on the host system
- Execute Docker commands as if running natively on the host
- Access and manage all Docker resources (images, containers, networks, volumes) from within the containerized environment
- Maintain full Docker functionality for development workflows that require container operations

```bash
docker run -it --rm \
    -v claude-code-cli:/home \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v $(pwd):$(pwd) \
    -w $(pwd) \
    --name claude-code-cli-$(basename "$PWD") \
    claude-code-cli:latest
```

Shell alias:
```bash
alias claude='docker run -it --rm \
    -v claude-code-cli:/home \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v $(pwd):$(pwd) \
    -w $(pwd) \
    --name claude-code-cli-$(basename "$PWD") \
    claude-code-cli:latest'
```