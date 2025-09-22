# 🏨 Hotel Booking - Backend API (Laravel)

Backend API được xây dựng bằng **Laravel 10**, cung cấp các dịch vụ chính cho hệ thống:  
- Quản lý người dùng (đăng ký, đăng nhập, phân quyền)  
- Quản lý khách sạn, phòng, booking  
- Xử lý thanh toán (Stripe, Paypal, Momo)  
- Kết nối tới AI Engine (Python) để gợi ý khách sạn  

---

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
