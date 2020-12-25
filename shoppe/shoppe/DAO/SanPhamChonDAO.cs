using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace shoppe.DAO
{
    class SanPhamChonDAO
    {
        private static SanPhamChonDAO instance;

        public static SanPhamChonDAO Instance
        {
            get { if (instance == null) instance = new SanPhamChonDAO(); return SanPhamChonDAO.instance; }
            private set { SanPhamChonDAO.instance = value; }
        }
    }
}
