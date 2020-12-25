using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace shoppe.DTO
{
    class PhieuThanhToanDTO
    {
        private string MaPhieu;
        private string MaVoucher;
        private float TongGiaTriGoc;
        private float GiaVanChuyen;
        private float TongGiaTriCanThanhToan;
        private bool TrangThai;

        public string MaPhieu1 { get => MaPhieu; set => MaPhieu = value; }
        public string MaVoucher1 { get => MaVoucher; set => MaVoucher = value; }
        public float TongGiaTriGoc1 { get => TongGiaTriGoc; set => TongGiaTriGoc = value; }
        public float GiaVanChuyen1 { get => GiaVanChuyen; set => GiaVanChuyen = value; }
        public float TongGiaTriCanThanhToan1 { get => TongGiaTriCanThanhToan; set => TongGiaTriCanThanhToan = value; }
        public bool TrangThai1 { get => TrangThai; set => TrangThai = value; }
    }
}
