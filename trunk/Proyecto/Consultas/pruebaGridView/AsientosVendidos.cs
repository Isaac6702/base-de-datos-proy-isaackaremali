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
    public partial class AsientosVendidos : Form
    {
        Conexion conexion = new Conexion();
        public AsientosVendidos()
        {
            InitializeComponent();
            tabla.DefaultCellStyle.WrapMode = DataGridViewTriState.True;
            if (conexion.AbrirConexion("isaac", "isaac"))
            {
                DataTable tablaBD = conexion.procemiento("CT_Asientos_vendidos");
                llenarTabla(tablaBD);
            }
        }

        public void llenarTabla(DataTable tablaAux)
        {

            tabla.DataSource = tablaAux;
           
        }

        private void BTBuscar_Click(object sender, EventArgs e)
        {

            if (TBObra.Left == 0)
            {
                TBObra.Text="null";


            }
            if (TBUbicacion.Left == 0)
            {
                TBUbicacion.Text = "null";

            }

            if (conexion.AbrirConexion("isaac", "isaac") && TBObra.Left == 0 && TBUbicacion.Left == 0)
            {
                DataTable tablaBD = conexion.procemiento("CT_Asientos_vendidos");
                llenarTabla(tablaBD);
            }
            else
            {
                DataTable tablaBD = conexion.filtrar("FT_Asientos_Vendidos", TBObra.Text+","+TBUbicacion.Text);
                llenarTabla(tablaBD);

            }

        }




   }

     

     

    }
