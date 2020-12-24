/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2008                    */
/* Created on:     12/22/2020 2:32:04 PM                        */
/*==============================================================*/
--drop database test
--create database test
use test
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('CHITIETNGANHHANG') and o.name = 'FK_CHITIETN_CO_CAC_TH_NHOMNGAN')
alter table CHITIETNGANHHANG
   drop constraint FK_CHITIETN_CO_CAC_TH_NHOMNGAN
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('DIACHI') and o.name = 'FK_DIACHI_CO_DIA_CH_TAIKHOAN')
alter table DIACHI
   drop constraint FK_DIACHI_CO_DIA_CH_TAIKHOAN
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('LOAIDIACHI') and o.name = 'FK_LOAIDIAC_THUOC_LOA_DIACHI')
alter table LOAIDIACHI
   drop constraint FK_LOAIDIAC_THUOC_LOA_DIACHI
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('LUACHON') and o.name = 'FK_LUACHON_CO_LUA__C_THONGTIN')
alter table LUACHON
   drop constraint FK_LUACHON_CO_LUA__C_THONGTIN
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('MATHANG') and o.name = 'FK_MATHANG_BAN_HANG_SHOP')
alter table MATHANG
   drop constraint FK_MATHANG_BAN_HANG_SHOP
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('MATHANG') and o.name = 'FK_MATHANG_CO_THONG__THONGTIN2')
alter table MATHANG
   drop constraint FK_MATHANG_CO_THONG__THONGTIN2
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('MATHANG') and o.name = 'FK_MATHANG_CO_THONG__THONGTIN')
alter table MATHANG
   drop constraint FK_MATHANG_CO_THONG__THONGTIN
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('MATHANG') and o.name = 'FK_MATHANG_CO_THONG__THONGTIN3')
alter table MATHANG
   drop constraint FK_MATHANG_CO_THONG__THONGTIN3
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('NHOMNGANHHANG') and o.name = 'FK_NHOMNGAN_THUOC_NHO_MATHANG')
alter table NHOMNGANHHANG
   drop constraint FK_NHOMNGAN_THUOC_NHO_MATHANG
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('PHIEUTHANHTOAN') and o.name = 'FK_PHIEUTHA_GIAM_GIA2_VOUCHER')
alter table PHIEUTHANHTOAN
   drop constraint FK_PHIEUTHA_GIAM_GIA2_VOUCHER
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('SANPHAMCHON') and o.name = 'FK_SANPHAMC_CHON_MUA__MATHANG')
alter table SANPHAMCHON
   drop constraint FK_SANPHAMC_CHON_MUA__MATHANG
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('SANPHAMCHON') and o.name = 'FK_SANPHAMC_CO_MAT_HA_TAIKHOAN')
alter table SANPHAMCHON
   drop constraint FK_SANPHAMC_CO_MAT_HA_TAIKHOAN
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('SANPHAMCHON') and o.name = 'FK_SANPHAMC_THANHTOAN_PHIEUTHA')
alter table SANPHAMCHON
   drop constraint FK_SANPHAMC_THANHTOAN_PHIEUTHA
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('SHOP') and o.name = 'FK_SHOP_CO2_TAIKHOAN')
alter table SHOP
   drop constraint FK_SHOP_CO2_TAIKHOAN
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('TAIKHOAN') and o.name = 'FK_TAIKHOAN_CO_SHOP')
alter table TAIKHOAN
   drop constraint FK_TAIKHOAN_CO_SHOP
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('THONGTINBANHANG') and o.name = 'FK_THONGTIN_CO_THONG__MATHANG2')
alter table THONGTINBANHANG
   drop constraint FK_THONGTIN_CO_THONG__MATHANG2
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('THONGTINKHAC') and o.name = 'FK_THONGTIN_CO_THONG__MATHANG')
alter table THONGTINKHAC
   drop constraint FK_THONGTIN_CO_THONG__MATHANG
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('THONGTINVANCHUYEN') and o.name = 'FK_THONGTIN_CO_THONG__MATHANG3')
alter table THONGTINVANCHUYEN
   drop constraint FK_THONGTIN_CO_THONG__MATHANG3
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('VAN_CHUYEN_MAT_HANG') and o.name = 'FK_VAN_CHUY_VAN_CHUYE_DONVIVAN')
alter table VAN_CHUYEN_MAT_HANG
   drop constraint FK_VAN_CHUY_VAN_CHUYE_DONVIVAN
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('VAN_CHUYEN_MAT_HANG') and o.name = 'FK_VAN_CHUY_VAN_CHUYE_THONGTIN')
alter table VAN_CHUYEN_MAT_HANG
   drop constraint FK_VAN_CHUY_VAN_CHUYE_THONGTIN
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('VOUCHER') and o.name = 'FK_VOUCHER_GIAM_GIA_PHIEUTHA')
alter table VOUCHER
   drop constraint FK_VOUCHER_GIAM_GIA_PHIEUTHA
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('VOUCHERSHOP') and o.name = 'FK_VOUCHERS_INHERITAN_VOUCHER')
alter table VOUCHERSHOP
   drop constraint FK_VOUCHERS_INHERITAN_VOUCHER
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('VOUCHERSHOP') and o.name = 'FK_VOUCHERS_THUOC_VE_SHOP')
alter table VOUCHERSHOP
   drop constraint FK_VOUCHERS_THUOC_VE_SHOP
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('CHITIETNGANHHANG')
            and   name  = 'CO_CAC_THONG_SO_FK'
            and   indid > 0
            and   indid < 255)
   drop index CHITIETNGANHHANG.CO_CAC_THONG_SO_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('CHITIETNGANHHANG')
            and   type = 'U')
   drop table CHITIETNGANHHANG
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('DIACHI')
            and   name  = 'CO_DIA_CHI_FK'
            and   indid > 0
            and   indid < 255)
   drop index DIACHI.CO_DIA_CHI_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('DIACHI')
            and   type = 'U')
   drop table DIACHI
