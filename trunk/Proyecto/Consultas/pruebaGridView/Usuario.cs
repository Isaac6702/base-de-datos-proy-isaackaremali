using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace pruebaGridView
{

    class Usuario
    {
        private string fechaPresentacion;

        public string FechaPresentacion
        {
            get { return fechaPresentacion; }
            set { fechaPresentacion = value; }
        }
        private int nro_entradas;

        public int Nro_entradas
        {
            get { return nro_entradas; }
            set { nro_entradas = value; }
        }
        private string obra;

        public string Obra
        {
            get { return obra; }
            set { obra = value; }
        }

        private List<int> idZona;

        public List<int> IdZona
        {
            get { return idZona; }
            set { idZona = value; }
        }

        
        private string nombre;

        public string Nombre
        {
            get { return nombre; }
            set { nombre = value; }
        }
        private long identificador;

        public long Identificador
        {
            get { return identificador; }
            set { identificador = value; }
        }
        private List<int> telefono;

        public List<int> Telefono
        {
            get { return telefono; }
            set { telefono = value; }
        }
        private string detalleDireccion;

        public string DetalleDireccion
        {
            get { return detalleDireccion; }
            set { detalleDireccion = value; }
        }
        private int fkDireccion;

        public int FkDireccion
        {
            get { return fkDireccion; }
            set { fkDireccion = value; }
        }
        private int fkNacionalidad;

        public int FkNacionalidad
        {
            get { return fkNacionalidad; }
            set { fkNacionalidad = value; }
        }

        public void imprimir()
        {
            Console.WriteLine("id "+ this.Identificador);
            Console.WriteLine("detalle " + this.DetalleDireccion);
            Console.WriteLine("fkdireccion " + this.FkDireccion);
            Console.WriteLine("fknacionalidad " + this.FkNacionalidad);
            Console.WriteLine("idzona " + this.idZona);
            Console.WriteLine("nombre empresa " + this.Nombre);
            Console.WriteLine("obra " + this.Obra);
            Console.WriteLine("telefono " + this.Telefono);

        }


    }
}
