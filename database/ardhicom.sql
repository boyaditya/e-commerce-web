-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 03 Jan 2025 pada 17.19
-- Versi server: 10.4.28-MariaDB
-- Versi PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ardhicom`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `addresses`
--

CREATE TABLE `addresses` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `recipients_name` varchar(100) NOT NULL,
  `phone_number` varchar(20) NOT NULL,
  `street_address` varchar(255) NOT NULL,
  `city` varchar(100) NOT NULL,
  `state` varchar(100) DEFAULT NULL,
  `postal_code` varchar(20) NOT NULL,
  `country` varchar(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data untuk tabel `addresses`
--

INSERT INTO `addresses` (`id`, `user_id`, `recipients_name`, `phone_number`, `street_address`, `city`, `state`, `postal_code`, `country`, `created_at`, `updated_at`) VALUES
(12, 9, '123', '123', '123', '123', '123', '123', '123', '2025-01-03 16:17:42', '2025-01-03 16:17:42');

-- --------------------------------------------------------

--
-- Struktur dari tabel `carts`
--

CREATE TABLE `carts` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Struktur dari tabel `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data untuk tabel `categories`
--

INSERT INTO `categories` (`id`, `name`, `description`) VALUES
(1, 'Headset', 'Untuk mendengarkan lagu'),
(2, 'Keyboard', 'Keyboard'),
(3, 'Mouse', 'Mouse'),
(4, 'Microphone', 'Microphone'),
(5, 'Gamepad', 'Gamepad'),
(6, 'Mousepad', 'Mousepad Deskmat');

-- --------------------------------------------------------

--
-- Struktur dari tabel `payments`
--