go

if exists (select 1
            from  sysobjects
           where  id = object_id('DONVIVANCHUYEN')
            and   type = 'U')
   drop table DONVIVANCHUYEN
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('LOAIDIACHI')
            and   name  = 'THUOC_LOAI_FK'
            and   indid > 0
            and   indid < 255)
   drop index LOAIDIACHI.THUOC_LOAI_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('LOAIDIACHI')
            and   type = 'U')
   drop table LOAIDIACHI
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('LUACHON')
            and   name  = 'CO_LUA__CHON_FK'
            and   indid > 0
            and   indid < 255)
   drop index LUACHON.CO_LUA__CHON_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('LUACHON')
            and   type = 'U')
   drop table LUACHON
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('MATHANG')
            and   name  = 'BAN_HANG_FK'
            and   indid > 0
            and   indid < 255)
   drop index MATHANG.BAN_HANG_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('MATHANG')
            and   name  = 'CO_THONG_TIN_KHAC_FK'
            and   indid > 0
            and   indid < 255)
   drop index MATHANG.CO_THONG_TIN_KHAC_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('MATHANG')
            and   name  = 'CO_THONG_TIN_VAN_CHUYEN_FK'
            and   indid > 0
            and   indid < 255)
   drop index MATHANG.CO_THONG_TIN_VAN_CHUYEN_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('MATHANG')
            and   name  = 'CO_THONG_TIN_BAN_HANG_FK'
            and   indid > 0
            and   indid < 255)
   drop index MATHANG.CO_THONG_TIN_BAN_HANG_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('MATHANG')
            and   type = 'U')
   drop table MATHANG
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('NHOMNGANHHANG')
            and   name  = 'THUOC_NHOM_HANG_FK'
            and   indid > 0
            and   indid < 255)
   drop index NHOMNGANHHANG.THUOC_NHOM_HANG_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('NHOMNGANHHANG')
            and   type = 'U')
   drop table NHOMNGANHHANG
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('PHIEUTHANHTOAN')
            and   name  = 'GIAM_GIA2_FK'
            and   indid > 0
            and   indid < 255)
   drop index PHIEUTHANHTOAN.GIAM_GIA2_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('PHIEUTHANHTOAN')
            and   type = 'U')
   drop table PHIEUTHANHTOAN
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('SANPHAMCHON')
            and   name  = 'THANHTOANMATHANG_FK'
            and   indid > 0
            and   indid < 255)
   drop index SANPHAMCHON.THANHTOANMATHANG_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('SANPHAMCHON')
            and   name  = 'CHON_MUA_HANG_FK'
            and   indid > 0
            and   indid < 255)
   drop index SANPHAMCHON.CHON_MUA_HANG_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('SANPHAMCHON')
            and   name  = 'CO_MAT_HANG_TRONG_GIO_FK'
            and   indid > 0
            and   indid < 255)
   drop index SANPHAMCHON.CO_MAT_HANG_TRONG_GIO_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('SANPHAMCHON')
            and   type = 'U')
   drop table SANPHAMCHON
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('SHOP')
            and   name  = 'CO2_FK'
            and   indid > 0
            and   indid < 255)
   drop index SHOP.CO2_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('SHOP')
            and   type = 'U')
   drop table SHOP
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('TAIKHOAN')
            and   name  = 'CO_FK'
            and   indid > 0
            and   indid < 255)
   drop index TAIKHOAN.CO_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('TAIKHOAN')
            and   type = 'U')
   drop table TAIKHOAN
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('THONGTINBANHANG')
            and   name  = 'CO_THONG_TIN_BAN_HANG2_FK'
            and   indid > 0
            and   indid < 255)
   drop index THONGTINBANHANG.CO_THONG_TIN_BAN_HANG2_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('THONGTINBANHANG')
            and   type = 'U')
   drop table THONGTINBANHANG
