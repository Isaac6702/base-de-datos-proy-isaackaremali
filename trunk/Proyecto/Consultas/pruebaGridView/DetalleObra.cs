using pruebaViewGrid;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.OracleClient;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace pruebaGridView
{
    public partial class DetalleObra : Form
    {
        public DetalleObra(String buscador)
        {
            System.Console.WriteLine(buscador);
            InitializeComponent();
            Conexion conexion = new Conexion();
            tabla.DefaultCellStyle.WrapMode = DataGridViewTriState.True;
            tablaMusicos.DefaultCellStyle.WrapMode = DataGridViewTriState.True;
            tablaPersonajes.DefaultCellStyle.WrapMode = DataGridViewTriState.True;
            if (conexion.AbrirConexion("isaac", "isaac"))
            {
                DataTable tablaBD = conexion.filtrar("CT_Partes", buscador);
                DataTable tablaBDPersonajes = conexion.filtrar("CT_Personajes", buscador);
                DataTable tablaBDMusicos = conexion.filtrar("CT_Musicos", buscador);
                llenarTabla(tablaBD, tablaBDPersonajes, tablaBDMusicos);
            }
        }

        public void llenarTabla(DataTable tablaAux, DataTable tablaP, DataTable tablaM)
        {

            tabla.DataSource = tablaAux;
            tablaPersonajes.DataSource = tablaP;
            tablaMusicos.DataSource = tablaM;
        }

        private void BTBuscar_Click(object sender, EventArgs e)
        {
            string prueba = null;
            Console.WriteLine(prueba);
        }

        private void button1_Click(object sender, EventArgs e)
        {
            //DESCARGAR EL LIBRETO
        }




   }

     

     

    }