CREATE TABLE `payments` (
  `id` int(11) NOT NULL,
  `transaction_id` int(11) DEFAULT NULL,
  `amount` decimal(10,2) NOT NULL,
  `payment_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `payment_method` enum('cod','va_bca','va_bni','va_mandiri','va_bri','va_permata','store_alfamart','store_indomaret') NOT NULL,
  `status` enum('pending','verified','rejected') DEFAULT 'pending',
  `verified_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data untuk tabel `payments`
--

INSERT INTO `payments` (`id`, `transaction_id`, `amount`, `payment_date`, `payment_method`, `status`, `verified_by`, `created_at`, `updated_at`) VALUES
(51, 98, 1311000.00, '2025-01-03 09:18:07', 'va_bri', '', NULL, '2025-01-03 16:18:07', '2025-01-03 16:18:07');

-- --------------------------------------------------------

--
-- Struktur dari tabel `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `stock` int(11) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data untuk tabel `products`
--

INSERT INTO `products` (`id`, `name`, `description`, `price`, `stock`, `category_id`, `image_url`, `created_at`, `updated_at`) VALUES
(1, 'Rexus Headset Daxa Sedna', 'Headset Daxa Sedna hadir dengan teknologi Ultimate Triple Connection, mendukung Bluetooth 5.2, Dongle 2.4G, dan USB Cable, memberikan fleksibilitas konektivitas untuk Anda yang selalu aktif. Tersedia dalam dua pilihan warna elegan, Midnight Black dan Daylight White, serta dilengkapi dengan microphone ganda yang dapat dilepas pasang. Dengan kapasitas baterai sebesar 400mAh, headset ini menawarkan kenyamanan penggunaan hingga 50 jam dalam mode Bluetooth dan 25 jam dalam mode gaming. Bobotnya yang ringan, hanya 185g, membuatnya ideal untuk penggunaan jangka panjang, sementara earpad berbahan kain memberikan kenyamanan maksimal. Kemudahan portabilitas didukung dengan desain lipat serta hardcase yang disediakan, headset ini menghadirkan kombinasi performa audio unggul dan kenyamanan penggunaan di setiap situasi.\n\n- Ultimate Triple Connection (Bluetooth 5.2, Dongle 2.4G, USB Cable)\n- ⁠Available in 2 Color : Midnight Black & Daylight White\n- ⁠Detachable Dual Microphone (Built-in and Gaming)\n- 2,5 hours Charging Time & Bigger Batery Capacity: 400mAh Lithium Battery\n- 50hrs for Bluetooth Mode, 25hrs for Gaming Mode\n- Lightweight Headset; Only 185g\n- Maximum Comfort with Fabric Material Earpad\n- Low Latency for 2.4GHz mode\n- Transmission Distance up to 10m\n- ⁠Easy to Carry with Hard Case\n- ⁠Offers Convenient Portability Foldable Headset\n\n[FREE STAND DIBERIKAN SELAMA STOK MASIH ADA]', 589000.00, 12, 1, 'headset01.png', '2024-10-27 09:35:47', '2024-12-25 22:53:03'),
(2, 'Logitech Pro X 2 Lightspeed Wireless', 'DIMENSI\r\nLebar: 176 mm\r\nTebal: 95 mm\r\nTinggi: 189 mm\r\nBerat: 345 g\r\nPanjang kabel pengisian daya: 1,8 m\r\nSPESIFIKASI TEKNIS\r\nHEADPHONE\r\nDriver: Graphene 50 mm\r\nMagnet: Neodymium\r\nRespons Frekuensi: 20 Hz-20 KHz\r\nImpedansi: 38 Ohm (passive): 38 Ohms\r\nSensitivitas: 87.8 dB SPL @ 1 mW & 1 cm\r\nBAHAN\r\nFork: Aluminum\r\nHeadband: Baja\r\nEar dan head pad: Memory Foam Leatherette\r\nEar pad tambahan: Memory Foam Cloth\r\nPola Penangkapan Mikrofon: Cardioid (Unidireksional)\r\nJenis: Electret Condenser\r\nUkuran: 6 mm\r\nRespons Frekuensi: 100 Hz-10 KHz\r\nWIRELESS\r\nDaya Tahan Baterai (dapat diisi ulang): up to 50h\r\nJangkauan wireless: up to 30 m\r\nJenis Koneksi: 2.4GHz LIGHTSPEED\r\nINFORMASI GARANSI\r\nGaransi Hardware Terbatas 2 Tahun\r\nNOMOR SUKU CADANG\r\nPutih : 981-001270\r\nHitam : 981-001264\r\n\r\nPC COMPATIBLE\r\nPC dengan Windows® 10 atau versi terbaru dan port USB 2.0 Akses internet untuk Software Logitech G HUB.\r\nCONSOLE COMPATIBLE\r\nPlayStation® 5 dan PlayStation 4 (hanya USB wireless stereo sound), Nintendo Switch (wireless stereo sound saat docking).\r\n\r\nIsi Kemasan\r\nGaming headset PRO X 2 LIGHTSPEED\r\nMemory foam leatherette ear pad\r\nMemory foam cloth ear pad ekstra\r\nAdaptor USB-A LIGHTSPEED Wireless dengan port 3,5 mm\r\nMikrofon yang dapat dilepaskan dengan foam windscreen\r\nKabel USB-A ke USB-C\r\nKabel 3,5 mm\r\ntas penyimpanan yang lembut\r\nDokumentasi pengguna', 3299000.00, 10, 1, 'headset02.png', '2024-10-27 09:37:24', '2024-12-25 22:47:50'),
(3, 'HyperX Cloud III Wired Headset Gaming', 'Technical Specs\r\n\r\nHeadphone Specifications\r\n\r\nDriver: Dynamic, 53mm with Neodymium magnets\r\nForm Factor: Over ear, circumaural, closed back.\r\nFrequency Response: 10Hz-21kHz\r\nSensitivity: -42dBV (0dB=1V/Pa at 1kHz)\r\nT.H.D: < 2%\r\nFrame Type: Aluminum\r\nEar Cushions: Memory foam and premium leatherette\r\nMicrophone Specification\r\nElement: Electret condenser microphone\r\nPolar Pattern: Uni-directional, Noise-cancelling\r\nSensitivity: -42dBV (0dB=1V/Pa at 1kHz)\r\n\r\nConnections and Features\r\n\r\nUSB Specification: USB 2.0\r\nBit-Depth: 16 bit, 24 bit\r\nAudio Controls: Onboard audio controls\r\nPhysical Specifications\r\nWeight: 0.67lb; Weight with microphone: 0.70lb\r\nCable Length (imperial) and type: 3.93ft headset cable; 4.26ft USB dongle cable | USB cable', 1250000.00, 21, 1, 'headset03.png', '2024-12-25 22:46:06', '2024-12-25 22:47:54'),
(4, 'Razer BlackShark V2 Pro Wireless', 'TECH SPECS\r\n\r\nFREQUENCY RESPONSE\r\n12 Hz – 28 kHz\r\n\r\nIMPEDANCE\r\n32 Ω\r\n\r\nSENSITIVITY\r\n100 dBSPL / mW @ 1 kHz by HATS\r\n\r\nDRIVER SPECIFICATIONS\r\n50 mm\r\n\r\nDRIVER TYPE\r\nRazer™ TriForce Titanium\r\n\r\nEARCUPS\r\nOval Ear Cushions\r\n\r\nINNER EARCUP DIAMETER\r\n62 mm x 42 mm / 2.44 x 1.65 in\r\n\r\nEARPADS MATERIAL\r\nPressure-Relieving Memory Foam\r\n\r\nNOISE CANCELLING\r\nAdvanced Passive Noise Isolation\r\n\r\nCONNECTION TYPE\r\nType A Wireless (2.4 GHz), Bluetooth 5.2\r\n\r\nCABLE LENGTH\r\nNone\r\n\r\nAPPROXIMATE WEIGHT\r\nApprox. 320 g / 0.71 lbs\r\n\r\nMICROPHONE STYLE\r\nDetachable Super Wideband\r\n\r\nPICK-UP PATTERN\r\nUnidirectional\r\n\r\nMICROPHONE FREQUENCY RESPONSE\r\n100 Hz – 10 kHz\r\n\r\nMICROPHONE SENSITIVITY (@1KHZ)\r\n-42 ± 3 dBV / PA, 1 kHz\r\n\r\nVIRTUAL SURROUND ENCODING\r\nTHX Spatial Audio\r\n\r\nVOLUME CONTROL\r\nVolume up and down\r\n\r\nOTHER CONTROLS\r\n2.4 GHz Wireless and Bluetooth Toggle (SmartSwitch)\r\nVolume up and down\r\nMic mute on/off toggle\r\nAudio profiles switcher\r\n\r\nBATTERY LIFE\r\nUp to 70 hours\r\n\r\nLIGHTING\r\nNone\r\n\r\nCOMPATIBILITY\r\nPC (Type A 2.4 GHz, Bluetooth 5.2)\r\nPlayStation (Type A 2.4 GHz)\r\nMobile Devices (Supporting Type A or Bluetooth 5.2)\r\nAndroid & iOS', 3199000.00, 7, 1, 'headset04.png', '2024-12-25 22:47:25', '2024-12-25 22:48:01'),
(5, 'Fantech SONATA MH90 Gaming', 'SOFT MEMORY FOAM\r\nEarcup Sonata MH90 terbungkus dengan sempurna dengan MEMORY FOAM premium yang super empuk agar selalu fokus dalam mode kompetitif\r\n\r\nMulti-Platform Compatibility\r\nDengan Single 3.5mm TRRS Jack GOLD PLATED kamu bebas gunakan di perangkat mana saja!\r\n\r\nBIGGER & MORE PRECISE\r\nDriver unit Sonata MH90 berukuran 53mm yang lebih besar dari headset gaming pada umumnya menghasilkan performa suara yang lebih luas dan presisi untuk Gaming maupun keperluan Professional Audio.\r\n\r\nIn-Line Audio Control\r\nSonata MH90 dilengkapi dengan Audio Control minimalis di kabel headset yang memudahkan kalian mengatur volume dan mute microphone dengan satu gerakan\r\n\r\nDurable Build\r\nFrame dari Sonata MH90 ini terbuat dari Bahan Aluminium yang di desain khusus untuk bisa bertahan lama bagi Gamers Harian yang pemakaian berjam jam\r\n\r\nLIGHTWEIGHT COMFORT\r\nMeski terbuat dari bahan aluminium yang kokoh tidak membuat headset ini berat. Total berat hanya 266gr akan membuat kalian tidak terbebani saat pemakaian durasi lama seharian\r\n\r\nDetachable Microphone & Noise Cancelling\r\nMicrophone yang fleksible dan bisa dilepas pasang\r\n\r\nSpesifikasi :\r\n- Driver Unit : 53mm\r\n- Speaker Sensitivity : 110±3dB\r\n- Speaker Frequency Response : 20-20kHz\r\n- Speaker Impedance : 64Ω±15%\r\n- Microphone Sensitivity : -42±3dB\r\n- Microphone directivity : Omni Direction', 459000.00, 31, 1, 'headset05.png', '2024-12-25 22:49:27', '2024-12-25 22:49:27'),
(6, 'Logitech G435 Lightspeed Wireless Gaming Headset', 'SPECIFICATIONS\r\nPHYSICAL SPECIFICATIONS\r\nCOMPATIBILITY:\r\nLIGHTSPEED Wireless: USB 2.0 port (type A port). PC with window® 10 or later, macOS® X 10.14 or later, PlayStation 5, or PlayStation 4\r\nBluetooth: Devices with Bluetooth audio connectivity\r\nDolby Atmos, Tempest 3D AudioTech and Windows Sonic Spatial Sound compatible\r\n\r\nHEADPHONE\r\nWeight: 5.8 oz ( 165 grams)\r\nDimensions: 6.4×6.7×2.8 in (163×170×71 mm)\r\nAudio Drivers: 1.57 in (40 mm)\r\nFrequency response: 20 Hz-20 KHz\r\nImpedance: 45 Ohms (passive)\r\nSensitivity: 83.1 dB SPL/mW\r\nMax volume: <100 dB with optional limiter at <85 dB\r\n\r\nDUAL EMBEDDED BEAMFORMING MICROPHONES:\r\nFrequency response: 100 Hz - 8 KHz\r\n\r\nWIRELESS RANGE\r\nUp to 10 meters (33 ft) via LIGHTSPEED USB receiver or Bluetooth\r\n\r\nBATTERY (RECHARGEABLE):\r\nPlay time: 18 hours\r\nCharging port: USB-C\r\nCharging cable: USB-A to USB-C\r\n\r\nSUSTAINABILITY SPECIFICATIONS\r\nRECYCLED PLASTIC\r\nPlastic parts include a minimum of 22% certified post-consumer recycled plastic by weight, giving a second life to end-of-life electronics and contributing to a more circular economy.\r\n\r\nRESPONSIBLE PACKAGING\r\nPaper packaging comes from FSC-certified forests. By choosing this product, you are supporting responsible management of the world’s forests.\r\n\r\nCERTIFIED CARBONNEUTRAL\r\nFor every product you buy, we finance high-quality certified carbon offsets, to reduce the carbon impact of the product to zero.\r\n\r\nIN THE BOX\r\nG435 Headset\r\nLIGHTSPEED wireless USB-A receiver\r\nUSB-C to USB-A charging cable\r\nUser Documentation\r\n\r\nWARRANTY INFORMATION\r\n2-Year Limited', 929000.00, 11, 1, 'headset06.png', '2024-12-25 22:49:53', '2024-12-25 22:50:34'),
(7, 'dbE Otogai 7.1 Virtual Surround Gaming Headset with ENC Microphone', 'dbE Otogai adalah headset gaming generasi baru dari dbE. Sesuai dengan tagline produknya “Guided by Sound”, kami mendesain suara otogai dengan detail berlimpah dan imaging yang sangat akurat di kelas harganya.\r\n\r\nDidukung dengan dynamic speaker berukuran 50mm, Otogai menghadirkan suara dengan detail yang berlimpah sehingga arah suara footstep lawan bisa terdengar dengan jelas.\r\nSelain performa suara yang menakjubkan Otogai juga memiliki kenyamanan yang luar biasa, headband yang empuk dikombinasikan dengan earpad over-ear empuk dan besar berukuran sekitar 11.5cm x 8.5cm tidak akan menekan telinga sehingga memberikan kenyamanan extra untuk push rank dalam waktu lama.\r\n\r\nUntuk komunikasi, dbE Otogai menggunakan microphone dengan fitur ENC sehingga penggunanya bisa berkomunikasi dengan jelas dengan rekan timnya di tempat yang relatif ribut sekalipun.\r\nDengan desain kombinasi material metal & plastik memberikan kesan industrial pada Otogai, warna stealthily black membuatnya sangat mudah dipadu padankan dengan bermacam macam setup, ditambah single color LED strip membuat Otogai terkesan futuristic dan cocok dengan bermacam macam game masa kini.', 385000.00, 22, 1, 'headset07.png', '2024-12-25 22:52:42', '2024-12-25 22:52:42'),
(8, 'Steelseries Arctis Nova 1 Multi-platform Gaming Headset', 'BARANG NEW DAN BERGARANSI RESMI 1 TAHUN\r\n\r\n- The Nova Acoustic System features custom-designed High Fidelity Drivers for superior audio quality\r\n- Ultra lightweight headset with 4-points of adjustability in the ComfortMAX System for the perfect fit\r\n- ClearCast Gen 2 noise-cancelling mic reduces background sounds for clear communication\r\n- Suitable for any PC and console platform with a 3.5mm jack, great for mobile devices on the go\r\n- Convenient onboard controls with a volume dial and voice mute button on the headset\r\n- Pinpoint your enemy\'s location long before you see them with Sonar a breakthrough in gaming sound\r\n\r\nComfortMAX System\r\nLook good and feel good, no cap. The Arctis Nova 1 is designed to fit any head, with a durable, lightweight build and 4-points of adjustment. The stretchy band distributes weight evenly.\r\n\r\nUltra Lightweight\r\nDrip check. Stand out anywhere with a premium, high-quality design that weighs just 236g, ensuring comfortable wear while gaming or vibing on the go.\r\n\r\nAirWeave Memory Foam\r\nKeep yourself cool and & comfy with AirW\r\n\r\nMulti-System Support\r\nYour Arctis Nova 1 travels with you to any gaming world, as the 3.5mm jack hooks up to any platform. Whether it\'s your PC, PlayStation, Xbox, Switch, or Mac, immersive sound quality is there for you. It\'s also the perfect headset for your mobile device to vibe on the go.\r\n\r\nCompatibility :\r\nPC, Mac, PS4, PS5, Switch, Mobile and Xbox\r\n\r\nBox Content :\r\nArctis Nova 1 Headset, 3.5mm to 3.5mm Audio Cable - 5 pole to 4 pole (4 ft / 1.2m), Dual 3.5mm Extension Cable (5 ft/ 1.5m), Product Information Guide', 977000.00, 3, 1, 'headset08.png', '2024-12-25 22:53:52', '2024-12-25 22:53:52'),
(9, 'Rexus Thundervox Stream HX28 - Wireless Gaming Headset', 'Wireless Bluetooth 5.0\r\nDriver 50mm\r\nIncluded Cable for Wired Mode\r\nFree Audio Coverter\r\nLow Latency in Gaming Mode\r\nDual Mode Gaming and Music\r\n\r\nSPECIFICATION\r\nWireless : BT V5.0\r\nWorking Distance : Up to 10M\r\nDriver : 50mm\r\nImpedance : 320 + 15%\r\nFrequency : 2.4GHz - 2.4835GHz\r\nWorking Time : 22 Hours\r\nBattery : 600mAh, Rechargeable\r\nStandby Time : Up to 200H\r\nPort : Type-C Charging Port\r\nCharging Requirements : DC 5V/1A', 408000.00, 41, 1, 'headset09.png', '2024-12-25 22:54:58', '2024-12-25 22:54:58'),
(10, 'Fantech Studio WHG03 / WHG-03 Wireless Gaming Headset Virtual 7.1', 'Specifications :\r\n\r\n•Connection Tri-Mode Bluetooth, Strikespeed™ Wireless, wired 3.5mm TRRS\r\n•7.1 surround sound\r\n•Playing Time up to 40 Hours Playback time\r\n•Battery Capacity 400mA\r\n•Charging Time Approx 2 hours\r\n•Weight 180+/3g\r\n•Software (Only Via Strikespeed™ Wireless)\r\n•Driver unit Size 50mm\r\n•Customizable EQ (with presets of custom tune)\r\n•Durable Flexible Headband', 549000.00, 9, 1, 'headset10.png', '2024-12-25 22:55:37', '2024-12-25 22:55:37'),
(11, 'Logitech Pro X TKL Lightspeed Tactile Keyboard Gaming Wireless', 'DIMENSI\r\nSPESIFIKASI FISIK\r\nTinggi: 34 mm\r\nLebar: 352 mm\r\nTebal: 150 mm\r\nSPESIFIKASI TEKNIS\r\nDesain tenkeyless terinspirasi pemain pro\r\nPencahayaan RGB LIGHTSYNC 1Fitur lanjutan memerlukan software Logitech G HUB. Download di LogitechG.com/GHUB\r\nProfil pencahayaan onboard 2Fitur lanjutan memerlukan software Logitech G HUB. Download di LogitechG.com/GHUB\r\nKabel data dan pengisian daya yang bisa dilepas 6 kaki\r\nReport rate 1 md\r\nWIRELESS\r\nDaya Tahan Baterai (dapat diisi ulang): maksimum 50 jam 3Mungkin bervariasi berdasarkan kondisi pengguna dan komputasi.\r\nJangkauan wireless: maksimum 10 m 4Mungkin bervariasi berdasarkan kondisi pengguna dan komputasi\r\n\r\nKOMPATIBILITAS\r\nPC dengan Windows® 10 atau versi terbaru dan port USB 2.0 Akses internet untuk Software Logitech G HUB.\r\nAkses internet untuk Software Logitech G HUB.', 2869000.00, 8, 2, 'keyboard01.png', '2024-12-25 22:57:13', '2024-12-25 22:57:13'),
(12, 'Ajazz AK870 AK-870 HE Wireless Gaming Keyboard Rapid Trigger Magnetic Switch Three Mode Connection', 'Ajazz AK870 HE Magnetic Switch Rapid Trigger TKL Mechanical Keyboard Three Mode RGB with 1.06-inch TFT Color Screen\r\n\r\nProduct Name : Ajazz AK870 HE Magnetic Switch Rapid Trigger TKL Mechanical Keyboard\r\nModel : AK870 HE\r\nProduct Size : 370x148x21mm\r\nStructure : Bottom Structure\r\nBacklight : South-facing RGB LED\r\nConnection Mode : Wireless 2.4G + Wired Type C + Bluetooth 5.1\r\nProduct Weight : 1050g\r\nKey layout : 84 Keys\r\nScreen and Knob : Advanced 1.06-inch TFT Color Screen + Knob Volume\r\nRT Adjustment Range : 0.2-2.5mm\r\nBattery : 4000mAh\r\nColor : STARRY NIGHT / THE FOG SEA\r\nSwitch : MAGNETIC SWITCH\r\nMounting Plate : Aluminium Plate\r\nKeycap Height : Cherry Profile\r\nKeycap Material : PBT Keycaps\r\nSupport System : Windows, Mac, Android\r\n\r\nSwitch\r\nSwitch Name : Rapid Trigger Magnetic Switch\r\nAdjustable accuracy : 0.1mm\r\nTrigger Travel : 100-12000\r\nSensor : 0.1-4mm\r\n\r\nPackage Content\r\nKeyboard*1\r\nType C Cable*1\r\nUser Manual*1\r\nDust Cover*1\r\nKeycap Puller*1\r\nSwitch Puller*1\r\nAdditional Keycaps &Switch*3\r\n\r\nSpecial Features Advanced 1.06-inch TFT Color Screen\r\nRobust Bottom Structure for Unmatched Stability\r\nHall Effect Magnetic Switches\r\nCustomizable Actuation\r\nRapid Trigger\r\nDynamic Keystrokes\r\nDual-Function Keys with Mod-Tap\r\nToggle Key\r\n\r\nAdvanced 1.06-inch TFT Color Screen\r\nStay informed and express your style with the keyboard\'s 1.06-inch TFT color screen that displays time, battery status, connection mode, and even custom GIFs. This interactive feature not only keeps you updated but also adds a personal touch to your gaming setup.', 1429000.00, 17, 2, 'keyboard02.png', '2024-12-25 22:58:13', '2024-12-25 22:58:13'),
(13, 'VortexSeries GT65 GT-65 BYON Wireless Gaming Keyboard Gasket Mount Tri Mode Connection', 'SPECIFICATION :\r\n- 65% Compact Layout with Rotary Knob\r\n- Innovative Gasket Mounted (Silicone Gasket Socks) Structure for Enhanced Typing Experience\r\n- Advanced Multi-Layered Sound Absorption Filling\r\n- Flex Cut PC Plate &PCB\r\n- Tri-Tone PBT DoubleShot Keycaps for Durability and Aesthetic Appeal\r\n- OEM Profile Keycaps for Comfortable Typing\r\n- South Facing LED per key with Adjustable RGB Backlighting for Stunning Visual Effects\r\n- Music Rythm Software Support\r\n- Software Configurable by Wireless Dongle Connection\r\n- Three-Mode Connectivity for Seamless Device Pairing ( Wired, Wireless 2.4g and Bluetooth 3 profile )\r\n- Hotswappable Universal 5 Pin for Effortless Key Switch Replacement\r\n- Expertly Tuned Stabilizers for Smooth and Consistent Keystrokes\r\n- High-Capacity 3000mAh Rechargeable Battery for Long-lasting Usage\r\n- Full Keys Anti Ghosting (NKRO)\r\n- Dimensions: 320mm*118mm*40mm, perfect for portability and comfort.\r\n\r\n* WHAT\'S IN THE BOX ?\r\n- GT65 BYON Keyboard\r\n- Type-C Cable\r\n- 2in1 Keycaps &Switch Puller\r\n- Extra Dark Plum Switch\r\n- Hard Plastic - Dust Cover\r\n- Soft CPE Plastic Cover\r\n- Manual Book\r\n\r\n*TIDAK DISARANKAN CHARGING MENGGUNAKAN ADAPTOR/CHARGER HP\r\n*TOOGLE HARAP DI OFF (TENGAH) KETIKA CHARGE KEYBOARD\r\n*DONGLE DISARANKAN DI PASANG AGAK JAUH DARI DEVICE WIRELESS/ADAPTER WIFI LAIN, UNTUK MENGHINDARI INTERFERENCE', 549000.00, 45, 2, 'keyboard03.png', '2024-12-25 22:59:36', '2024-12-25 22:59:36'),
(14, 'Steelseries Apex Pro TKL 2023 Wired Mechanical Gaming Keyboard', 'Key Switches\r\nOmniPoint Adjustable Mechanical\r\n\r\nSwitch Rating\r\nGuaranteed 100 Million Presses\r\n\r\nOn-Board Memory\r\n5 Custom Profiles\r\n\r\nProcessor\r\n32 bit ARM\r\n\r\nAdjustable Actuation Points\r\n0.2-3.8 mm\r\n\r\nConnection\r\nDetachable USB Type-C\r\n\r\nWidth\r\n355 mm / 14 in\r\n\r\nDepth\r\n128 mm / 5.04 in\r\n\r\nHeight\r\n42 mm / 1.65 in\r\n\r\nWeight\r\n960 g / 2.1 lbs\r\n\r\nHeight Adjustment\r\nRubber Tri Level Feet\r\n\r\nLighting\r\nPer Key RGB Illumination', 3417000.00, 2, 2, 'keyboard04.png', '2024-12-25 23:00:28', '2024-12-25 23:00:28'),
(15, 'Moonsgeek M1W Mechanical Keyboard 75%', 'MonsGeek first multi-mode pre-assembled aluminum keyboard – M1W, gradient keycap set made for south-facing gang.\r\n\r\n\r\n75% 82-Key Layout with Knob\r\nSouth-facing PCB\r\n2.4G Wireless & Bluetooth & USB-C Wired\r\nGradient PBT Keycaps\r\nNew 5-pin V3 Cream Yellow Pro Switches\r\nPoron Plate Foam & Case Foam\r\nPre-installed Purple Plate Mount Stabilizers\r\nRGB and Key Customization through MonsGeek Cloud Driver\r\nCoiled Cable\r\nSupport Mac OS / Windows', 2390000.00, 6, 2, 'keyboard05.png', '2024-12-25 23:02:54', '2024-12-25 23:03:48'),
(16, 'Noir Timeless82 75% Wireless OLED Mechanical Keyboard Gasket Mount ABS', 'Noir Timeless82 75% Wireless OLED Mechanical Keyboard Gasket Mount ABS\r\n\r\n- FEATURES\r\n• OLED Screen (Customizable)\r\n• Battery up to one month\r\n• Gasket Mount (Silicone)\r\n• RGB Underglow\r\n• Custom RGB LED\r\n• Screw-in stabilizer prelube\r\n• Hotswappable south facing PCB\r\n• Connection :\r\n1. Wireless 2.4 GHz\r\n2. Bluetooth 5.0 (Pair Up to 3 Devices)\r\n3. Wired Port USB Type-C\r\n• Available in Futuristic, Nostalgic, Classic, Barebone Black, Barebone Beige.\r\n\r\n\r\n- SPECIFICATION\r\n• Plate: Polycarbonate (additional; Aluminum, FR4, POM)\r\n• Poron Switch Pad\r\n• Poron Plate Foam\r\n• Silicone Case Dampener\r\n• Screw-in Stabilizer\r\n• Keys : 82 Keys\r\n• Weight : 1300 gram\r\n• Cable Length: 180 cm\r\n• Keycaps Material : Premium ABS\r\n• Dimension : 328mm x 138mm x 42mm\r\n• Compatible with Windows and Mac OS\r\n• 4000 mAh\r\n• Windows software (coming soon)\r\n\r\n\r\n- PACKAGE CONTENT\r\n1 x Noir Timeless82\r\n1 x Keycaps Puller\r\n1 x USB Receiver for 2.4 GHz\r\n1 X Extra Switch (Classic)\r\n1 x Type-C Cable\r\n1 x User Manual', 1155000.00, 16, 2, 'keyboard06.png', '2024-12-25 23:04:24', '2024-12-25 23:04:24'),
(17, 'Fantech Atom96 Atom 96 Pro Series Wireless Mechanical Gaming Keyboard', 'MK914 ATOM PRO96 WIRELESS MECHANICAL KEYBOARD\r\n\r\nWarna Black (Mercury):\r\nMK914 BLACK, BLUE SWITCH\r\nMK914 BLACK, RED SWITCH\r\n\r\nWarna Grey (Saturn) :\r\nMK914 GREY, BLUE SWITCH\r\nMK914 GREY, RED SWITCH\r\n\r\nSPECIFICATIONS :\r\n•Product Name : ATOM PRO96\r\n•Total 96 keys\r\n•Switch type Mechanical\r\n•Anti-Ghosting Full keys (NKRO)\r\n•3 Connection (Wireless 2.4GHz, BT 5.0, Wired)\r\n•5 Pin Hot-Swappable\r\n•Adjustable Feet\r\n•Lighting 22 modes\r\n•Material ABS\r\n•Weight 830 g\r\n•Size 385*134*42 mm\r\n•Built-in Volume Knob\r\n•Sound Absorbing Silicon\r\n•Side Panel RGB with 11 Spectrum Modes\r\n•Battery Capacity 3.000 mAh', 675000.00, 20, 2, 'keyboard07.png', '2024-12-25 23:05:28', '2024-12-25 23:05:28'),
(18, 'Gamen Titan VI Gasket Mount Wired Mechanical Gaming Keyboard', 'Keunggulan Titan VI:\r\n1. Gasket Design, membuat mengetik lebih redap, improve flexibility, dan tidak bergetar\r\n2. Outemu Linear Silver Switch, switch dengan response time tercepat\r\n3. Swappable 3 pin switch\r\n4. Kualitas Switch A+, tombol yang kuat dengan ketahanan 50 juta kali\r\n5. 12 backlight modes, dengan 5 level kecerahan yang dapat disesuaikan\r\n6. Poros mekanis yang dapat dicolokkan dan disesuaikan dengan kenyamanan anda\r\n7. N-Key Rollover, Menekan 99 tombol secara bersamaan anti ghosting untuk performa permainan yang lebih baik\r\n8. Ergonomic design sehingga bermain lebih nyaman\r\n9. Menggunakan bahan yang kuat, tahan korosi, bertekstur halus dan tidak memudar\r\n10. Dilengkapi 2 kaki anti slip\r\n11. Cocok untuk gamer, pekerja kantor sekolah dan lain-lain\r\n\r\nSpesifikasi:\r\n*Model : Titan V\r\n*Number of keys : 99\r\n*Switch : Linear Silver (pluggable)\r\n*Input : 5V 200mA\r\n*Size : 38.9 x 13.7 x 3.9 cm\r\n\r\n\r\nKelengkapan\r\n1x Keyboard Titan VI', 399900.00, 51, 2, 'keyboard08.png', '2024-12-25 23:06:27', '2024-12-25 23:06:27'),
(19, 'Yunzii YZ98 YZ-98 Pro Wireless Mechanical Keyboard', 'Specifications\r\nProduct: YUNZII YZ98\r\nType: Vintage Mechanical Keyboard\r\nLayout: 98% Layout, 99-Key\r\nRGB: South-facing RGB and side lights\r\nColor Choices: White, Black\r\nSwitch Choices: YUNZII Milk Switch\r\nStructure: Gasket Mounted\r\nBattery: 4600mAh\r\nConnection: Wired Type-C/Bluetooth/2.4G Wireless\r\nSize of Product: 390*147*39mm/15.35*5.79*1.54 inch\r\nWeight of Product: 970.5g/2.14 lb\r\nKeycaps: Double-shot PBT Cherry Profile Keycaps\r\nHot Swappable: YES\r\nNKRO: YES\r\n\r\n98% 99 Keys with Gasket Mounted Structure and Hi-Fi Sound Filling\r\nThe YZ98 is a 98% layout 99-key mechanical gaming keyboard. Come with two acrylic metal badges, the keyboard offers both functionality and aesthetic. The keyboard takes the gasket structure and utilizes a high-quality gasket material to absorb vibrations and eliminate any noise. The YZ98 takes a luxury Hi-Fi sound filling, equipped with IXPE gasket pads, PORON sandwich foam, silicone pads, pre-lubed switches, and stabilizers, reduces hollow sound and fatigue, and provides a pleasant typing feeling, ideal for gamers who like a custom keyboard with superb quality.\r\n\r\nTri-mode Wireless Connectivity &Multi-Device Connection: Bluetooth 5.0&2.4G&Type-C\r\nFeatured with a 4600 mAh capacity battery, the YUNZII YZ98 keyboard supports Bluetooth, 2.4G wireless, and wired connection. And the polling rate of the 2.4gHz wireless mode is up to 1000hz. Compatible with Laptops, iPads, iOS, Windows, Mac, and Android. There is not that much connection process, the wireless connection is fast and stable. Fn+Right Alt can check the battery capacity anytime. 2.4G wireless dongle and wired cable are included', 1299000.00, 11, 2, 'keyboard09.png', '2024-12-25 23:08:02', '2024-12-25 23:08:02'),
(20, 'Rexus MX5.2 Legionare Mechanical Gaming Keyboard', 'SPESIFIKASI\r\nTipe Keyboard: Mechanical Keyboard\r\nJumlah Tombol: 87 tombol\r\nJenis Tombol: Mechanical\r\nTipe Konektor: USB V 2.0\r\nDurabilitas: 10.000.000 klik\r\nKecepatan Respon: 1ms\r\nKeycaps: Double Color Injection\r\nLED: LED 6 warna\r\nMaterial: Plastik ABS dengan cover aluminium alloy\r\nKabel: Berlapis serat nilon\r\nDimensi: 363 x 135 x 36mm\r\nBerat: 770±20gram\r\nPanjang Kabel: 2m\r\nKompatibilitas: Windows OS dan MAC OS\r\nIsi Kemasan: penarik keycap', 395000.00, 42, 2, 'keyboard10.png', '2024-12-25 23:09:40', '2024-12-25 23:09:40'),
(21, 'Razer Viper V3 Pro Wireless Gaming Mouse Ultra-lightweight Symmetrical', '54 G Ultra-Lightweight Design\r\nRazer™ Focus Pro 35K Optical Sensor Gen-2\r\nRazer™ HyperPolling 8K Hz Technology\r\n\r\nTech Specs:\r\n\r\nForm Factor: Right-handed Symmetrical\r\nConnectivity: Razer HyperSpeed Wireless, Wired\r\nBattery Life:\r\nUp to 95 hours at 1000 Hz\r\nUp to 62 hours at 2000 Hz\r\nUp to 40 hours at 4000 Hz\r\nUp to 17 hours at 8000 Hz\r\nRGB Lighting: None\r\nSensor: Focus Pro 35K Optical Sensor Gen-2\r\nMax Sensitivity (DPI): 35000\r\nMax Speed (IPS): 750\r\nMax Acceleration (G): 70\r\nProgrammable Buttons: 6\r\nSwitch Type: Optical Mouse Switches Gen-3\r\nSwitch Lifecycle: 90-million Clicks\r\nOn-board Memory Profiles: 1\r\nMouse Feet: 100% PTFE\r\nCable: USB Type A to USB Type C cable\r\nTilt Scroll Wheel: None\r\nApproximate Size:\r\nLength: 127.1 mm / 5.00 in\r\nWidth: 63.9 mm / 2.51 in\r\nHeight: 39.9 mm / 1.57 in\r\nApproximate Weight: 54 g (excluding cable and dongle)\r\nDock Compatibility: None\r\nBox Contents:\r\nRazer Viper V3 Pro\r\nRazer HyperPolling Wireless Dongle\r\nUSB Type A to USB Type C cable\r\nRazer Mouse Grip Tape\r\nImportant Product Information Guide', 2799000.00, 9, 3, 'mouse01.png', '2024-12-25 23:10:23', '2024-12-25 23:10:23'),
(22, 'Logitech G PRO X SUPERLIGHT 2 DEX LIGHTSPEED Wireless Gaming Mouse', 'System Requirements\r\nPC dengan Windows 10 atau yang lebih baru dan port USB 2.0\r\n(Opsional) Akses internet untuk perangkat lunak Logitech G HUB 1\r\n\r\nTechnical Specs\r\nSpesifikasi Teknis\r\nMemori Onboard\r\n5 tombol\r\nSensor: HERO 2\r\nResolusi: 100 – 32.000 DPI\r\nAkselerasi maks: > 40G2\r\nKecepatan maks: > 500 IPS2\r\nZero smoothing/akselerasi/penyaringan\r\nReport rate kabel maks: 1.000 Hz (1 md)1\r\nReport rate LIGHTSPEED maks: 4000 Hz (0,25 md)1\r\nDaya Tahan Baterai: (gerakan terus-menerus): 95 jam\r\nDimensi: 125,8 mm X 67,7 mm X 43,9 mm\r\nBerat: 60 g\r\n\r\nPackage Contents\r\nMouse Gaming Nirkabel PRO X SUPERLIGHT 2 DEX\r\nReceiver nirkable LIGHTSPEED\r\nKabel data/pengisian daya USB-A ke C\r\nAdaptor perpanjangan receiver\r\nPintu apertur POWERPLAY dengan alas PTFE\r\nGrip tape opsional\r\nKain pembersih\r\nDokumentasi pengguna', 2319000.00, 2, 3, 'mouse02.png', '2024-12-25 23:11:36', '2024-12-25 23:11:36'),
(23, 'Pulsar X2V2 / X2 V2 Tanjiro Wireless Gaming Mouse Demon Slayer', 'Pulsar X Demon Slayer\r\nIntroducing the Pulsar Gaming Gears x Demon Slayer Collaboration! Immerse yourself in the ultimate gaming experience with Pulsar\'s gaming mice and peripherals. Our collaboration with Demon Slayer brings the iconic anime\'s thrilling world to your gaming setup. Elevate your gameplay with exclusive gear inspired by Demon Slayer\'s captivating universe. Unleash the power within and embark on an extraordinary gaming adventure!\r\n\r\nDimension\r\nLength: 4.74in (120.4mm)\r\nWidth: 2.48in (63mm)\r\nHeight: 1.5in (38mm)\r\nWeight: 54g (+- 1g) / 1.9oz\r\n\r\nSENSOR\r\nPAW3395\r\n26000 DPI\r\n650 IPS\r\n50g Acceleration\r\n1000Hz/1ms Polling Rate\r\n32bit ARM Processor\r\n\r\nGENERAL\r\nDesigned for Competitive eSports\r\nWide Waist / Low Hump\r\nSymmetrical Shape\r\nRecommended for Claw / Fingertip Grip\r\nUltra-light Weight 54g\r\nFast and Double Click Free OPTICAL SWITCH\r\nPulsar Blue Encoder\r\nSuper Smooth ballbearing wheels\r\nLatest Flagship PAW3395 Sensor\r\nFully customizable sensor setting\r\nFully customizable keys and macros\r\nSuperflex Paracord Cable\r\nUltra Durable\r\nLag free 2.4GHz Wireless technology\r\nUp to 100 hours battery life, ±10% at 1000Hz polling rate. Actual battery life may vary depending on user environment.\r\n\r\nREQUIREMENT\r\nUSB Port\r\nOperating System (Windows, Mac, Linux)\r\nInternet connection (to download software)\r\nWindows 7 or higher (for Pulsar Software)', 2199000.00, 6, 3, 'mouse03.png', '2024-12-25 23:12:40', '2024-12-25 23:12:40'),
(24, 'Lamzu Thorn Fnatic Special Edition 4K Compatible Superlight Wireless Gaming Mouse', 'Spesifikasi :\r\n- 119x65x42mm\r\n- Pixart 3395 (maximum 26.000 DPI)\r\n- Superlight, 52g\r\n- Long battery life\r\n- Designed for Gaming\r\n- Dual mode: 2.4Ghz dongle + kabel USB C\r\n- Nordic 52840 MCU, kompatibel dengan 4K Dongle (not included)\r\n- Encoder: Silver TTC\r\n- Ergonomis, Ideal untuk user palm grip dan claw grip\r\n- Optical switch\r\n- Available Sfotware\r\n\r\nInside the Box :\r\n- LAMZU THORN\r\n- Manual\r\n- Braided cable\r\n- PTFE spare feet\r\n- Anti slip tape\r\n- 4K dongle\r\n- Pouch', 1629000.00, 12, 3, 'mouse04.png', '2024-12-25 23:13:13', '2024-12-26 00:09:27'),
(25, 'ortexseries INNO X3 PRO 8K Ultra Lightweight Wireless Gaming Mouse', 'VortexSeries INNO X3 PRO\r\n\r\nGaransi Resmi PT. VORTEX INDONESIA 1 Tahun\r\n\r\n- SENSOR : PIXART PAW 3950 MAX\r\n- Switch : OMRON D2FP FN2 OPTICAL MICRO SWITCH 80millions Clicks\r\n- Scroll Wheel : F SWITCH 9-S Encoder\r\n- Connectivity : Tri-mode (Wired, Wireless 2.4G and Bluetooth)\r\n- Cable : Type-C Paracord Cable included\r\n- NORDIC 52840 MCU\r\n- On-Board Memory\r\n- Max 42000 DPI\r\n- 750 IPS\r\n- Acceleration 50g (MAX)\r\n- Polling Rate 125-250-500-1000 (Wired)\r\n- Polling Rate 125-250-500-1000-2000-4000-8000 (Wireless Dongle)\r\n- Adjustable LOD 0,7mm-1mm-2mm\r\n- 8Khz Dongle Included for Wireless Connectivity\r\nCOLOUR OPTIONS : WHITE & BLACK\r\n\r\n\r\nIsi Kemasan;\r\n1x INNO X3 PRO Mouse\r\n1x Type-C Paracord Cable\r\n1x Big Wireless Dongle (Up to 8000Hz)\r\n1x Set Spare Mouse Feet\r\n1x Set Special Design Grip Tape\r\n1x Design Explanation Card\r\n1x Manual Book', 789000.00, 19, 3, 'mouse05.png', '2024-12-25 23:15:12', '2024-12-25 23:15:12'),
(26, 'Ajazz AJ159 APEX Wireless Gaming Mouse Triple Connection with Charging Station', 'SPESIFIKASI\r\n\r\nTriple Modes Connection &High Polling Reate\r\n400mAh Battery with Low-Power Consumption\r\nMagnetic Charging Base\r\nPAW3390 Sensor\r\n100 Million Clicks Micro SwitcH\r\n\r\nRenowned PAW3395 Sensor\r\nThe AJAZZ AJ159 APEX is powered by PixArt\'s latest flagship sensor, the PAW3950, which has been finely tuned for peak performance. It boasts a maximum sensitivity of 30,000 DPI, which can be overclocked to 42,000 DPI, alongside a tracking speed of 750 IPS and 50G acceleration. These features set the AJ159 APEX apart in the marketplace, offering unmatched precision and speed.\r\n\r\nAdvanced Tri-Mode Connectivity and High Polling Rate\r\nThis mouse supports seamless switching between Bluetooth, 2.4GHz wireless, and wired connections. Uniquely, it offers an 8000Hz polling rate in wireless mode and 1000Hz in wired mode, delivering an ultra-low response time of 0.125ms—eight times faster than standard gaming mice, ensuring instantaneous feedback and smoother cursor movement.\r\n\r\nEfficient 400mAh Battery with Low-Power Consumption\r\nEquipped with a 400mAh battery, the AJ159 APEX incorporates AJAZZ\'s advanced low-power consumption technology, significantly extending battery life to support prolonged gaming sessions without frequent recharges.\r\n\r\nMagnetic Charging Base with Customizable Display\r\nThe AJ159 APEX comes with an innovative magnetic charging dock featuring an RGB colorful display screen. This display not only shows the date and time but can also be personalized with animated GIFs, adding a unique and vibrant touch to your gaming setup.', 1069000.00, 13, 3, 'mouse06.png', '2024-12-25 23:16:20', '2024-12-25 23:16:32'),
(27, 'Vortexseries ONI R1 Wireless Gaming Mouse Lightweight Ergonomic', 'VortexSeries ONI R1 LightWeight Ergonomic Wireless Gaming Mouse\r\n\r\nBaterai: 300mAh\r\n\r\n- SENSOR : New / Updated Version of PIXART PAW 3311\r\n- Switch : Huano 50Million lifetime click\r\n- Scroll Wheel : TTC Encoders\r\n- Connectivity : Tri-mode ( Wired, Wireless 2.4G and Bluetooth 5.2/5.4 )\r\n- Cable : Type-C Paracord Cable\r\n- On-Board Memory\r\n- Max 18000 DPI\r\n- 400 IPS\r\n- Acceleration 40g\r\n- Polling Rate 125-250-500-1000Hz\r\n- SIZE 123.5 * 64 * 41mm\r\n- Ergonomic Shape\r\n- Super Light Weight 59g\r\n- Spare Mouse feet and FREE Grip Tape\r\n- Garansi 1 Tahun VortexSeries\r\n- Software Available', 349000.00, 40, 3, 'mouse07.png', '2024-12-25 23:17:23', '2024-12-25 23:17:23'),
(28, 'Logitech G102 RGB V2 Lightsync', 'SPECIFICATIONS\r\n\r\nREQUIREMENTS\r\nWindows® 7 or later\r\nmacOS 10.10 or later\r\nChrome OSTM\r\nUSB port\r\nPHYSICAL SPECS\r\nHeight: 116.6 mm\r\nWidth: 62.15 mm\r\nDepth: 38.2 mm\r\nWeight: 85 g, (mouse only)\r\nCable Length: 2.1 m\r\nTECHNICAL SPECIFICATIONS\r\nLIGHTSYNC RGB lighting\r\n6 programmable buttons\r\nResolution: 200 – 8,000 DPI\r\nRESPONSIVENESS\r\nUSB data format: 16 bits/axis\r\nUSB report rate: 1000 Hz (1ms)\r\nMicroprocessor: 32-bit ARM\r\nPART NUMBER\r\nWhite : 910-005803\r\nBlack : 910-005802\r\nWARRANTY INFORMATION\r\n2-Year Limited Hardware Warranty', 269000.00, 70, 3, 'mouse08.png', '2024-12-25 23:19:02', '2024-12-25 23:19:02'),
(29, 'Fantech ARIA XD7 V2 ARIA II Wireless Gaming Mouse', 'Spesifikasi :\r\n* Pixart 3395 Sensor\r\n* 3-Mode Connection (Wired, BT 5.0 and Strikespeed wireless 2.4G)\r\n* Huano TBSPD 80 Million Clicks Switch\r\n* Scroll Encoder : F-Switch 1M Cycle\r\n* Speed : 650ips/50g\r\n* MCU : CompX CX52850P\r\n* Polling Rate : 1.000Hz Wired, 1.000Hz Wireless\r\n* Cable Type : Paracord\r\n* Weight 53 gr', 599000.00, 32, 3, 'mouse09.png', '2024-12-25 23:20:25', '2024-12-25 23:20:25'),
(30, 'Fantech KANATA S WIRELESS WG9S Dual Mode Connection Wireless Wired', 'Spesifikasi :\r\n* Pixart 3311 Sensor\r\n* 2-Mode Connection (Wired, StrikeSpeed Wireless)\r\n* Huano 20 Million Clicks Switch\r\n* 400-12000 DPI\r\n* Speed : 300 ips/35g\r\n* Encoder : 300000 scroll\r\n* Polling Rate : up to 1000 Hz\r\n- Software : Yes\r\n* Weight : 89 gr', 329000.00, 21, 3, 'mouse10.png', '2024-12-25 23:21:22', '2024-12-25 23:21:22'),
(31, 'Razer Seiren V2 Pro', '30 mm Dynamic Microphone\r\nHigh Pass Filter\r\nAnalog Gain Limiter\r\n\r\nTECH SPECS\r\nSAMPLE RATE\r\n96 KHz\r\nBIT RATE\r\n24 bit\r\nCAPSULES\r\n30 mm Dynamic Microphone\r\nPOLAR PATTERNS\r\nCardioid Microphone\r\nFREQUENCY RESPONSE\r\n20 Hz - 20 KHz\r\nPOWER REQUIRED\r\n5 V / 350 mA\r\nSENSITIVITY\r\n-34 dB (1 V / Pa at 1 kHz)\r\nMAX SPL\r\n120 dB\r\nIMPEDANCE\r\nNone\r\nPOWER OUTPUT\r\nNone\r\nTHD\r\nNone\r\nSIGNAL-TO-NOISE RATIO\r\n105 dB (A-weighted)\r\nCONNECTION TYPE\r\nType A to Type C USB Cable', 2149000.00, 7, 4, 'mic01.png', '2024-12-25 23:22:23', '2024-12-25 23:22:23'),
(32, 'Elgato Wave DX Dynamic XLR Microphone Streaming Mic Gaming', 'CAPSULE\r\nDynamic\r\n\r\nPOLAR PATTERN\r\nCardioid\r\n\r\nFREQUENCY RESPONSE\r\n50 - 15000 Hz\r\n\r\nSENSITIVITY\r\n2.5 mV/Pa, -52 dbV/Pa\r\n\r\nIMPEDANCE\r\n600 Ohm\r\n\r\nCONNECTOR\r\n3-pin XLR\r\n\r\nDIMENSIONS\r\n53 x 53 x 146 mm | 2.1 x 2.1 x 5.7 in\r\n\r\nWEIGHT\r\n440 g | 1 lb\r\n\r\nMOUNTING\r\n5/8\" mount with 3/8\" and 1/4\" thread adapters included\r\n\r\nIN THE BOX\r\nWave DX, Swivel Mount, 3/8\" and 1/4\" Thread Adapters, Quick Start Guide\r\n\r\nWave DX is Dynamic XLR Microphone, |Capsule: Dynamic|50 - 15000 Hz |Sensitivity: 2.5 mV/Pa, -52 dbV/Pa|Impedance: 600 Ohm|Connector: 3-pin XLR| Warm True-to-Life Vocals, No Signal Booster Required, Cardioid Pattern, Pop Filter, Noise Rejection, Podcasting, Streaming, Broadcasting\r\n*Requires an XLR audio interface, XLR cable, mic stand or boom arm', 1799000.00, 11, 4, 'mic02.png', '2024-12-25 23:22:56', '2024-12-25 23:22:56'),
(33, 'Thronmax Mdrill Zone M5 USB Microphone For Streaming', 'WIDE-RANGE FREQUENCY RESPONSE\r\nWith VERTIGAIN® technology helps to increase quality and clarity by up to 10% compared to other digital XLR microphones. As sound waves move in a vertical direction, the wave reaches the single 25mm condenser without being scattered by any microphone mesh.\r\n\r\nMultipurpose small-diaphragm microphone\r\nWarm sound with extra clarity at the top end\r\n25MM condenser high-class microphone\r\nPerfect for Vocals, Acoustic Guitars, Youtubers, podcast and voice-work\r\n\r\nTECHNICAL SPECIFICATIONS\r\nCapsule size:25MM\r\nFrequency range:25HZ-20Khz\r\nPolar Pattern: Cardioid\r\nSensitivity:15mV/Pa output\r\nPre Attenuation switch:0db,10dB\r\nHigh pass Filter:6dB/octave@150Hz\r\nImpedance: 150ohms', 939000.00, 10, 4, 'mic03.png', '2024-12-25 23:23:47', '2024-12-25 23:23:47'),
(34, 'Sades Orpheus - Premium Microphone Condenser For Recording', 'FEATURES\r\n\r\n• SOUND CHIPSET\r\ndilengkapi dengan sound chipset yang membuat Orpheus ini membuat suara yang masuk menjadi elbih jernih dan jelas\r\n\r\n• PLUG AND PLAY WITH USB CONNECTION\r\ntidak sulit untuk memakai nya tinggal di plug dan bisa langsung di pakai menggunakan kabel USB\r\n\r\n• VOLUME AND ECHO CONTROL\r\ndi mic nya terdapat pengatur volume dan echo sehingga cukup mudah unutk mengatur nya\r\n\r\n• POLAR PATERN CARDIOID\r\ndilengkapi dengan polar pattern cardioid sehingga meningkatkan sensitivitas di bagian belakang berkurang lebih baik dan mikrofon omnidirectional\r\n\r\n• ANGLE ADJUSMENT\r\nsangat mudah unutk di atur sesuai angle yang di ingin kan, bisa di arahkan sampai 90 derajat\r\n\r\n• FULL METAL CASE\r\ndirancang dengan case berbahan metal yang menjadikan Orpheus kokoh dan tampak elegan\r\n\r\nSPECIFICATIONS\r\n\r\nPower suply : SV\r\nPolar Pattern : uni-directional\r\nFrequency response : 20 Hz - 20KHz\r\nsensitivity : -34dB +-30% (at 1KHz)\r\nCable : 2.5m USB Cable\r\nLoad Impedance : 1000 Ohm\r\nMax.SPL : 130 dB (at 1 KHz > 1% T.H.D)\r\nS/N Ratio : 78 dB\r\nElectrical Current : 70 mA\r\nCompatible : Windows, mac OS', 619000.00, 1, 4, 'mic04.png', '2024-12-25 23:24:13', '2024-12-25 23:24:32'),
(35, 'Noir Voix Condenser Microphone USB Type C with RGB Streaming Gaming', 'Fitur:\r\n- Cardioid dan Omni-directional\r\n- Type-C data and power\r\n- RGB light\r\n- Volume adjustment\r\n- Zero latency 3.5mm headphone jack\r\n\r\nSpesifikasi:\r\nPolar pattern: Cardioid & Omni-directional\r\nSensitivity: -33±2dB (1.5V, 2.2KΩ; 0dB=1V/Pa, 1KHz)\r\nFrequency Rate: 80 Hz-20000 Hz\r\nSPL: 110dB\r\nS/N Ratio: ≥96dB\r\nTHD: <0.005%\r\nSampling Rate/Bit depth: 192KHz/24bit\r\nInput Voltage: DC=5V', 524000.00, 19, 4, 'mic05.png', '2024-12-25 23:25:01', '2024-12-25 23:25:06'),
(36, 'Rexus CM10 / CM-01 Snare Wired Microphone Condenser Mic Computer RGB', 'Microphone Rexus Snare CM10 menawarkan dengan pola perekaman cardioid yang optimal. Dengan perakitan yang mudah berkat raising bar yang dapat disesuaikan, mikrofon ini memberikan fleksibilitas dalam pengaturan. Dengan tingkat sampel 96Khz dan bit rate 24 bit, serta mode LED warna 9 yang dinamis, mikrofon ini menawarkan kualitas audio yang superior serta tampilan yang elegan. Ballhead berputar 360° memungkinkan penyesuaian sudut yang mudah. Menggunakan daya 5V 200mA melalui USB, mikrofon ini dapat dimonitor langsung melalui port AUX dengan headset. Terdapat tombol mute untuk kebutuhan serta kompatibilitas dengan beberapa device tertentu yang menjadikannya pilihan serbaguna untuk berbagai kebutuhan rekaman dan siaran.\r\n\r\n- High-Performance Cardioid Microphone\r\n- Easy to Assembly with Adjustable Raising Bar\r\n- Sample Rate: 96Khz; Bit Rate: 24 bit\r\n- Dynamic 9 Mode LED Color (Include Off)\r\n- 360° Rotating Ballhead\r\n- Power required: 5V 200mA (USB)\r\n- Live Monitor with AUX Port by Headset\r\n- Mute Button Available\r\n- Compatible to Selected Devices\r\n\r\nSPESIFIKASI\r\n\r\nPower Required : 5V 150mA (USB)\r\nSample Rate : 96KHz\r\nBit Rate : 24 bit\r\nCapsules : 16mm Condenser\r\nFrequency Response : 20Hz - 20KHz\r\nMax SPL : 110 (THD : 0.5% 1KHz)\r\nSensitivity : 4.7mV/Pa (1KHz)', 499000.00, 22, 4, 'mic06.png', '2024-12-25 23:25:48', '2024-12-25 23:25:48'),
(37, 'Fantech LEVIOSA MCX01 Condenser Microphone USB for PC Laptop Streaming', 'Spesifikasi :\r\n\r\nType : Condenser Microphone\r\nMic Sensitivity : -38dB ± 3dB\r\nImpedance : 16Ω\r\nPolar Pattern : Cardioid\r\nFrequency Response : 20Hz - 20kHz\r\nSample Rate : 48kHz at 16bit\r\nPlug Type : USB A to USB B (Cable included)\r\nCord Length : 2.5 Meter\r\nDimensions : 172 x 45.5 x 45.5 mm\r\nWeight : 252 gram\r\nRGB :\r\n\r\nInclude :\r\n- PoP Filter\r\n- Foldable Tripod\r\n- USB Cable 2.5m\r\n- Mount Adapter\r\n\r\nGaransi Resmi 1 Tahun Fantech Care', 499000.00, 24, 4, 'mic07.png', '2024-12-25 23:27:26', '2024-12-25 23:27:26'),
(38, 'HyperX Quadcast S RGB - USB Condenser Gaming Microphone', 'Features\r\n\r\n- Dynamic RGB lighting effects customizable with HyperX NGENUITY Software1\r\n- Anti-Vibration shock mount\r\n- Tap-to-Mute sensor with LED indicator\r\n- Four selectable polar patterns\r\n- Mount adapter included\r\n- Convenient gain control adjustment\r\n- Internal pop filter\r\n- Built-in headphone jack\r\n- Multi-device and program compatibility\r\n\r\nRadiant RGB lighting customizable with HyperX NGENUITY Software1\r\nPersonalize stunning RGB lighting and dynamic effects for an eye-catching shot of customizable style.\r\n\r\nAnti-Vibration Shock Mount\r\nIsolate the mic and suppress the sound of unintentional rumbles and bumps with the elastic rope suspension.\r\n\r\nTap-to-Mute with LED Status Indicator\r\nUse the convenient tap-to-mute functionality to prevent an audio accident along with the help of the LED mic status indicator. If the light is on, the mic is active. If the light is off, the mic is muted.\r\n\r\nFour Polar Patterns\r\nChoose between four polar patterns (stereo, omnidirectional, cardioid, bidirectional) to optimize your broadcast setup and keep the focus on the sounds you want to be heard.', 2579000.00, 4, 4, 'mic08.png', '2024-12-25 23:28:02', '2024-12-25 23:28:02'),
(39, 'dbE USB M100 - USB Condenser Microphone Gaming Mic', 'Spesifikasi :\r\nTipe : Uni Directional Condenser Microphone\r\nPolar Pattern : Cardioid\r\nSensitivitas : 55 dB +- 5 dB\r\nFreq Response : 50 Hz - 18 kHz\r\nS/N Ratio : 59 dB @ 1K\r\nMaximum Input : 120 dB SPL\r\n\r\nKelengkapan Paket :\r\n- 1 USB Microphone USB M100\r\n- Stand Microphone\r\n- Kabel USB', 699000.00, 7, 4, 'mic09.png', '2024-12-25 23:28:44', '2024-12-25 23:28:44'),
(40, 'Thronmax Mdrill One Pro M2P', '\r\nTECHNICAL SPECIFICATIONS\r\nPower Required/Consumption: 5V 150mA\r\n\r\nSample Rate: 96kHz\r\n\r\nBit Rate: 24bit\r\n\r\nTotal 3 16mm condenser high quality capsule: 3 condenser capsules can record any situation\r\n\r\nRecording Patterns: Cardioid, Stereo, 360 Bi-Directional, Omni-Directional\r\n\r\nFrequency Response: 20Hz – 20kHz\r\n\r\nLong Distance Recording (LDR)\r\n\r\nFar-talk smart voice capture(SVC)\r\n\r\nVoice Brilliant (HD Voice)', 1079000.00, 10, 4, 'mic10.png', '2024-12-25 23:29:26', '2024-12-25 23:29:26'),
(41, 'Razer Wolverine Ultimate Xbox One Gamepad Joystick', 'TECH SPECS\r\nAt a glance\r\nWorks with Xbox One and PC (Windows® 10)\r\n6 additional remappable bumpers & triggers\r\nInterchangeable thumbsticks and D-Pad\r\nRazer Chroma lighting\r\nComes with carrying case\r\n12 months warranty\r\nTech Specs\r\n2 shoulder Hyperesponse Multi-Function Bumpers\r\n4 Multi-Function Triggers\r\n4 Tactile Switch ABXY action buttons\r\n4 button Quick Control Panel\r\nMulti-Color Razer Chroma Lighting Strip\r\nTrigger stops for rapid-fire\r\nZero slow-turn concave analog joysticks\r\n3.5 mm audio port for stereo audio output and microphone input\r\nQuick-release cable feature\r\nCarrying case\r\nDetachable 3 m / 10 ft lightweight braided fiber cable with Micro-USB connector\r\nApproximate size: 106 mm / 4.17 in (Length) x 156 mm / 6.14 in (Width) x 66 mm / 2.60 in (Height)\r\nApproximate weight (without cable): 272 g / 0.6 lbs\r\nSystem Requirements\r\nXbox One or PC (Windows® 10)\r\nInternet connection for Razer Synapse for Xbox', 2395000.00, 8, 5, 'gpad01.png', '2024-12-25 23:30:30', '2024-12-25 23:30:41'),
(42, 'Fantech WGP13s Shooter III 3 Wireless Gamepad Hall Effect', 'Fantech WGP13s WIRELESS Gaming Controller For Pc And Ps3\r\nSoft Grip With Built In Battery\r\nFantech WGP13 Shooter II Wireless 2.4GHZ\r\nGaming Controller Ergonomic\r\n\r\nBest for Gaming\r\n-Ergonomic shape and weight favored by esports athletes\r\n-Play in Comfort\r\n-Feel compfortable in your hands for hours of gaming\r\n-Feel the Action\r\n-Vibration feedback gives you a riveting gaming experience\r\n- Hall Effect\r\n- Timed Macro\r\n\r\nGaransi 1 Tahun Fantech Indonesia', 259000.00, 41, 5, 'gpad02.png', '2024-12-25 23:32:51', '2024-12-25 23:32:51'),
(43, 'Flydigi Apex 4 Elite Gaming Controller High End Compatible For Nintendo/PC/Mobile', 'Brand Name: FLYDIGI\r\nProduct Name: FLYDIGI Apex 4 Wireless PC Controller\r\nProduct Model: APEX 4\r\nOperating Current: <80mA (excluding motor and feedback trigger)\r\nStandby Current: <0.1mA\r\nBattery Capacity: 1500mAh\r\nCharging Time: 3-4 hours\r\nCharging Voltage: 5V\r\nCharging Current: 1000mA\r\nWireless Frequency: Bluetooth 5.0, Bluetooth 5.0BLE\r\nEffective Range: <10 meters\r\nCharging Port: Type-C (does not support fast charging)\r\nBattery Life: Battery life may vary depending on usage and other factors\r\nTemperature Range: Operating and storage temperature from -5℃ to 50℃\r\nController Dimensions: 15.5 x 10.3 x 6.5 cm\r\nProduct Weight: 698 g (including box)\r\nProduct Include: Game controller x1, USB to Type-C cable (2 meters) x1, Receiver x1, User Manual x1\r\n\r\n【Kontroler Gaming PC Multi-Platform】\r\nPlatform yang didukung: PC/NS/TV/Android/Laptop (BELUM mendukung XBOX dan PS saat ini)\r\nMode koneksi: kabel/bluetooth/2.4G wireless dongle.\r\n\r\n【Flydigi Force Feedback Triggers】\r\nKontroler APEX 4 dilengkapi dengan trigger umpan balik yang sama seperti APEX 3, yang menghadirkan mode trigger yang lebih kaya dan mentransmisikan karakteristik fisik permainan ke trigger, memberikan pengalaman bermain yang nyata, terutama dalam permainan balapan dan tembak-menembak. Anda juga dapat menyesuaikan stroke trigger, resistensi, getaran, dll. di flydigi space station.\r\n\r\n【Polling Rate Wired/Wireless 1000Hz】\r\nTeknologi Flysync mendapatkan terobosan dan inovasi, baik koneksi kabel maupun wireless memiliki Polling Rate 1000Hz, meningkatkan responsivitas kontroler dan memastikan sinkronisasi yang lebih baik antara reaksi pemain dan aksi karakter dalam permainan. Baik saat melakukan combo cepat atau penargetan yang presisi, ini memberikan pengalaman bermain yang lebih mulus dan konsisten, mengurangi ketidakpastian dan kesalahan yang disebabkan oleh delay, dan memungkinkan pemain mendapatkan keuntungan dalam pertarungan yang intens.\r\n\r\n【Full Color Interactive Display Screen】\r\nKali ini kami menambahkan lebih banyak pengaturan fungsionalitas langsung di layar kontroler, seperti penyesuaian trigger, konfigurasi tombol belakang, pemulihan konfigurasi default, dll. Anda dapat mengubah kecerahan layar, intensitas getaran, bahasa, waktu tidur. Semua ini dapat disesuaikan langsung di layar kontroler sekarang! Pemain juga dapat merancang dan menerapkan animasi layar DIY, membuat setiap kontroler FLYDIGI APEX 4 unik.\r\n\r\n【Baterai Kapasitas Tinggi 1500mAh & Motor Rotor yang Ditingkatkan dengan Getaran 4-Area】\r\nKontroler game PC APEX 4 akan membawa Anda pengalaman bermain yang mendalam dan tahan lama dengan getaran Stereo. Motor-motor yang seimbang di area handbar dan 2 area trigger akan memberikan sensasi getaran 4-motor, memberikan umpan balik yang paling realistis (Anda dapat menyesuaikan kekuatan getaran di perangkat lunak!). Dengan baterai kapasitas tinggi 1500mAh, Anda akan menikmati pengalaman bermain yang sempurna tanpa gangguan.\r\n\r\n【Overview of the rest configuration】\r\nKontroler PC APEX 4 juga mencakup: D-pad Rotary 8-way yang dikembangkan sendiri, Panel Lampu RGB yang Dapat Dipersonalisasi, ABXY mekanis yang lebih lembut 2.0, deadzone 0 no drift, penyesuaian resistensi yang bebas, 4 tombol belakang yang dapat diprogram M1 M2 M3 M4, penargetan presisi tinggi dengan gyro enam sumbu, cangkang magnet transparan, desain pegangan ergonomis S-shaped, temukan lebih banyak kesenangan dari Space Station Flydigi PC atau mobile.\r\n\r\n【GARANSI】\r\nSemua produk Flydigi Official Store merupakan Garansi resmi dari Brand Flydigi.\r\nMasa garansi Flydigi Official Store selama 12 bulan dari tanggal pembelian.\r\n\r\nFlydigi Official Store berkomitmen untuk memberikan pelayanan terbaik dan melindungi konsumen agar mendapatkan produk original & bergaransi resmi di Indonesia untuk melindungi hak konsumen dan memastikan pembeli merasa aman dan nyaman untuk membeli produk Flydigi Indonesia.', 1990000.00, 5, 5, 'gpad03.png', '2024-12-25 23:34:10', '2024-12-25 23:34:19'),
(44, 'Logitech F710 Gamepad Joystick', '2.4 Ghz - WIRELESS CONNECTION\r\nDUAL VIBRATION - FEEDBACK\r\n4 SWITCH - D-PAD', 649000.00, 12, 5, 'gpad04.png', '2024-12-25 23:34:53', '2024-12-25 23:34:53'),
(45, 'Rexus Daxa Cygnus AX7 Wireless Gamepad', '● Anti Drift Hall Effect Analog\r\n● ⁠Hall Effect Trigger with Adjustable Height\r\n● Changeable Direction Pad and Swappable Gamepad Case to White Color\r\n● Micro Switch Action Button\r\n● Adjustable Dual Shock Vibration up to 4 Level\r\n● Support Docking Station for Charging\r\n● ⁠Up To 1000Hz Polling Rate\r\n● Gyro Motion Sensor\r\n\r\nSPESIFIKASI\r\nKonektivitas : Kabel, 2.4G Wireless Dongle\r\nBaterai : Lithium Polymer 1000 mAh\r\nDurasi Pemakaian : 8-20 jam\r\nWaktu Isi Ulang : 2-3 jam\r\nSize : 154 * 105.9 * 59.8mm\r\nKompatibilitas : PC, Nintendo Switch, PS3\r\nTombol ABXY : Micro Switch\r\nTegangan : 3.7v\r\nWorking Current : 30mA - 110mA\r\nTriggers : Hall Effect Magnetic Sensor\r\nJoystick : Hall Effect Magnetic\r\nMaterial : ABS + Cooper\r\nGyro Motion Sensor', 579000.00, 20, 5, 'gpad05.png', '2024-12-25 23:35:37', '2024-12-25 23:35:37');
INSERT INTO `products` (`id`, `name`, `description`, `price`, `stock`, `category_id`, `image_url`, `created_at`, `updated_at`) VALUES
(46, 'Rexus Daxa Asteria AX1 Marvel Special Edition Wireless Gamepad', 'NEW UPGRADED WITH CAPTURE BUTTON\r\nGamepad ini kini dilengkapi dengan tombol Capture yang memungkinkan Anda untuk dengan mudah merekam atau menangkap momen-momen penting dalam permainan, seperti gameplay menarik atau pencapaian tertentu, tanpa harus menghentikan permainan. Fitur ini memudahkan Anda untuk berbagi momen seru dengan teman atau media sosial.\r\n\r\n\r\n- Hall Effect Magnetic Joystick &Trigger\r\n- Macro Function Button\r\n- 6-Axis Gyro Motion Sensor\r\n- Dual Mode Connections (2.4GHz Wireless &Wired)\r\n- LED Light &Indicators\r\n- X-Input &Direct Input\r\n- Turbo Mode Function\r\n- Precision Trigger\r\n- Battery 600mAh\r\n- New Upgraded with Capture Button\r\n- Available in 2 Versions (Iron Man and Captain America)\r\n\r\nFITUR PRODUK\r\n\r\n● Kompatibilitas: PC/PS3/Android/Nintendo Switch\r\n● Teknologi nirkabel 2.4GHz dengan jangkauan hingga 8 meter dilengkapi jack headphone 3.5mm, dapat digunakan dalam mode Switch &PC (D-input &X-input)\r\n● Sensor magnetik Hall Effect yang baru memberikan pengalaman trigger yang lebih presisi untuk penggunaan jangka panjang dengan konsistensi yang halus\r\n● Baterai Lithium Polymer 600mAh untuk penggunaan hingga 7-14 jam\r\n● Waktu pengisian 2 hingga 3 jam\r\n● Analog stick 360° eksentrik untuk kenyamanan lebih\r\n● Trigger ganda dan bumper analog\r\n● Sensor Gerakan Gyro 6-Axis\r\n● 19 tombol numerik, termasuk [Homel], [Start], [Select]...\r\n● Fungsi \"Rapid Fire\" dengan mode [Turbo]\r\n● Motor getar ganda untuk sensasi maksimal dalam permainan\r\n● Indikator LED (koneksi, pengisian, habis baterai...)\r\n● Panjang kabel pengisian: 1m ‡5cm\r\n● Dimensi: 157mmx110mmx60mm\r\n● Berat: 261g ‡10g.', 449000.00, 25, 5, 'gpad06.png', '2024-12-25 23:36:14', '2024-12-25 23:36:14'),
(47, 'Sades Ryunix G80 Wireless Gamepad', 'Include Docking Charger\r\n\r\nSpesifikasi\r\n- Koneksi : 2.4GHz Wireless (w/ Dongle) + USB Type-C (Wired)\r\n- Layout : XBOX Layout\r\n- Input : X-Input / D-Input / Switch\r\n- Hall Effect Magnetic Sensor (Trigger & Analog)\r\n- Trigger Switch Button (Instant Trigger / Hall Trigger)\r\n- 1000mAh Battery (Rechargeable)\r\n- Dual Motor Vibration\r\n- 2 Additional Macro Button\r\n- RGB Lighting\r\n- 3.5mm Jack Port\r\n- Inside The Box Include : Docking + Dongle + Type-C Cable + Manual Book\r\n- Variant : Black / White', 419000.00, 2, 5, 'gpad07.png', '2024-12-25 23:36:42', '2024-12-25 23:37:14'),
(48, 'Fantech WGP14 V2 Nova Pro Bluetooth Wireless Gamepad', 'Specifications:\r\n•Number of keys : 22\r\n•Dual Mode Connection : BT 5.3, Wired A to C\r\n•Rumble\r\n•Face button type Membrane\r\n•Turbo 3 level Adjustable modes\r\n•Turbo Speed\r\n•JH16, Anti Drift Sticks &Triggers\r\n•Interchangeable Thumbsticks\r\n•Programmable buttons 12\r\n•Highly Sensitive Motion Sensor 6-Axis Gyroscope\r\n•Battery 600mAh\r\n•Mappable Rear Padles with Timed Macro (Bisa atur Macro pakai delay)\r\n•Port Audio can be used in Computer PC (Wired)\r\n•Responsive Touchpad\r\n•Dual Hall-Effect Analog &Trigger\r\n•Ultra Precise Hall Effect Triggers\r\n•3 Mode RGB Lighting Effects (can be setted ON / OFF) (Breathing, Steady, Off)\r\n•Quick Trigger Locks\r\n•Voltage/Current 3.7 V / 150 mA\r\n•Wireless Range +/ 10m\r\n•Charging Time +/ 2 Hours\r\n•Standby time 10 Hours\r\n•Weight 289 g\r\n•Compatibility PC/Steam, Switch, PS4, PS3, iOS , MacOS, tvOS, Android, Clound Gaming/game pass', 399000.00, 12, 5, 'gpad08.png', '2024-12-25 23:38:05', '2024-12-25 23:38:05'),
(49, 'Rexus ASTA GX150 Wireless Gamepad', 'Rexus Gamepad ASTA GX150 adalah solusi lengkap bagi para gamer dengan fitur-fitur canggih yang\r\nmemastikan pengalaman gaming yang superior. Dengan Anti-Drifting Hall Effect Analog untuk presisi\r\nkontrol yang tak tertandingi, serta Pressure-Sensitive Hall Effect Trigger yang responsif terhadap\r\ntekanan, gamepad ini memungkinkan pengguna mengatur kekuatan aksi dengan detail yang tinggi.\r\nDengan polling rate hingga 1000Hz, pengguna dapat menikmati respon yang cepat dan akurat dalam\r\npermainan. GX150 mendukung dua mode koneksi (nirkabel dan kabel), tersedia dalam pilihan warna\r\nhitam dan putih yang stylish, dilengkapi dengan fitur kunci fungsi Turbo, serta desain grip yang nyaman\r\ndengan material tekstur anti-slip. Didukung oleh motor getar ganda, baterai isi ulang 600 mAh yang tahan\r\nhingga 20 jam, dan kompatibilitas dengan PC, Android, PS3, dan Nintendo Switch, GX150 menawarkan\r\nfleksibilitas dan kinerja yang luar biasa untuk semua jenis permainan.\r\n● Anti-Drifting Hall Effect Analog\r\n● Pressure-Sensitive Hall Effect Trigger\r\n● High Polling Rate up to 1000Hz\r\n● Dual Mode (Wireless Dongle & Wired)\r\n● Color Option: Black & White\r\n● Turbo Function Key\r\n● Comfort Grip with Anti Slip Textured Material\r\n● Support Xinput and Dinput\r\n● Dual Vibration Motor\r\n● Up To 20 Hours Play Time\r\n● Rechargeable 600 MaH Battery\r\n● Compatibility: PC, Android, PS3, and Nintendo Switch\r\n\r\nSPESIFIKASI\r\nKonektivitas : Kabel, 2.4G Wireless Dongle (Jangkauan hingga 8 meter)\r\nBaterai : Lithium Polymer 600 mAh\r\nDurasi Pemakaian : 8-20 jam\r\nWaktu Isi Ulang : 2-3 jam\r\nTeknologi Stik Analog : Hall Effect 360°\r\nKompatibilitas : PC, PS3, Android, & Nintendo Switch\r\nLampu : Indikator LED\r\nPanjang Kabel Daya : Kabel isi Daya type C 1.5M', 269000.00, 17, 5, 'gpad09.png', '2024-12-25 23:38:22', '2024-12-25 23:39:34'),
(50, 'Rexus Gamepad Gladius GX100 - Gamepad Joystick Android PC PS3', 'SPESIFIKASI\r\nMODE DUAL TERINTERGRASI X-input dan Direct-input yang kompatibel untuk semua game.\r\nTEKNOLOGI NIRKABEL 2.4GHz, dengan jangkauan frekuensi hingga 8 meter.\r\nBATERAI Lithium Polymer 600mAh dengan durasi pemakaian hingga 12 jam.\r\nWAKTU ISI ULANG BATERAI 2 – 3 jam.\r\nTEKNOLOGI STIK ANALOG Eccentric 360? yang lebih nyaman digunakan.\r\nTombol D Cross 8-way dengan ketepatan optimal.\r\nTombol pemicu double dan bumper analog.\r\n12 tombol numerik, termasuk [Home], [Start], [Select], dan lain sebagainya.\r\nTombol Backlit [A], [B], [X] [Y].\r\nTombol khusus “Rapid Fire” dengan mode [Turbo].\r\nDual motor vibrator untuk mengoptimalkan sensasi permainan.\r\nKOMPATIBILITAS PlayStation 3, Android, dan Windows XP ke atas\r\nLAMPU LED indikator (saat pengisian ulang daya, pemutusan daya, dan lain sebagainya).\r\nRECEIVER Nano USB\r\nPANJANG KABEL PENGISI ULANG DAYA 1m ± 5cm\r\nDIMENSI 158mm x 103mm x 69mm\r\nBERAT 190 gram\r\nBERAT PAKET 328 gram\r\nUKURAN DUS 170 x 65 x 200 mm', 249000.00, 31, 5, 'gpad10.png', '2024-12-25 23:40:30', '2024-12-25 23:40:30'),
(51, 'Fantech ATO SUPER MAXFIT MP905', '\r\nATO Deskmat MP905 Super Maxfit\r\n\r\nDurable &Artsy\r\nATO Deskmat MP905 Super Maxfit memiliki jahitan tepi yang kuat dan tahan lama. Jahitan deskmat tidak mudah lepas dan rusak sehingga cocok untuk penggunaan jangka panjang. Ditambah dengan desainnya yang sangat artistik sehingga sempurna untuk melengkapi setup kamu.\r\n\r\nScience-Based Performance\r\nATO Deskmat MP905 Super Maxfit dibuat dengan material kain yang minim gesekan statis dan kinetik. Material tersebut membantu mouse bergerak lebih cepat dibandingkan material kain lainnya.\r\n\r\nComfort &Control\r\nATO Deskmat MP905 Super Maxfit merupakan deskmat tipe kontrol yang siap mengatasi pergerakkan sekecil dan secepat apapun. Kamu tidak perlu khawatir mouse kehilangan kendali karena MP905 memiliki kapasitas untuk menanganinya dengan sempurna.\r\n\r\nHumidity &Spill Resistant Material &Control\r\nDengan ATO Deskmat MP905 Super Maxfit kamu bisa bebas membawa berbagai macam makanan dan minuman ke atas meja. Deskmat ini memiliki material kain yang tahan terhadap air sehingga tumpahan minuman ataupun makan tidak lagi menjadi masalah.\r\n\r\nAnti-Slip Base\r\nMulai sekarang kamu bisa ucapkan selamat tinggal kepada semua distraksi yang mengganggu selama bermain game. ATO Deskmat MP905 Super Maxfit dirancang dengan base anti slip sehingga kamu bisa fokus pada permainan tanpa terganggu oleh deskmat yang bergeser dengan sendirinya.', 199000.00, 23, 6, 'mpad01.png', '2024-12-25 23:42:29', '2024-12-25 23:45:01'),
(52, 'Steelseries Mousepad QcK Prism Cloth XL RGB - Gaming Mousepad', '> Brilliant 2-zone RGB dynamic illumination\r\n> Easy and intuitive setup of in-game lighting notifications\r\n> QcK micro-woven cloth for maximum control\r\n> Optimized for low and high DPI tracking movements\r\n> 900 mm x 300 mm x 4 mm\r\n', 980000.00, 22, 6, 'mpad02.png', '2024-12-25 23:44:31', '2024-12-25 23:45:05'),
(53, 'Razer Gigantus V2 Pokemon Edition Gaming Mousepad Anti Slip Base', 'Woven For Speed, Crafted For Control\r\n\r\nTextured Micro-Weave Cloth Surface\r\nThick, High-Density Rubber Foam With Anti-Slip Base\r\nAnti-Slip Base\r\n\r\nTech Specs:\r\n\r\nSizes: Medium (Width x Depth x Thickness : 360 mm x 275 mm x 3 mm)\r\nThickness: 0.11\" / 3 mm\r\nSurface: Soft\r\nMat Type: Soft\r\nChroma RGB: No\r\nSpecial Features: None', 999000.00, 4, 6, 'mpad03.png', '2024-12-25 23:46:01', '2024-12-26 00:27:14'),
(54, 'Logitech G640 Cloth Gaming Mousepad', 'TECHNICAL SPECIFICATIONS\r\n\r\nHeight: 15.75 in (400 mm)\r\nWidth: 18.11 in (460 mm)\r\nDepth: 0.10 in (3 mm)\r\nWeight: 12.42 oz (352 g, approximate)\r\n\r\nMODERATE SURFACE FRICTION\r\n\r\nCrafted for control\r\nWhen you use low-DPI settings you benefit from moderate resistance to the mouse feet when starting or stopping a rapid or sudden movement common to low DPI gaming. G640 features a surface heat-treated at 200 C to provide just the right amount of friction for low-DPI gaming maneuvers.\r\n\r\nCONSISTENT SURFACE TEXTURE\r\nEdge-to-edge performance\r\nHeavy patterns and designs can interfere with sensor performance. G640 features a clean, consistent surface texture. This gives sensors better imagery for translating mouse movement into cursor movement, an improvement over inconsistent or dirty table and desk surfaces.\r\nMATCHED TO LOGITECH G SENSORS\r\nSTABLE RUBBER BASE\r\nSize 400x460x3mm', 479000.00, 12, 6, 'mpad04.png', '2024-12-25 23:47:19', '2024-12-25 23:47:19'),
(55, 'Steelseries Qck Heavy - Original Garansi Resmi - Mousepad Gaming', 'STEELSERIES QCK HEAVY LARGE\r\n\r\n450mm x 400mm x 6mm\r\n\r\n\r\nThe QcK Heavy is a monster among cloth mouse pads. Nothing less. It is a super-sized mouse pad made of a high quality cloth material with a specially designed non-slip rubber base which prevents the pad from sliding; no matter what surface the mouse pad is placed on.\r\n\r\nIt\'s important to notice the difference between the QcK Heavy and all other mouse pads from our SteelSeries product line. This mouse pad features extremely heavy thickness which results in a very unique feeling. While the mouse pad is much more soft and comfortable to touch, the height is also fairly massive, reaching a total of 6mm. Other mouse pads from SteelSeries are very thin, aiming to provide a high quality gaming surface, as close as possible to level of the tabletop it\'s used on.\r\n\r\nThis mouse pad features extremely heavy thickness which results in a very unique feeling. While the mouse pad is much more soft and comfortable to touch, the height is also fairly massive, reaching a total of 6mm.', 440000.00, 2, 6, 'mpad05.png', '2024-12-25 23:48:23', '2024-12-25 23:48:23'),
(56, 'Razer Atlas Gaming Mousepad Hard Surface Tempered glass Anti-slip Base', 'TECH SPECS\r\n\r\nAPPROXIMATE SIZE\r\nLength: 450 mm / 17.72\"\r\nWidth: 400 mm / 15.75\"\r\n\r\nTHICKNESS\r\n5 mm / 0.19 in\r\n\r\nSURFACE\r\nTempered glass\r\n\r\nMAT TYPE\r\nHard\r\n\r\nCHROMA RGB\r\nNone\r\n\r\nSPECIAL FEATURES\r\nAnti-slip rubber base', 1699000.00, 5, 6, 'mpad06.png', '2024-12-25 23:49:12', '2024-12-25 23:49:12'),
(57, 'Razer Firefly V2 RGB Chroma - Gaming Mousepad', 'TECH SPECS\r\nAt a Glance\r\nRazer Chroma™ customizable RGB lighting\r\nMicro-textured surface\r\nBuilt-in cable catch\r\nAll-round edge lighting\r\nOptimized surface coating\r\nFull Specs\r\nPowered by Razer Chroma™ customizable RGB lighting\r\nMicro-textured finish for highly responsive tracking\r\nCable catch\r\n19 lighting zones\r\nOptimized surface coating for balanced gameplay\r\nUltra-thin form factor with non-slip rubber base\r\nRazer Synapse enabled\r\nBraided USB cable\r\nDimensions: 355mm x 255mm x 3mm', 899000.00, 3, 6, 'mpad07.png', '2024-12-25 23:49:56', '2024-12-26 00:29:50'),
(58, 'Fantech AGILE MP903 Size XL Mousepad Gaming', 'AGILE MP903 Ukuran XL 90cm x 40cm dengan tebal 3mm\r\n\r\nSUPERIOR DENSE & FINE STITCHING\r\nMousepad AGILE Series memiliki pinggiran jahitan padat dan halus yang superior sehingga anda tidak perlu khawatir mousepad terkelupas atau rusak.\r\n\r\nSCIENCE-BASED PERFORMANCE\r\nBahan kain mousepad AGILE series yang unik dan satu-satunya, dirancang untuk AGILITY dan memiliki gesekan statis dan kinetik yang rendah, membuatnya sangat cepat tidak seperti kebanyakan Mousepad lain pada umumnya.\r\n\r\nANTI-SLIP BASE\r\nKalian tidak akan merasakan lagi gangguan mousepad kalian bergeser waktu bermain kompetitif karena mousepad AGILE series ini berbasis anti-slip berbahan rubber premium yang kuat untuk tetap pada posisi di atas meja.\r\n\r\nHUMIDITY & SPILL RESISTANT MATERIAL\r\nMousepad AGILE Series didesain secara professional-grade Water Resistant material, yang mampu menangani sebagian besar tumpahan air dan kelembapan. Tetap fokus dalam permainan tanpa khawatir mousepad anda.\r\n\r\nSUPERIOR ACCURACY\r\nMousepad AGILE Series sangat mampu menangani gerakan terkecil atau tercepat, tanpa kehilangan kendali. Sudah melalui tahap pengujian yang mampu mendukung pemakaian mouse gaming dengan sensor paling tinggi, untuk memberi Anda keunggulan paling kompetitif dalam game Anda.', 99000.00, 76, 6, 'mpad08.png', '2024-12-25 23:50:42', '2024-12-25 23:50:42'),
(59, 'VortexSeries Urban Poron Mousepad', 'VortexSeries Urban Anti Slip Poron Based Gaming Mousepad\r\n\r\n\r\nIntroducing the VortexSeries Urban Mousepad: meticulously crafted for the ultimate gaming experience. Engineered for seamless speed and precise control, this mousepad boasts a finely-woven, premium top-surface that\'s both skin-friendly and smooth to the touch. Its neutral, slippery design optimizes mouse movement, striking the perfect balance between agility and accuracy. The exquisite Urban Modern artwork, printed using a sophisticated heat transfer process, ensures a true matte finish that complements any setup. Liquid-resistant and built to last, this mousepad guarantees durability and a silky smooth glide, even in the face of spills. Elevate your productivity and gaming performance with comfort and precision with the VortexSeries Urban Mousepad.\r\n\r\nKey Features:\r\n- Perfect Balance Between Speed & Control\r\n- Silky Smooth Top-Surface for Effortless Glide\r\n- Finely-Weaved Design for Enhanced Durability\r\n- Figurative Modern Urban Theme for Aesthetic Appeal\r\n- Liquid Resistant for Longevity\r\n- Non-Slippery Poron Base Material for Stability\r\n- Finely Weaved Edges for Added Durability\r\n- Double-Protection Packaging for Secure Transit\r\n\r\nSpecifications:\r\n- Size: 450 mm x 400 mm\r\n- Thickness: 3.6mm - 4mm\r\n- Base Material: Poron\r\n- Stitch: Quality Stitched Edges', 189000.00, 51, 6, 'mpad09.png', '2024-12-25 23:51:25', '2024-12-25 23:51:25'),
(60, 'Rexus KVLAR T10 Speed Edition', 'For Better Acceleration and Durability\r\n\r\n- Mousepad berkarakter “Speed” dengan ukuran yg lebar\r\n- Bahan anti-air yang memudahkan Anda untuk segera mengeringkan dan menggunakannya kembali setelah terkena tumpahan air minum saat bermain.\r\n- Lapisan permukaan kain tekstur dan bahan dasar karet disatukan dengan metode pres dan diperkuat dengan jahitan obras benang nilon di pinggir mousepad sehingga menyatu dan tak dapat mengelupas.\r\n- Mendukung pergerakan yang presisi\r\n- Karet Anti-selip setebal 3mm yang dapat secara mudah menyesuaikan dengan permukaan di bawahnya.\r\n- Mousepad Rexus KVLAR T10 memungkinkan untuk dicuci secara manual dengan menggunakan sabun cuci dan air, juga dapat dengan mudah dibersihkan dengan menggunakan lap yang dibasahi cairan pembersih.\r\n\r\nSpesifikasi\r\nPermukaan: Kain Tekstur\r\nDasar: Karet bertekstur anti-slip\r\nUkuran\r\n- Panjang 800mm\r\n- Lebar 300mm\r\n- Ketebalan 3mm', 75000.00, 34, 6, 'mpad10.png', '2024-12-25 23:52:28', '2024-12-25 23:52:28');

-- --------------------------------------------------------

--
-- Struktur dari tabel `transactions`
--

CREATE TABLE `transactions` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `address_id` int(11) DEFAULT NULL,
  `total` decimal(10,2) NOT NULL,
  `transaction_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` enum('Menunggu Pembayaran','Terbayar','Dikirim','Selesai','Dibatalkan') DEFAULT 'Menunggu Pembayaran',
  `invoice` varchar(255) NOT NULL,
  `number` int(11) NOT NULL,
  `payment_id` int(11) DEFAULT NULL,
  `approved_by` int(11) DEFAULT NULL,
  `approved_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data untuk tabel `transactions`
--

INSERT INTO `transactions` (`id`, `user_id`, `address_id`, `total`, `transaction_date`, `status`, `invoice`, `number`, `payment_id`, `approved_by`, `approved_at`, `created_at`, `updated_at`) VALUES
(98, 9, 12, 1311000.00, '2025-01-03 16:18:06', 'Terbayar', 'INV/20250103/000001', 1, 51, NULL, NULL, '2025-01-03 16:18:06', '2025-01-03 16:18:10');

-- --------------------------------------------------------

--
-- Struktur dari tabel `transaction_details`
--

CREATE TABLE `transaction_details` (
  `id` int(11) NOT NULL,
  `transaction_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `product_name` varchar(255) DEFAULT NULL,
  `product_price` decimal(10,2) DEFAULT NULL,
  `product_image_url` varchar(255) DEFAULT NULL,
  `product_category_id` int(11) DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `total_price` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data untuk tabel `transaction_details`
--

INSERT INTO `transaction_details` (`id`, `transaction_id`, `product_id`, `product_name`, `product_price`, `product_image_url`, `product_category_id`, `quantity`, `total_price`) VALUES
(116, 98, 19, 'Yunzii YZ98 YZ-98 Pro Wireless Mechanical Keyboard', 1299000.00, 'keyboard09.png', 2, 1, 1299000.00);

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `is_admin` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`, `is_admin`, `created_at`, `updated_at`) VALUES
(9, '123', '123@gmail.com', '$2b$12$0nFckzktMD0Fb16a8JsNA.mWkK/dKDPTWQnCAEJmx6JANeZnqEYKq', 0, '2025-01-03 16:17:42', '2025-01-03 16:17:42');

-- --------------------------------------------------------

--
-- Struktur dari tabel `wishlists`
--

CREATE TABLE `wishlists` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `addresses`
--
ALTER TABLE `addresses`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `user_id` (`user_id`) USING BTREE;

--
-- Indeks untuk tabel `carts`
--
ALTER TABLE `carts`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `user_id` (`user_id`) USING BTREE,
  ADD KEY `product_id` (`product_id`) USING BTREE;

--
-- Indeks untuk tabel `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indeks untuk tabel `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `verified_by` (`verified_by`) USING BTREE;

--
-- Indeks untuk tabel `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `category_id` (`category_id`) USING BTREE;

--
-- Indeks untuk tabel `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `user_id` (`user_id`) USING BTREE,
  ADD KEY `address_id` (`address_id`) USING BTREE,
  ADD KEY `payment_id` (`payment_id`) USING BTREE,
  ADD KEY `approved_by` (`approved_by`) USING BTREE;

--
-- Indeks untuk tabel `transaction_details`
--
ALTER TABLE `transaction_details`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `transaction_id` (`transaction_id`) USING BTREE,
  ADD KEY `product_id` (`product_id`) USING BTREE;

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD UNIQUE KEY `username` (`username`) USING BTREE,
  ADD UNIQUE KEY `email` (`email`) USING BTREE;

--
-- Indeks untuk tabel `wishlists`
--
ALTER TABLE `wishlists`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `user_id` (`user_id`) USING BTREE,
  ADD KEY `product_id` (`product_id`) USING BTREE;

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `addresses`
--
ALTER TABLE `addresses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT untuk tabel `carts`
--
ALTER TABLE `carts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=93;

--
-- AUTO_INCREMENT untuk tabel `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT untuk tabel `payments`
--
ALTER TABLE `payments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT untuk tabel `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT untuk tabel `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=99;

--
-- AUTO_INCREMENT untuk tabel `transaction_details`
--
ALTER TABLE `transaction_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=117;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT untuk tabel `wishlists`
--
ALTER TABLE `wishlists`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `addresses`
--
ALTER TABLE `addresses`
  ADD CONSTRAINT `addresses_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `carts`
--
ALTER TABLE `carts`
  ADD CONSTRAINT `carts_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `carts_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`verified_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Ketidakleluasaan untuk tabel `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL;

--
-- Ketidakleluasaan untuk tabel `transactions`
--
ALTER TABLE `transactions`
  ADD CONSTRAINT `transactions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `transactions_ibfk_2` FOREIGN KEY (`address_id`) REFERENCES `addresses` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `transactions_ibfk_3` FOREIGN KEY (`payment_id`) REFERENCES `payments` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `transactions_ibfk_4` FOREIGN KEY (`approved_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Ketidakleluasaan untuk tabel `transaction_details`
--
ALTER TABLE `transaction_details`
  ADD CONSTRAINT `transaction_details_ibfk_1` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `transaction_details_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `wishlists`
--
ALTER TABLE `wishlists`
  ADD CONSTRAINT `wishlists_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `wishlists_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
