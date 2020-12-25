using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace shoppe.DAO
{
    public class MatHangDAO
    {
        private static MatHangDAO instance;

        public static MatHangDAO Instance
        {
            get { if (instance == null) instance = new MatHangDAO(); return MatHangDAO.instance; }
            private set { MatHangDAO.instance = value; }
        }
    }
}
