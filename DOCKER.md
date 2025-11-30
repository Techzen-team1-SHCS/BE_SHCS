# 🐳 Docker Setup Guide - Hotel Booking Backend

## 📋 Yêu cầu

- Docker >= 20.10
- Docker Compose >= 2.0
- Git

## 🚀 Quick Start

### 1. Clone dự án
```bash
git clone <repo-url>
cd Hotel-Booking-BE
```

### 2. Khởi động dự án
```bash
# Linux/Mac
chmod +x docker-start.sh
./docker-start.sh

# Windows (PowerShell)
docker-compose build
docker-compose up -d
```

### 3. Chạy migrations
```bash
docker-compose exec app php artisan migrate
```

### 4. Truy cập API
```
http://localhost:8000
```

---

## 📝 Các lệnh Docker thường dùng

### Xem logs
```bash
# Logs từ container app
docker-compose logs -f app

# Logs từ MySQL
docker-compose logs -f mysql

# Logs từ Redis
docker-compose logs -f redis
```

### Chạy Artisan commands
```bash
# Chạy tinker
docker-compose exec app php artisan tinker

# Tạo migration
docker-compose exec app php artisan make:migration <name>

# Tạo model
docker-compose exec app php artisan make:model <name>

# Tạo controller
docker-compose exec app php artisan make:controller <name>
```

### Quản lý container
```bash
# Dừng containers
docker-compose down

# Restart containers
docker-compose restart

# Xóa volumes (DATABASE SẼ BỊ XÓA)
docker-compose down -v

# Xem trạng thái containers
docker-compose ps
```

### SSH vào container
```bash
docker-compose exec app bash
```

### Cài đặt dependencies
```bash
# PHP packages
docker-compose exec app composer install

# JS packages
docker-compose exec app npm install
```

---

## 🔧 Cấu hình Environment

Các biến môi trường có thể được thiết lập trong `.env` hoặc `.env.docker`:

### Database
- `DB_HOST=mysql` (Docker hostname)
- `DB_DATABASE=hotelbe`
- `DB_USERNAME=root`
- `DB_PASSWORD=123456`

### Redis
- `REDIS_HOST=redis`
- `REDIS_PORT=6379`

### Mail
- `MAIL_MAILER=smtp`
- `MAIL_HOST=smtp.gmail.com`
- `MAIL_PORT=587`
- `MAIL_USERNAME=your-email@gmail.com`
- `MAIL_PASSWORD=your-app-password`

---

## 📊 Architecture

```
┌─────────────────┐
│   PHP App       │  (port 8000)
│   Apache 8.2    │
└────────┬────────┘
         │
    ┌────┴────────────┐
    │                 │
┌───▼───┐         ┌───▼────┐
│ MySQL │         │ Redis  │
│ 8.0   │         │ 7      │
└───────┘         └────────┘
```

---

## 🐛 Troubleshooting

### Port 8000 đang được sử dụng
```bash
# Thay đổi port trong docker-compose.yml
# ports:
#   - "8080:80"  # Sử dụng 8080 thay vì 8000
docker-compose up -d
```

### Database connection error
```bash
# Kiểm tra MySQL container
docker-compose logs mysql

# Restart MySQL
docker-compose restart mysql
```

### Permission denied errors
```bash
# Linux: Fix permission
docker-compose exec app chown -R www-data:www-data /var/www/html/storage
docker-compose exec app chmod -R 755 /var/www/html/storage
```

### Clear cache and rebuild
```bash
docker-compose down -v
docker-compose build --no-cache
docker-compose up -d
```

---

## 🚀 Production Deployment

### 1. Build image cho production
```bash
docker build -t hotel-booking:latest .
```

### 2. Push lên Docker Registry
```bash
docker tag hotel-booking:latest your-registry/hotel-booking:latest
docker push your-registry/hotel-booking:latest
```

### 3. Deploy với docker-compose
```bash
docker-compose -f docker-compose.yml up -d
```

### 4. Hoặc deploy với Kubernetes
Xem file `k8s/` để cấu hình Kubernetes

---

## 📚 Resources

- [Docker Documentation](https://docs.docker.com/)
- [Docker Compose Documentation](https://docs.docker.com/compose/)
- [Laravel Docker Guide](https://laravel.com/docs/10.x/deployment#docker)

---

## 💡 Tips & Best Practices

1. **Luôn backup database trước khi down containers**
   ```bash
   docker-compose exec mysql mysqldump -u root -p$DB_PASSWORD hotelbe > backup.sql
   ```

2. **Monitor resource usage**
   ```bash
   docker stats
   ```

3. **Định kỳ update images**
   ```bash
   docker-compose pull
   docker-compose up -d
   ```

4. **Sử dụng environment files cho sensitive data**
   - Không commit `.env` file lên Git
   - Sử dụng `.env.example` làm template

---

**Happy Coding! 🎉**
