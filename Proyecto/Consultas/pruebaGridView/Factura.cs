using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace pruebaGridView
{
    class Factura
    {

        private string nombresApellidos;

        public string NombresApellidos
        {
            get { return nombresApellidos; }
            set { nombresApellidos = value; }
        }
        private string direccion;

        public string Direccion
        {
            get { return direccion; }
            set { direccion = value; }
        }
        private string id;

        public string Id
        {
            get { return id; }
            set { id = value; }
        }
        private string telefono;

        public string Telefono
        {
            get { return telefono; }
            set { telefono = value; }
        }
        private string fecha;

        public string Fecha
        {
            get { return fecha; }
            set { fecha = value; }
        }
        private string nroFactura;

        public string NroFactura
        {
            get { return nroFactura; }
            set { nroFactura = value; }
        }
        private List<DetalleFactura> df;

        internal List<DetalleFactura> Df
        {
            get { return df; }
            set { df = value; }
        }
    
    }
}
