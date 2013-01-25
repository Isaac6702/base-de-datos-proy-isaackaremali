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
    public partial class Obra1 : Form
    {
        public Obra1()
        {
            InitializeComponent();
            Conexion conexion = new Conexion();
            tabla.DefaultCellStyle.WrapMode = DataGridViewTriState.True;
            if (conexion.AbrirConexion("isaac", "isaac"))
            {
                DataTable tablaBD = conexion.procemiento("CT_Obra");
                llenarTabla(tablaBD);
            }
        }

        public void llenarTabla(DataTable tablaAux)
        {

            tabla.DataSource = tablaAux;
           
        }

        private void BTBuscar_Click(object sender, EventArgs e)
        {
            string prueba = null;
            Console.WriteLine(prueba);
        }

        private void tabla_CellMouseClick(object sender, DataGridViewCellMouseEventArgs e)
        {
            System.Console.WriteLine(tabla.Rows[e.RowIndex].Cells[0].Value);
            DetalleObra detalle = new DetalleObra(tabla.Rows[e.RowIndex].Cells[0].Value.ToString());
            detalle.Show();
        }




   }

     

     

    }
