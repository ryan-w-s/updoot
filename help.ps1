param(
    [Parameter(Position=0)]
    [string]$Command
)

switch ($Command) {
    "dbreset" {
        Write-Host "dbreset: Reset the database"
        Write-Host "Stopping containers and removing volumes..."
        docker-compose down -v
        
        Write-Host "Starting fresh containers..."
        docker-compose up -d
        
        Write-Host "Setting up database..."
        docker-compose exec updoot-web rails db:create db:migrate db:seed
    }
    default {
        Write-Host "Available commands:"
        Write-Host "  dbreset    Reset the database"
    }
} 