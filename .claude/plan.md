# Plan: 5 Fitur "Out of the Box" OtoCare

## Arsitektur Saat Ini
- **Customer tabs**: Home, Bengkel, QR Pay, Riwayat, Reminder (5 tabs)
- **UMKM tabs**: Appointment, Katalog, Income, Rating, Profile
- Pattern: StatelessWidget/StatefulWidget, bottom sheets, Navigator.push
- Theme: AppTheme dengan gradient biru AstraPay

---

## Fitur 1: 🚨 SOS Darurat Mogok (Tombol Panik)
**File baru**: `lib/screens/customer/sos_screen.dart`
**Modifikasi**: `home_tab.dart` (tambah tombol SOS di header)

**Behavior**:
- Tombol merah "SOS Mogok" yang floating di home
- Tap → screen SOS:
  - Animasi "Mencari bengkel terdekat..."
  - Deteksi lokasi (mock: koordinat Bandung)
  - Menampilkan 3 bengkel terdekat yang bisa datang
  - Estimasi waktu kedatangan (5-15 menit)
  - Tombol "Panggil Sekarang" → konfirmasi → "Mekanik sedang dalam perjalanan"
  - Live tracking mock (progress indicator)

---

## Fitur 2: 📊 Vehicle Health Score (Skor Kesehatan Motor)  
**File baru**: `lib/screens/customer/health_score_screen.dart`
**Modifikasi**: `home_tab.dart` (tambah card health score di bawah vehicle card)

**Behavior**:
- Circular gauge 0-100% (warna gradasi merah→kuning→hijau)
- Skor saat ini: 72% (berdasarkan komponen)
- Breakdown per komponen:
  - Oli Mesin: 35% (kritis!)
  - Kampas Rem: 70%
  - Ban: 85%
  - V-Belt: 90%
  - Busi: 45% (perlu perhatian)
- Rekomendasi AI: "Segera ganti oli mesin. Motor Anda sudah melewati batas 5000km."
- Tombol "Booking Service" langsung ke bengkel terdekat

---

## Fitur 3: 🎮 Gamifikasi & Rewards
**File baru**: `lib/screens/customer/rewards_screen.dart`
**Modifikasi**: `home_tab.dart` (tambah section "OtoCare Points")

**Behavior**:
- Poin terkumpul: 2.350 pts
- Level: "Motor Terawat 🥈" (Silver)
- Progress bar ke level berikutnya (Gold = 5.000 pts)
- Streak: "🔥 3 bulan service tepat waktu!"
- Badges yang sudah didapat:
  - ✅ Service Pertama
  - ✅ Pembayaran Digital
  - ✅ Review Bengkel
  - 🔒 Motor Sehat 6 Bulan (locked)
- Cara tukar: Tukar 1000pts → voucher cashback Rp25.000 AstraPay
- Milestone rewards chart

---

## Fitur 4: 💬 Chat Mekanik (Real-time Chat)
**File baru**: `lib/screens/customer/chat_screen.dart`
**Modifikasi**: `bengkel_tab.dart` (tambah tombol chat di bengkel card)

**Behavior**:
- Chat interface WhatsApp-style
- Pre-filled bengkel info di header
- Quick reply buttons: "Estimasi biaya?", "Bisa hari ini?", "Antar jemput?"
- Mock conversation:
  - User: "Berapa biaya ganti oli Vario 160?"
  - Mekanik: "Untuk Honda Vario 160, ganti oli Yamalube Gold Rp 85.000 termasuk jasa. Bisa datang hari ini pak?"
  - User: "Bisa antar jemput?"
  - Mekanik: "Bisa pak, biaya antar jemput Rp 20.000. Mau dijemput jam berapa?"
- Tombol "Booking dari Chat" → langsung buat appointment

---

## Fitur 5: 🤖 AI Prediksi & Tips (Smart Assistant)
**File baru**: `lib/screens/customer/ai_assistant_screen.dart`
**Modifikasi**: `home_tab.dart` (tambah "AI Tips" card)

**Behavior**:
- Card "💡 Tips Hari Ini" di home (rotating tips)
- Full screen: OtoCare AI Assistant
  - Analisis riwayat service → prediksi kapan harus service berikutnya
  - Estimasi biaya total maintenance setahun
  - Perbandingan biaya antar bengkel
  - Tips hemat: "Ganti oli sendiri bisa hemat Rp 35.000/bulan"
  - Alert: "Berdasarkan pola Anda, bulan depan kemungkinan perlu ganti kampas rem"

---

## Urutan Implementasi (satu per satu, tanpa ganggu existing)

1. **Vehicle Health Score** — visual paling impactful, taruh di home
2. **SOS Darurat Mogok** — fitur "wow" untuk demo
3. **Gamifikasi & Rewards** — engagement layer
4. **Chat Mekanik** — dari bengkel detail  
5. **AI Assistant** — smart assistant card

Setiap fitur:
- File baru terpisah (tidak edit file existing berlebihan)
- Hanya tambah entry point (1-2 baris) di file existing
- Build & verify setelah setiap fitur
- Deploy per fitur
