using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace shoppe.DTO
{
    class SaPhamChonDTO
    {
        private string MaTaiKhoan;
        private int STT;
        private string MaMatHang;
        private string MaLuaChon;
        private string MaPhieu;
        private int SoLuong;
        private float GiaGoc;
        private float GiaTriCanThanhToan;
        private bool conTrongGioHang;
        private string MaVoucher;
        private string DonViVanChuyen;

        public string MaTaiKhoan1 { get => MaTaiKhoan; set => MaTaiKhoan = value; }
        public int STT1 { get => STT; set => STT = value; }
        public string MaMatHang1 { get => MaMatHang; set => MaMatHang = value; }
        public string MaLuaChon1 { get => MaLuaChon; set => MaLuaChon = value; }
        public string MaPhieu1 { get => MaPhieu; set => MaPhieu = value; }
        public int SoLuong1 { get => SoLuong; set => SoLuong = value; }
        public float GiaGoc1 { get => GiaGoc; set => GiaGoc = value; }
        public float GiaTriCanThanhToan1 { get => GiaTriCanThanhToan; set => GiaTriCanThanhToan = value; }
        public bool ConTrongGioHang { get => conTrongGioHang; set => conTrongGioHang = value; }
        public string MaVoucher1 { get => MaVoucher; set => MaVoucher = value; }
        public string DonViVanChuyen1 { get => DonViVanChuyen; set => DonViVanChuyen = value; }
    }
}
