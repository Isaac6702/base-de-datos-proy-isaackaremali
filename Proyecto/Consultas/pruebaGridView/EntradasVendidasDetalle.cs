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
    public partial class EntradasVendidasDetalle : Form
    {
        DataTable tablaAux = new DataTable();
        Conexion conexion = new Conexion();
        public EntradasVendidasDetalle()
        {
            InitializeComponent();
            DTFechaVentas.CustomFormat = "dd/MM/yyyy";
            DTFechaPresentacion.CustomFormat = "dd/MM/yyyy";
            tabla.DefaultCellStyle.WrapMode = DataGridViewTriState.True;
            if (conexion.AbrirConexion("isaac", "isaac"))
            {
                DataTable tablaBD = conexion.procemiento("CT_entradas_vendidas_momento");
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
            string fecha1, fecha2, aux;

            if (!DTFechaVentas.Checked)
            {
                fecha2 = "null";
            }
            else
                fecha2 = DTFechaVentas.Text;

             if (!DTFechaPresentacion.Checked)
             {
                 fecha1 = "null";
             }
             else
                 fecha1 = DTFechaPresentacion.Text;

             if (TBObra.Text == "")
             {
                 aux = "null";

             }
             else
                 aux = TBObra.Text.Trim();

            if (conexion.AbrirConexion("isaac", "isaac") && !DTFechaVentas.Checked && aux == "null" && !DTFechaPresentacion.Checked)
            {
                DataTable tablaBD = conexion.procemiento("CT_entradas_vendidas_momento");
                llenarTabla(tablaBD);
            }
            else
            {
                DataTable tablaBD = conexion.filtrar(" FT_entradas_vendidas_momento", aux + "," + fecha1 + "," + fecha2);
                llenarTabla(tablaBD);

            }
           
        }

        private void TBDesde_KeyPress(object sender, KeyPressEventArgs e)
        {
            
        }

        private void TBHasta_KeyPress(object sender, KeyPressEventArgs e)
        {
        
        }

        private void dateTimePicker1_ValueChanged(object sender, EventArgs e)
        {

        }




   }

     

     

    }
