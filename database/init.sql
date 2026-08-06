-- ==============================================================================
-- Inisialisasi Database MySQL untuk Aplikasi Mading Digital
-- ==============================================================================
-- Aturan Arsitektur:
-- 1. Menggunakan standar karakter MySQL terbaru (utf8mb4) untuk mendukung emoji 
--    dan karakter multinasional.
-- 2. DILARANG KERAS menggunakan AUTO_INCREMENT untuk Primary Key.
-- 3. Seluruh Primary Key WAJIB menggunakan format string UUID (VARCHAR(36)).
-- ==============================================================================

-- 1. Buat database jika belum ada
CREATE DATABASE IF NOT EXISTS mading_digital
    CHARACTER SET utf8mb4 
    COLLATE utf8mb4_unicode_ci;

-- 2. Aktifkan database untuk penggunaan
USE mading_digital;

-- (Peringatan: Pembuatan tabel ditunda ke tahap berikutnya sesuai instruksi)

-- ==============================================================================
-- TABEL: users
-- Deskripsi: Menyimpan data autentikasi dan peran (role) pengguna.
-- ==============================================================================
CREATE TABLE IF NOT EXISTS users (
    id VARCHAR(36) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role ENUM('super_admin', 'guru', 'osis') NOT NULL DEFAULT 'osis',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ==============================================================================
-- TABEL: contents
-- Deskripsi: Menyimpan entitas visual (Galeri Slider) & alur persetujuan (Workflow Approval).
-- ==============================================================================
CREATE TABLE IF NOT EXISTS contents (
    id VARCHAR(36) PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    media_url TEXT NOT NULL,
    media_type ENUM('image', 'video') NOT NULL,
    duration_seconds INT DEFAULT 10,
    start_date DATETIME,
    end_date DATETIME,
    status ENUM('pending', 'approved', 'rejected') NOT NULL DEFAULT 'pending',
    notes TEXT,
    submitted_by VARCHAR(36) NOT NULL,
    approved_by VARCHAR(36),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ==============================================================================
-- TABEL: running_texts
-- Deskripsi: Menyimpan pengumuman teks berjalan (Running Text).
-- ==============================================================================
CREATE TABLE IF NOT EXISTS running_texts (
    id VARCHAR(36) PRIMARY KEY,
    text TEXT NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_by VARCHAR(36) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ==============================================================================
-- KONSTRAIN FOREIGN KEY: contents
-- ==============================================================================
ALTER TABLE contents
    ADD CONSTRAINT fk_contents_submitted_by
    FOREIGN KEY (submitted_by) REFERENCES users(id)
    ON DELETE CASCADE,
    ADD CONSTRAINT fk_contents_approved_by
    FOREIGN KEY (approved_by) REFERENCES users(id)
    ON DELETE SET NULL;

-- ==============================================================================
-- KONSTRAIN FOREIGN KEY: running_texts
-- ==============================================================================
ALTER TABLE running_texts
    ADD CONSTRAINT fk_running_texts_created_by
    FOREIGN KEY (created_by) REFERENCES users(id)
    ON DELETE CASCADE;

-- ==============================================================================
-- SEEDER DATA AWAL
-- ==============================================================================

-- Bangkitkan UUID untuk masing-masing user
SET @super_admin_id = UUID();
SET @guru_id = UUID();
SET @osis_id = UUID();

-- Catatan: Hash bcrypt di bawah ini merupakan representasi standar untuk kata sandi 'password'
SET @dummy_password_hash = '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi';

INSERT INTO users (id, name, email, password_hash, role) VALUES 
(@super_admin_id, 'Super Admin Mading', 'admin@smkkomputer.id', @dummy_password_hash, 'super_admin'),
(@guru_id, 'Muhamad Abdul Wahab', 'wahab@smkkomputer.id', @dummy_password_hash, 'guru'),
(@osis_id, 'Anggota OSIS', 'osis@smkkomputer.id', @dummy_password_hash, 'osis');

-- Memasukkan pengumuman teks berjalan (Membuktikan relasi Foreign Key dari Guru)
INSERT INTO running_texts (id, text, is_active, created_by) VALUES 
(UUID(), 'Selamat datang di Mading Digital SMK Komputer Indonesia, Bogor!', TRUE, @guru_id),
(UUID(), 'Peringatan: Seluruh siswa harap menjaga kebersihan lingkungan sekolah.', TRUE, @guru_id);

-- Memasukkan data galeri (Membuktikan relasi Foreign Key dari OSIS)
INSERT INTO contents (id, title, media_url, media_type, duration_seconds, start_date, end_date, status, submitted_by) VALUES
(UUID(), 'Poster Lomba Kemerdekaan', '/uploads/images/poster_lomba.jpg', 'image', 15, NOW(), DATE_ADD(NOW(), INTERVAL 7 DAY), 'pending', @osis_id);

-- ==============================================================================
-- OPTIMASI INDEX (PERFORMA QUERY)
-- ==============================================================================

-- 1. Optimasi Query Workflow Approval (Mencari konten yang berstatus pending/approved)
CREATE INDEX idx_contents_status ON contents(status);

-- 2. Optimasi Query Galeri Slider (Mempercepat filter penayangan berdasarkan waktu)
-- Compound Index (Status + Waktu) untuk query super cepat di Frontend
CREATE INDEX idx_contents_slider_active ON contents(status, start_date, end_date);

-- 3. Optimasi Query Teks Berjalan (Mencari teks yang aktif)
CREATE INDEX idx_running_texts_is_active ON running_texts(is_active);

-- 4. Optimasi Foreign Key (Mencegah Full Table Scan saat penghapusan ON DELETE CASCADE)
CREATE INDEX idx_contents_submitted_by ON contents(submitted_by);
CREATE INDEX idx_contents_approved_by ON contents(approved_by);
CREATE INDEX idx_running_texts_created_by ON running_texts(created_by);

-- Catatan: Kolom users.email tidak perlu dibuatkan CREATE INDEX baru,
-- karena constraint UNIQUE secara otomatis menciptakan INDEX eksklusif pada MySQL InnoDB.
