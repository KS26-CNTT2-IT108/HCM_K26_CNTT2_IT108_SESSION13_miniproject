# GreenTech System - Hệ thống quản lý hạ tầng

Dự án mini project môn Nhập Môn CNTT: quản lý hạ tầng cho Startup **GreenTech** gồm lọc nhật ký (log) tự động, tài liệu vận hành và quản lý 100 trạm cảm biến IoT.

## Cấu trúc thư mục

```text
greentech-system/
├── docs/        # README.md, srs-he-thong.docx
├── scripts/     # auto_report.bat (robot lọc log)
├── data/        # log-he-thong.log, quan-ly-thiet-bi.xlsx
├── backup/      # bao-cao-su-co.txt (báo cáo tự sinh)
└── .env         # cấu hình giả định (KHÔNG chứa mật khẩu thật)
```

## Hướng dẫn chạy script

Mở **Command Prompt (cmd)** tại thư mục gốc của dự án rồi gõ:

```bat
scripts\auto_report.bat
```

Kết quả: file `backup\bao-cao-su-co.txt` chứa mọi dòng có chữ `CRITICAL`, `ERROR`, `TIMEOUT`.

> Script có bước **Audit**: không chứa lệnh xóa nguy hiểm `del /f /s /q`.

## Checklist kiểm tra thiết bị

- [x] Kiểm tra cấu trúc thư mục đúng kebab-case, không dấu, không khoảng trắng
- [x] Kiểm tra file `.env` đã tạo và không chứa mật khẩu thật
- [x] Chạy `auto_report.bat` thành công, có file báo cáo
- [ ] Kiểm tra pin của 100 trạm cảm biến (trên 20%)
- [ ] Kiểm tra dung lượng ổ SSD của máy chủ (dưới 80%)
- [ ] Đối soát bảng `trang-thai-tram` không còn lỗi `#N/A`

## Bảng thông số phần cứng

| Mã linh kiện | Tên thiết bị | Đơn giá (VND) | Loại storage |
|--------------|--------------|--------------:|:------------:|
| LK001 | CPU ARM Cortex-A53 | 350.000 | SSD |
| LK002 | CPU ESP32 Dual-Core | 120.000 | SSD |
| LK003 | RAM LPDDR4 4GB | 280.000 | SSD |
| LK004 | RAM DDR3 2GB | 150.000 | HDD |
| LK005 | SSD NVMe 128GB | 650.000 | SSD |
| LK006 | HDD 500GB | 520.000 | HDD |

Dữ liệu đầy đủ và công thức đối soát nằm trong `data/quan-ly-thiet-bi.xlsx`.

## Lưu ý

- Thời gian tải log: **Mbps ÷ 8 = MB/s**. File 500 MB qua mạng 100 Mbps (12,5 MB/s) mất khoảng 40 giây.
- Không bao giờ đưa mật khẩu thật lên GitHub.