go

if exists (select 1
            from  sysobjects
           where  id = object_id('THONGTINKHAC')
            and   type = 'U')
   drop table THONGTINKHAC
go

if exists (select 1
            from  sysobjects
           where  id = object_id('THONGTINVANCHUYEN')
            and   type = 'U')
   drop table THONGTINVANCHUYEN
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('VAN_CHUYEN_MAT_HANG')
            and   name  = 'VAN_CHUYEN_MAT_HANG2_FK'
            and   indid > 0
            and   indid < 255)
   drop index VAN_CHUYEN_MAT_HANG.VAN_CHUYEN_MAT_HANG2_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('VAN_CHUYEN_MAT_HANG')
            and   name  = 'VAN_CHUYEN_MAT_HANG_FK'
            and   indid > 0
            and   indid < 255)
   drop index VAN_CHUYEN_MAT_HANG.VAN_CHUYEN_MAT_HANG_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('VAN_CHUYEN_MAT_HANG')
            and   type = 'U')
   drop table VAN_CHUYEN_MAT_HANG
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('VOUCHER')
            and   name  = 'GIAM_GIA_FK'
            and   indid > 0
            and   indid < 255)
   drop index VOUCHER.GIAM_GIA_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('VOUCHER')
            and   type = 'U')
   drop table VOUCHER
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('VOUCHERSHOP')
            and   name  = 'THUOC_VE_FK'
            and   indid > 0
            and   indid < 255)
   drop index VOUCHERSHOP.THUOC_VE_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('VOUCHERSHOP')
            and   type = 'U')
   drop table VOUCHERSHOP
go

/*==============================================================*/
/* Table: CHITIETNGANHHANG                                      */
/*==============================================================*/
create table CHITIETNGANHHANG (
   MACHITIET            nvarchar(10)             not null,
   THONGSO              nvarchar(50)             not null,
   MANHOM               nvarchar(10)             not null,
   constraint PK_CHITIETNGANHHANG primary key nonclustered (MACHITIET, THONGSO)
)
go



