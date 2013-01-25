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
    public partial class Comprador : Form
    {
        public Comprador()
        {

            InitializeComponent();
            tabla.DefaultCellStyle.WrapMode = DataGridViewTriState.True;
            Conexion conexion = new Conexion();

            if (conexion.AbrirConexion("isaac", "isaac"))
            {
                DataTable tablaBD = conexion.procemiento("CT_Comprador");
                llenarTabla(tablaBD);
            }
        }

        public void llenarTabla(DataTable tablaAux)
        {

            tabla.DataSource = tablaAux;
           
        }

        private void BTBuscar_Click(object sender, EventArgs e)
        {
            string nombre, obra, apellido;
            if (TBApellidos.TextLength == 0)
                apellido = "null";
            else
                apellido = TBApellidos.Text;

            if (TBNombres.TextLength == 0)
                nombre = "null";
            else
                nombre = TBNombres.Text;

            if (TBObra.TextLength == 0)
                obra = "null";
            else
                obra = TBObra.Text;

            Conexion conexion = new Conexion();
            if (conexion.AbrirConexion("isaac", "isaac"))
            {
                DataTable tablaDB = conexion.filtrar("FT_comprador", obra + "," + nombre + "," + apellido);
                tabla.DataSource = tablaDB;
            }

        }




   }

     

     

    }
