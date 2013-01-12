using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace pruebaGridView
{
    class DetalleFactura
    {

        private string costo;

        public string Costo
        {
            get { return costo; }
            set { costo = value; }
        }
        private string asiento;

        public string Asiento
        {
            get { return asiento; }
            set { asiento = value; }
        }
        private string zona;

        public string Zona
        {
            get { return zona; }
            set { zona = value; }
        }
        private string status;

        public string Status
        {
            get { return status; }
            set { status = value; }
        }


        public DetalleFactura(string asiento, string zona, string costo, string status)
        {
            this.Asiento = asiento;
            this.Zona = zona;
            this.Costo = costo;
            if (status.Equals("0"))
                this.Status = "NO pagada";
            if (status.Equals("1"))
                this.Status = "Pagada";


        }

    }
}