/*==============================================================*/
/* Table: DIACHI                                                */
/*==============================================================*/
create table DIACHI (
   MADC                 nvarchar(10)             not null,
   MATAIKHOAN           nvarchar(10)             not null,
   TENNGUOIO            nvarchar(20)             not null,
   SODIENTHOAI          nvarchar(13)             not null,
   constraint PK_DIACHI primary key nonclustered (MADC)
)
go



/*==============================================================*/
/* Table: DONVIVANCHUYEN                                        */
/*==============================================================*/
create table DONVIVANCHUYEN (
   MADONVI              nvarchar(10)             not null,
   TENDONVI             nvarchar(20)             not null,
   KHOILUONGTOITHIEU    float                not null,
   KHOILUONGTOIDA       float                not null,
   GIATHANHMOTDONVI     float                not null,
   constraint PK_DONVIVANCHUYEN primary key nonclustered (MADONVI)
)
go

/*==============================================================*/
/* Table: LOAIDIACHI                                            */
/*==============================================================*/
create table LOAIDIACHI (
   MALOAI               nvarchar(10)             not null,
   MADC                 nvarchar(10)             null,
   LOAIDIACHI           nvarchar(10)             not null,
   constraint PK_LOAIDIACHI primary key nonclustered (MALOAI)
)
go




/*==============================================================*/
/* Table: LUACHON                                               */
/*==============================================================*/
create table LUACHON (
   MAMATHANG            nvarchar(10)             not null,
   TENCUMPHANLOAI       nvarchar(10)             not null,
   TENLUACHON           nvarchar(20)             not null,
   SOLUONGTONKHO        int                  not null,
   GIACA                float                not null,
   SKUPHANLOAI          nvarchar(10)             null,
   constraint PK_LUACHON primary key nonclustered (MAMATHANG, TENCUMPHANLOAI, TENLUACHON)
)
go



/*==============================================================*/
/* Table: MATHANG                                               */
/*==============================================================*/
create table MATHANG (
   MAMATHANG            nvarchar(10)             not null,
   MATAIKHOAN           nvarchar(10)             not null,
   MASHOP               nvarchar(10)             not null,
   TENMATHANG           nvarchar(20)             not null,
   MOTASANPHAM          nvarchar(20)             not null,
   KHOILUONGDONGGOI     float                not null,
   CHIEUDAI             float                not null,
   CHIEURONG            float                not null,
   CHIEUCAO             float                not null,
   GIAVANCHUYENDUKIEN   float                not null,
   DATHANGTRUOC         bit                  null,
   TINHTRANG            nvarchar(50)             null,
   SONGAYCANCHUANBI     int                  null,
   constraint PK_MATHANG primary key nonclustered (MAMATHANG)
)
go




/*==============================================================*/
/* Table: NHOMNGANHHANG                                         */
/*==============================================================*/
create table NHOMNGANHHANG (
   MANHOM               nvarchar(10)             not null,
   MAMATHANG            nvarchar(10)             null,
   TENNHOMHANG          nvarchar(50)             not null,
   constraint PK_NHOMNGANHHANG primary key nonclustered (MANHOM)
)
go



/*==============================================================*/
/* Table: PHIEUTHANHTOAN                                        */
/*==============================================================*/
create table PHIEUTHANHTOAN (
   MAPHIEU              nvarchar(10)             not null,
   MAVOUCHER            nvarchar(10)             null,
   TONGGIATRIGOC        float                not null,
   GIAVANCHUYEN         float                not null,
   TONGGIATRICANTHANHTOAN float                not null,
   TRANGTHAI            bit             not null,
   constraint PK_PHIEUTHANHTOAN primary key nonclustered (MAPHIEU)
)
go



/*==============================================================*/
/* Table: SANPHAMCHON                                           */
/*==============================================================*/
create table SANPHAMCHON (
   MATAIKHOAN           nvarchar(10)             not null,
   STT                  int                  not null,
   MAMATHANG            nvarchar(10)             not null,
   MAPHIEU              nvarchar(10)             null,
   SOLUONG              int                  not null,
   GIAGOC               float                not null,
   GIATRITHANHTOAN      float                not null,
   CONTRONGGIOHANG      bit                  not null,
   MAVOUCHER			nvarchar(10)		NULL,
   constraint PK_SANPHAMCHON primary key nonclustered (MATAIKHOAN, STT)
)
go


