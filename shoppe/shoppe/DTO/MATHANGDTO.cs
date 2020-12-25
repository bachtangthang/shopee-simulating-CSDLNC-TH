using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace shoppe.DTO
{
    class MATHANGDTO
    {
        private string MaMatHang;
        private string MaTaiKhoan;
        private string MaShop;
        private string TenMatHang;
        private string MoTaSanPham;
        private float khoiLuong;
        private float chieuDai;
        private float chieuRong;
        private float chieuCao;
        private float giaVanChuyen;
        private bool datHangTruoc;
        private bool tinhTrang;
        private int soNgayChuanBi;
        

        public string MaMatHang1 { get => MaMatHang; set => MaMatHang = value; }
        public string MaTaiKhoan1 { get => MaTaiKhoan; set => MaTaiKhoan = value; }
        public string MaShop1 { get => MaShop; set => MaShop = value; }
        public string TenMatHang1 { get => TenMatHang; set => TenMatHang = value; }
        public string MoTaSanPham1 { get => MoTaSanPham; set => MoTaSanPham = value; }
        public float KhoiLuong { get => khoiLuong; set => khoiLuong = value; }
        public float ChieuDai { get => chieuDai; set => chieuDai = value; }
        public float ChieuRong { get => chieuRong; set => chieuRong = value; }
        public float ChieuCao { get => chieuCao; set => chieuCao = value; }
        public float GiaVanChuyen { get => giaVanChuyen; set => giaVanChuyen = value; }
        public bool DatHangTruoc { get => datHangTruoc; set => datHangTruoc = value; }
        public bool TinhTrang { get => tinhTrang; set => tinhTrang = value; }
        public int SoNgayChuanBi { get => soNgayChuanBi; set => soNgayChuanBi = value; }
    }
}
