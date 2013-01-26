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
    public partial class Libreto : Form
    {
        public Libreto()
        {
            InitializeComponent();
            Conexion conexion = new Conexion();
            DTFecha.CustomFormat = "dd/MM/yyyy";

            if (conexion.AbrirConexion("isaac", "isaac"))
            {
                DataTable tablaBD = conexion.procemiento("CT_Reporte_Libreto");
                llenarTabla(tablaBD);
            }
        }

        public void llenarTabla(DataTable tablaAux)
        {

            tabla.DataSource = tablaAux;
           
        }

        private void BTBuscar_Click(object sender, EventArgs e)
        {
            Conexion conexion = new Conexion();
            List<string> lista = new List<string>();


            if (TBIdioma.TextLength != 0)
            {
                lista.Add(TBIdioma.Text);
            }
            else
                lista.Add("null");

            if (TBObra.TextLength != 0)
            {
                lista.Add(TBObra.Text);
            }
            else
                lista.Add("null");

            if (DTFecha.Checked)
            {
                lista.Add(DTFecha.Text);

            }
            else
                lista.Add("null");


            if (conexion.AbrirConexion("isaac", "isaac"))
            {

                DataTable tablaBD = conexion.filtrar("FT_libreto", Generico.generarParametroFiltrado(lista));
                llenarTabla(tablaBD);
            }
        }

        private void tabla_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            Conexion conexion = new Conexion();
            
            if (conexion.AbrirConexion("isaac", "isaac"))
            {
               
                DataTable tablaPDF = conexion.filtrar("CT_Libreto", tabla.Rows[e.RowIndex].Cells[0].Value.ToString());
                if (tablaPDF != null)
                {
                    byte[] bytes = (byte[])tablaPDF.Rows[0][0];

                    try
                    {
                        System.Diagnostics.Process.Start(Generico.llenarPDF(bytes, "pdf" + tabla.Rows[e.RowIndex].Cells[0].Value.ToString()));
                    }
                    catch
                    {
                    }

                }
            }
        }




   }

     

     

    }