/*==============================================================*/
/* Table: TAIKHOAN                                              */
/*==============================================================*/
create table TAIKHOAN (
   MATAIKHOAN           nvarchar(10)             not null,
   MASHOP               nvarchar(10)             null unique,
   TENDANGNHAP          nvarchar(50)             not null,
   MATKHAU              nvarchar(50)             not null,
   HOSO                 nvarchar(50)             not null,
   TENKHACHHANG         nvarchar(20)             not null,
   EMAIL                nvarchar(20)             not null,
   NGAYSINH             datetime             not null,
   constraint PK_TAIKHOAN primary key nonclustered (MATAIKHOAN)
)
go




/*==============================================================*/
/* Table: VAN_CHUYEN_MAT_HANG                                   */
/*==============================================================*/
create table VAN_CHUYEN_MAT_HANG (
   MAMATHANG            nvarchar(10)             not null,
   MADONVI              nvarchar(10)             not null,
   constraint PK_VAN_CHUYEN_MAT_HANG primary key (MAMATHANG, MADONVI)
)
go


/*==============================================================*/
/* Table: VOUCHER                                               */
/*==============================================================*/
create table VOUCHER (
   MAVOUCHER            nvarchar(10)             not null,
   SOTIENGIAM           float                not null,
   PHANTRAMGIAM         float                not null,
   SOTIENTOITHIEUYEUCAU float                null,
   constraint PK_VOUCHER primary key nonclustered (MAVOUCHER)
)
go


/*==============================================================*/
/* Table: VOUCHERSHOP                                           */
/*==============================================================*/
create table VOUCHERSHOP (
   MAVOUCHER            nvarchar(10)             not null,
   MATAIKHOAN           nvarchar(10)             null,
   MASHOP               nvarchar(10)             NOT NULL,
   SOTIENGIAM           float                null,
   PHANTRAMGIAM         float                null,
   SOTIENTOITHIEUYEUCAU float                null,
   SOHANGTOITHIEU       int                  null,
   constraint PK_VOUCHERSHOP primary key (MAVOUCHER),
   constraint only_one_value 
        check (        (SOTIENGIAM is null or PHANTRAMGIAM is null) 
               and not (SOTIENGIAM is null and PHANTRAMGIAM is null) )
)
go



alter table CHITIETNGANHHANG
   add constraint FK_CHITIETN_CO_CAC_TH_NHOMNGAN foreign key (MANHOM)
      references NHOMNGANHHANG (MANHOM)
go

alter table DIACHI
   add constraint FK_DIACHI_CO_DIA_CH_TAIKHOAN foreign key (MATAIKHOAN)
      references TAIKHOAN (MATAIKHOAN)
go

alter table LOAIDIACHI
   add constraint FK_LOAIDIAC_THUOC_LOA_DIACHI foreign key (MADC)
      references DIACHI (MADC)
go

alter table LUACHON
   add constraint FK_LUACHON_CO_LUA__C_MATHANG foreign key (MAMATHANG)
      references MATHANG (MAMATHANG)
go




alter table MATHANG
   add constraint FK_MATHANG_BAN_HANG_TAIKHOAN foreign key (MATAIKHOAN)
      references TAIKHOAN (MATAIKHOAN)
go

--@@2

alter table MATHANG
   add constraint FK_MATHANG_BAN_HANG_TAIKHOAN2 foreign key (MASHOP)
      references TAIKHOAN (MASHOP)
go

--alter table MATHANG
--  add constraint FK_MATHANG_CO_THONG__THONGTIN2 foreign key (MAMATHANG, TENCUMPHANLOAI)
--     references THONGTINBANHANG (MAMATHANG, TENCUMPHANLOAI)
--go

