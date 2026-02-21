# Hotel Approval Workflow

## Tổng quan

Luồng này mô tả cách hệ thống xử lý khi **Owner tạo khách sạn** và
**Admin duyệt** trước khi khách sạn được hiển thị công khai.

------------------------------------------------------------------------

## 1. Owner tạo khách sạn

Owner gửi request tạo hotel từ hệ thống. - Backend tạo record hotel
trong database. - Trạng thái ban đầu:

    status = pending

Ý nghĩa: Khách sạn chưa được hiển thị ra ngoài hệ thống.

------------------------------------------------------------------------

## 2. Tạo Notification cho Admin

Sau khi hotel được tạo: - Hệ thống tạo bản ghi trong bảng
`notifications`. - Nội dung thông báo:

    Hotel mới cần duyệt
    Khách sạn XYZ đang chờ admin kiểm tra

Mục đích: - Admin biết có hotel mới cần review.

------------------------------------------------------------------------

## 3. Gửi Realtime Event

Backend phát event realtime. Admin dashboard sẽ nhận thông báo ngay lập
tức.

Ví dụ:

    Có khách sạn mới cần duyệt

------------------------------------------------------------------------

## 4. Admin thấy Notification

Admin có thể thấy thông báo ở: - Notification bell - Dashboard - Popup
realtime

------------------------------------------------------------------------

## 5. Admin click vào Notification

Khi admin click: Hệ thống chuyển đến trang:

    /admin/hotels/pending/{hotel_id}

Trang này hiển thị: - Thông tin hotel - Hình ảnh - Owner - Giá - Mô tả

------------------------------------------------------------------------

## 6. Admin duyệt khách sạn

Admin có 2 lựa chọn:

### Approve

    status = approved

### Reject

    status = rejected

------------------------------------------------------------------------

## 7. Gửi Notification cho Owner

Sau khi admin duyệt: Hệ thống gửi notification cho owner.

Ví dụ:

    Hotel của bạn đã được duyệt

hoặc

    Hotel của bạn bị từ chối

------------------------------------------------------------------------

## 8. Publish khách sạn

Chỉ những hotel có trạng thái:

    status = approved

mới được hiển thị ra ngoài hệ thống.

API public sẽ lọc:

    where status = approved

------------------------------------------------------------------------

# Flow tổng thể

    Owner tạo hotel
            ↓
    status = pending
            ↓
    Notification tạo cho admin
            ↓
    Event realtime
            ↓
    Admin thấy notification
            ↓
    Admin click
            ↓
    Trang duyệt hotel
            ↓
    Approve / Reject
            ↓
    Notification gửi cho owner
            ↓
    Hotel publish

------------------------------------------------------------------------

## Ưu điểm của luồng này

-   Kiểm duyệt nội dung trước khi public
-   Tránh spam hotel
-   Admin kiểm soát hệ thống
-   Có realtime notification
-   Có lịch sử thông báo trong database
