-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Feb 22, 2024 at 02:59 AM
-- Server version: 10.3.39-MariaDB-0ubuntu0.20.04.2
-- PHP Version: 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `digitalibrary`
--

-- --------------------------------------------------------

--
-- Table structure for table `buku`
--

CREATE TABLE `buku` (
  `id_buku` int(11) NOT NULL,
  `judul` varchar(255) NOT NULL,
  `penulis` varchar(255) NOT NULL,
  `penerbit` varchar(255) NOT NULL,
  `tahun_terbit` int(11) NOT NULL,
  `stok` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `buku`
--

INSERT INTO `buku` (`id_buku`, `judul`, `penulis`, `penerbit`, `tahun_terbit`, `stok`) VALUES
(2, 'garis luka', 'khairani ihsan', 'black swan', 2023, 7),
(6, 'matematika', 'lili lolo', 'gramedia', 2013, 13),
(7, 'santri pilihan bunda', 'orang', 'gramedia', 2021, 10),
(8, 'si kancil', 'makhluk hidup', 'pt manusia', 2016, 11),
(14, 'putri salju', 'fuadahx', 'fuad', 2090, 10),
(16, 'ku menangis membayangkan', 'nisa', 'yuli', 2024, 10),
(17, 'garis tangan', 'millla', 'yuli', 2026, 10);

-- --------------------------------------------------------

--
-- Table structure for table `kategoribuku`
--

CREATE TABLE `kategoribuku` (
  `id_kategori` int(11) NOT NULL,
  `nama_kategori` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `kategoribuku`
--

INSERT INTO `kategoribuku` (`id_kategori`, `nama_kategori`) VALUES
(4, 'pelajaran '),
(8, 'dongeng'),
(11, 'novel horor'),
(12, 'novel romance'),
(18, 'fiksi remaja');

-- --------------------------------------------------------

--
-- Table structure for table `kategoribuku_relasi`
--

CREATE TABLE `kategoribuku_relasi` (
  `id_kategoribuku` int(11) NOT NULL,
  `id_buku` int(11) NOT NULL,
  `id_kategori` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `kategoribuku_relasi`
--

INSERT INTO `kategoribuku_relasi` (`id_kategoribuku`, `id_buku`, `id_kategori`) VALUES
(4, 6, 4),
(10, 8, 8),
(16, 7, 12),
(31, 14, 8);

-- --------------------------------------------------------

--
-- Table structure for table `peminjaman`
--

CREATE TABLE `peminjaman` (
  `id_peminjaman` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `id_buku` int(11) NOT NULL,
  `tanggal_peminjaman` date NOT NULL,
  `tanggal_pengembalian` date NOT NULL,
  `status_peminjaman` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `peminjaman`
--

INSERT INTO `peminjaman` (`id_peminjaman`, `id_user`, `id_buku`, `tanggal_peminjaman`, `tanggal_pengembalian`, `status_peminjaman`) VALUES
(5, 6, 8, '2024-02-29', '2024-02-29', 2),
(6, 11, 2, '2024-02-15', '2024-02-15', 2),
(7, 6, 6, '2024-02-08', '2024-02-22', 2),
(8, 13, 6, '2024-02-01', '2024-02-13', 2),
(9, 14, 7, '2024-01-30', '2024-02-15', 2),
(10, 6, 6, '2024-02-15', '2024-02-22', 2),
(11, 11, 7, '2024-02-17', '2024-02-20', 2),
(12, 11, 8, '2024-02-10', '2024-02-18', 2),
(13, 11, 2, '2024-02-19', '2024-02-26', 1),
(14, 11, 2, '2024-02-21', '2024-02-22', 1),
(15, 11, 2, '2024-02-21', '2024-02-22', 1);

--
-- Triggers `peminjaman`
--
DELIMITER $$
CREATE TRIGGER `dikembalikan` AFTER UPDATE ON `peminjaman` FOR EACH ROW BEGIN
UPDATE buku SET buku.stok = buku.stok + 1 WHERE buku.id_buku = NEW.id_buku;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `kembalikan` AFTER UPDATE ON `peminjaman` FOR EACH ROW BEGIN
UPDATE buku SET buku.stok = buku.stok + 1 WHERE buku.id_buku = NEW.id_buku;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `pinjam` AFTER INSERT ON `peminjaman` FOR EACH ROW BEGIN
UPDATE buku SET buku.stok = buku.stok - 1 WHERE buku.id_buku = NEW.id_buku;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `ulasanbuku`
--

CREATE TABLE `ulasanbuku` (
  `id_ulasan` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `id_buku` int(11) NOT NULL,
  `ulasan` text NOT NULL,
  `rating` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ulasanbuku`
--

INSERT INTO `ulasanbuku` (`id_ulasan`, `id_user`, `id_buku`, `ulasan`, `rating`) VALUES
(16, 11, 2, 'alur ceritanya asik', 10);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id_user` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `nama_lengkap` varchar(255) NOT NULL,
  `alamat` text NOT NULL,
  `level` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id_user`, `username`, `password`, `email`, `nama_lengkap`, `alamat`, `level`) VALUES
(2, 'admin', '21232f297a57a5a743894a0e4a801fc3', 'admin@gmail.com', 'admin', '-', 1),
(3, 'sad', '49f0bad299687c62334182178bfd75d8', 'sad@gmail.com', 'sad bgt', 'desa ovt', 2),
(4, '1234', 'd41d8cd98f00b204e9800998ecf8427e', '1234', '1234', 'merakurak', 1),
(6, 'siti', 'db04eb4b07e0aaf8d1d477ae342bdff9', 'siti@gmail.com', 'siti', '-', 3),
(11, 'qwe', '76d80224611fc919a5d54f0ff9fba446', 'qwe@gmail.com', 'qweeer', 'merakurak', 3),
(12, 'salma', 'f6852b2a3ac0cd7e69c801f69eddb57a', 'salma@gmail.com', 'salamaa', 'pongan', 2),
(13, 'Nikmah', '8d59cf1fdfb9d3bcf4a5af5394273b0f', 'Nikmah@gmail.com', 'Nikmah', 'Jatim', 3),
(14, 'fuadahx', 'e0c978b6825fcf02cc8745cd3b1b1376', 'fuadahx@gmail.com', 'fuadahx', 'Jatim', 3),
(15, 'petugas', 'afb91ef692fd08c445e8cb1bab2ccf9c', 'petugas@gmail.com', 'petugas', '-', 2);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `buku`
--
ALTER TABLE `buku`
  ADD PRIMARY KEY (`id_buku`);

--
-- Indexes for table `kategoribuku`
--
ALTER TABLE `kategoribuku`
  ADD PRIMARY KEY (`id_kategori`);

--
-- Indexes for table `kategoribuku_relasi`
--
ALTER TABLE `kategoribuku_relasi`
  ADD PRIMARY KEY (`id_kategoribuku`),
  ADD KEY `id_buku` (`id_buku`),
  ADD KEY `id_kategori` (`id_kategori`);

--
-- Indexes for table `peminjaman`
--
ALTER TABLE `peminjaman`
  ADD PRIMARY KEY (`id_peminjaman`),
  ADD KEY `id_user` (`id_user`),
  ADD KEY `id_buku` (`id_buku`);

--
-- Indexes for table `ulasanbuku`
--
ALTER TABLE `ulasanbuku`
  ADD PRIMARY KEY (`id_ulasan`),
  ADD KEY `id_user` (`id_user`),
  ADD KEY `id_buku` (`id_buku`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id_user`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `buku`
--
ALTER TABLE `buku`
  MODIFY `id_buku` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `kategoribuku`
--
ALTER TABLE `kategoribuku`
  MODIFY `id_kategori` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `kategoribuku_relasi`
--
ALTER TABLE `kategoribuku_relasi`
  MODIFY `id_kategoribuku` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `peminjaman`
--
ALTER TABLE `peminjaman`
  MODIFY `id_peminjaman` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `ulasanbuku`
--
ALTER TABLE `ulasanbuku`
  MODIFY `id_ulasan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `kategoribuku_relasi`
--
ALTER TABLE `kategoribuku_relasi`
  ADD CONSTRAINT `kategoribuku_relasi_ibfk_1` FOREIGN KEY (`id_buku`) REFERENCES `buku` (`id_buku`);

--
-- Constraints for table `peminjaman`
--
ALTER TABLE `peminjaman`
  ADD CONSTRAINT `peminjaman_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `user` (`id_user`),
  ADD CONSTRAINT `peminjaman_ibfk_2` FOREIGN KEY (`id_buku`) REFERENCES `buku` (`id_buku`);

--
-- Constraints for table `ulasanbuku`
--
ALTER TABLE `ulasanbuku`
  ADD CONSTRAINT `ulasanbuku_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `user` (`id_user`),
  ADD CONSTRAINT `ulasanbuku_ibfk_2` FOREIGN KEY (`id_buku`) REFERENCES `buku` (`id_buku`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
