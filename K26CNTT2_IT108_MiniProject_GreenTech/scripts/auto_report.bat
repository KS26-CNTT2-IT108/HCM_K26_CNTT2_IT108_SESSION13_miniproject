@echo off
REM ====================================================================
REM  auto_report.bat - Robot loc log tu dong cho he thong GreenTech
REM  Cach chay: nhay doi chuot vao file, hoac go: scripts\auto_report.bat
REM ====================================================================
setlocal

REM --- Duong dan TUONG DOI (tinh tu vi tri cua file .bat) ---
set "ROOT=%~dp0.."
set "LOG=%ROOT%\data\log-he-thong.log"
set "OUTDIR=%ROOT%\backup"
set "REPORT=%OUTDIR%\bao-cao-su-co.txt"

REM ====================================================================
REM  BUOC AUDIT (THAM DINH AN TOAN) - lam TRUOC khi xu ly
REM  - AI hay goi y them lenh xoa cuong buc (del kem co /f /s /q) de don dep file cu.
REM    Lenh nay XOA CUONG BUC toan bo file, ke ca thu muc con, KHONG hoi lai.
REM    => Da KIEM TRA va LOAI BO. Script nay KHONG co lenh xoa nao.
REM  - Chi doc file log va GHI NOI (>>) vao bao cao, khong ghi de, khong xoa.
REM ====================================================================
echo [AUDIT] Kiem tra truoc khi chay...
echo [AUDIT] 1. Script khong chua lenh xoa (del/rmdir/rd): DAT
if not exist "%LOG%" (
    echo [AUDIT] 2. Khong tim thay file log: %LOG%
    echo [LOI] Dung script de bao ve du lieu.
    pause
    exit /b 1
)
echo [AUDIT] 2. File log ton tai: DAT
if not exist "%OUTDIR%" mkdir "%OUTDIR%"
echo [AUDIT] 3. Thu muc backup san sang: DAT
echo.

REM --- Tieu de bao cao (echo + toan tu >> de GHI NOI) ---
echo ==================================================== >> "%REPORT%"
echo      BAO CAO SU CO HE THONG - GREENTECH STARTUP      >> "%REPORT%"
echo      Ngay gio tao bao cao: %date% %time%             >> "%REPORT%"
echo      Nguon: data\log-he-thong.log                    >> "%REPORT%"
echo ==================================================== >> "%REPORT%"

REM --- Loc log bang Pipe (|): type doc tung dong, findstr loc, khong nap het vao RAM ---
REM --- findstr voi nhieu /C: se lay dong chua BAT KY tu khoa nao (CRITICAL hoac ERROR hoac TIMEOUT) ---
type "%LOG%" | findstr /C:"CRITICAL" /C:"ERROR" /C:"TIMEOUT" >> "%REPORT%"

REM --- Dem so dong loi bang pipe thu hai ---
set COUNT=0
for /f %%a in ('type "%LOG%" ^| findstr /C:"CRITICAL" /C:"ERROR" /C:"TIMEOUT" ^| find /c /v ""') do set COUNT=%%a

echo ---------------------------------------------------- >> "%REPORT%"
echo TONG SO DONG LOI NGHIEM TRONG: %COUNT% >> "%REPORT%"

REM --- Bay Hardware: thoi gian tai log. Mbps chia 8 = MB/s ---
set /a SIZE_MB=500
set /a SPEED_MBPS=100
set /a TIME_SEC=SIZE_MB*8/SPEED_MBPS
echo Uoc tinh tai file log %SIZE_MB% MB qua mang %SPEED_MBPS% Mbps (= 12.5 MB/s): khoang %TIME_SEC% giay >> "%REPORT%"
echo ==================================================== >> "%REPORT%"
echo. >> "%REPORT%"

echo [XONG] Da loc %COUNT% dong loi. Bao cao: backup\bao-cao-su-co.txt
pause
endlocal
