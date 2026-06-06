# Plan: Redesign sebagai AstraPay Super-App dengan OtoCare di dalamnya

## Konsep
Ubah tampilan pertama dari "OtoCare role selector" menjadi **AstraPay Home Screen** (seperti super-app e-wallet), lalu OtoCare jadi salah satu fitur/menu di dalam AstraPay.

## Perubahan

### 1. `lib/main.dart` — Ganti RoleSelectorScreen → AstraPayHome
- Home screen AstraPay dengan:
  - Header: logo AstraPay, nama user, notifikasi
  - Balance card: saldo AstraPay (Rp 1.250.000), tombol Top Up / Transfer / Withdraw
  - Quick action row: Pay, Scan QR, Transfer, Top Up
  - **Services Grid**: OtoCare (bengkel), Pulsa, PLN, BPJS, dll
  - Promo banner slider
  - Bottom nav: Home, History, QR Pay, Inbox, Profile

### 2. Tap "OtoCare" di services grid → navigasi ke role selector (Pemilik Motor / Bengkel UMKM) yang sudah ada

### 3. Update theme — pastikan warna tetap AstraPay biru (#1565D8)

## File yang diubah
- `lib/main.dart` — rewrite jadi AstraPay super-app shell
- Semua fitur OtoCare (customer_main, umkm_main, dll) tetap sama, hanya entry point berubah

## Hasil Akhir
User buka app → lihat AstraPay Home (saldo, fitur e-wallet) → tap "OtoCare" → masuk ke OtoCare (pilih role → customer/UMKM)