--alter table MATHANG
--   add constraint FK_MATHANG_CO_THONG__THONGTIN foreign key (MAMATHANG)
--      references THONGTINKHAC (MAMATHANG)
--go


--alter table MATHANG
--   add constraint FK_MATHANG_CO_THONG__THONGTIN3 foreign key (MAMATHANG)
--      references THONGTINVANCHUYEN (MAMATHANG)
--go

alter table NHOMNGANHHANG
   add constraint FK_NHOMNGAN_THUOC_NHO_MATHANG foreign key (MAMATHANG)
      references MATHANG (MAMATHANG)
go

alter table PHIEUTHANHTOAN
   add constraint FK_PHIEUTHA_GIAM_GIA2_VOUCHER foreign key (MAVOUCHER)
      references VOUCHER (MAVOUCHER)
go

alter table SANPHAMCHON
   add constraint FK_SANPHAMC_CHON_MUA__MATHANG foreign key (MAMATHANG)
      references MATHANG (MAMATHANG)
go

alter table SANPHAMCHON
   add constraint FK_SANPHAMC_CO_MAT_HA_TAIKHOAN foreign key (MATAIKHOAN)
      references TAIKHOAN (MATAIKHOAN)
go

alter table SANPHAMCHON
   add constraint FK_SANPHAMC_THANHTOAN_PHIEUTHA foreign key (MAPHIEU)
      references PHIEUTHANHTOAN (MAPHIEU)
go

--alter table SHOP
--   add constraint FK_SHOP_CO2_TAIKHOAN foreign key (MATAIKHOAN)
--      references TAIKHOAN (MATAIKHOAN)
--go

--alter table TAIKHOAN
--   add constraint FK_TAIKHOAN_CO_SHOP foreign key (SHO_MATAIKHOAN, MASHOP)
--      references SHOP (MATAIKHOAN, MASHOP)
--go

--alter table THONGTINBANHANG
--   add constraint FK_THONGTIN_CO_THONG__MATHANG2 foreign key (MAMATHANG)
--      references MATHANG (MAMATHANG)
--go

--alter table THONGTINKHAC
--   add constraint FK_THONGTIN_CO_THONG__MATHANG foreign key (MAMATHANG)
--      references MATHANG (MAMATHANG)
--go

--alter table THONGTINVANCHUYEN
--   add constraint FK_THONGTIN_CO_THONG__MATHANG3 foreign key (MAMATHANG)
--      references MATHANG (MAMATHANG)
--go

alter table VAN_CHUYEN_MAT_HANG
   add constraint FK_VAN_CHUY_VAN_CHUYE_DONVIVAN foreign key (MADONVI)
      references DONVIVANCHUYEN (MADONVI)
go

alter table VAN_CHUYEN_MAT_HANG
   add constraint FK_VAN_CHUY_VAN_CHUYE_MATHANG foreign key (MAMATHANG)
      references MATHANG (MAMATHANG)
go

--alter table VOUCHER
--   add constraint FK_VOUCHER_GIAM_GIA_PHIEUTHA foreign key (MAPHIEU)
--      references PHIEUTHANHTOAN (MAPHIEU)
--go

alter table VOUCHERSHOP
   add constraint FK_VOUCHERS_INHERITAN_VOUCHER foreign key (MAVOUCHER)
      references VOUCHER (MAVOUCHER)
go

alter table VOUCHERSHOP
   add constraint FK_VOUCHERS_THUOC_VE_TAIKHOAN foreign key (MATAIKHOAN)
      references TAIKHOAN (MATAIKHOAN)
go

--@@3
alter table VOUCHERSHOP
   add constraint FK_VOUCHERS_THUOC_VE_TAIKHOAN2 foreign key (MASHOP)
      references TAIKHOAN (MASHOP)
go

ALTER TABLE dbo.SANPHAMCHON
	ADD CONSTRAINT fk_SANPHAMCHON_CO_VOUCHERSHOP FOREIGN KEY (MAVOUCHER)
		REFERENCES dbo.VOUCHERSHOP(MAVOUCHER)
