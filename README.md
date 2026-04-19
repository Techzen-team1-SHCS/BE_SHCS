# 🏨 Hotel Booking - Backend API (Laravel)

Backend API được xây dựng bằng **Laravel 10**, cung cấp các dịch vụ chính cho hệ thống:

- Quản lý người dùng (đăng ký, đăng nhập, phân quyền)
- Quản lý khách sạn, phòng, booking
- Xử lý thanh toán (Stripe, Paypal, Momo)
- Kết nối tới AI Engine (Python) để gợi ý khách sạn

---

ngrok http 80
-Check redis: redis-cli -n 1 keys _top_hotels_
cd /mnt/d/SHCS_Booking/Hotel-Booking-BE chạy với ubuntu giúp tăng tốc độ
Lệnh:
+php artisan octane:start --host=0.0.0.0 --port=8000 --workers=4 --watch
+php artisan reverb:start --host=0.0.0.0 --port=8080
+php artisan queue:work --queue=booking,default
## 🚀 Cài đặt

### 1. Yêu cầu hệ thống

- PHP >= 8.1
- Composer
- MySQL >= 8
- Node.js >= 18 (nếu cần build asset bằng Vite)

---

### 2. Cài đặt Laravel

```bash
# Di chuyển vào thư mục backend
cd backend

# Cài đặt dependencies PHP
composer install

# Tạo file .env từ file mẫu
cp .env.example .env

# Tạo application key
php artisan key:generate

# Run
php artisan serve
```
