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
    public partial class VentaEntradas : Form
    {
        DataTable tablaAux = new DataTable();
        public VentaEntradas()
        {
            InitializeComponent();
        }

        public void llenarTabla(OracleDataReader tablaBD)
        {

            
           
        }

        private void nombreReporte_Click(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            openFileDialog1.ShowDialog();
            
           
            

        }

        private void openFileDialog1_FileOk(object sender, CancelEventArgs e)
        {
            tbRutaArchivo.Text = openFileDialog1.FileName;
        }




   }

     

     

    }
