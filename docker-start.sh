#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}🚀 Starting Hotel Booking Backend with Docker...${NC}"

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo -e "${RED}❌ Docker is not installed${NC}"
    exit 1
fi

# Check if Docker Compose is installed
if ! command -v docker-compose &> /dev/null; then
    echo -e "${RED}❌ Docker Compose is not installed${NC}"
    exit 1
fi

# Build and start containers
echo -e "${YELLOW}📦 Building Docker images...${NC}"
docker-compose build

echo -e "${YELLOW}⬆️  Starting containers...${NC}"
docker-compose up -d

# Wait for services to be ready
echo -e "${YELLOW}⏳ Waiting for services to be ready...${NC}"
sleep 10

# Run migrations
echo -e "${YELLOW}🔄 Running migrations...${NC}"
docker-compose exec -T app php artisan migrate --force

# Run seeders (optional)
# echo -e "${YELLOW}🌱 Seeding database...${NC}"
# docker-compose exec -T app php artisan db:seed

# Generate app key if needed
echo -e "${YELLOW}🔑 Generating app key...${NC}"
docker-compose exec -T app php artisan key:generate --force

# Clear cache
echo -e "${YELLOW}🧹 Clearing cache...${NC}"
docker-compose exec -T app php artisan cache:clear
docker-compose exec -T app php artisan config:clear
docker-compose exec -T app php artisan route:clear

echo -e "${GREEN}✅ Hotel Booking Backend is ready!${NC}"
echo -e "${GREEN}🌐 Backend API: http://localhost:8000${NC}"
echo -e "${YELLOW}📝 View logs: docker-compose logs -f app${NC}"
echo -e "${YELLOW}🛑 Stop containers: docker-compose down${NC}"
