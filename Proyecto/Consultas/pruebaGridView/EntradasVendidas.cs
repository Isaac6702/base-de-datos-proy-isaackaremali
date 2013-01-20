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
    public partial class EntradasVendidas : Form
    {
        DataTable tablaAux = new DataTable();
        Conexion conexion = new Conexion();
        public EntradasVendidas()
        {
            InitializeComponent();
            tabla.DefaultCellStyle.WrapMode = DataGridViewTriState.True;
            if (conexion.AbrirConexion("isaac", "isaac"))
            {
                DataTable tablaBD = conexion.procemiento("CT_entradas_vendidas");
                llenarTabla(tablaBD); 
            }
        }

        public void llenarTabla(DataTable tablaAux)
        {

            tabla.DataSource = tablaAux;

            Console.WriteLine("numero"+tabla.RowCount);
            
           
        }

        private void BTBuscar_Click(object sender, EventArgs e)
        {

             if (TBDesde.Left == 0)
            {
                TBDesde.Text="null";
            }
             if (TBHasta.Left == 0)
            {
                TBHasta.Text="null";
            }
            if (TBUbicacion.Left == 0)
            {
                TBUbicacion.Text = "null";

            }

            if (conexion.AbrirConexion("isaac", "isaac") && TBDesde.Left == 0 && TBUbicacion.Left == 0&& TBHasta.Left == 0)
            {
                DataTable tablaBD = conexion.procemiento("CT_entradas_vendidas");
                llenarTabla(tablaBD);
            }
            else
            {
                DataTable tablaBD = conexion.filtrar("FT_entradas_vendidas", TBUbicacion.Text+","+TBDesde.Text+","+TBHasta.Text);
                llenarTabla(tablaBD);

            }
           
        }

        private void TBDesde_KeyPress(object sender, KeyPressEventArgs e)
        {
            Generico.tbSoloNumero(e);
        }

        private void TBHasta_KeyPress(object sender, KeyPressEventArgs e)
        {
            Generico.tbSoloNumero(e);
        }




   }

     

     

    }
