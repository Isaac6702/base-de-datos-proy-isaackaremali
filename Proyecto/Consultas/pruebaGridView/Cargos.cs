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
    public partial class Cargos : Form
    {
        DataTable tablaAux = new DataTable();
        Conexion conexion = new Conexion();
        public Cargos()
        {
            InitializeComponent();
            

            if (conexion.AbrirConexion("isaac", "isaac"))
            {
                DataTable tablaBD = conexion.procemiento("CT_Cargo");
                llenarTabla(tablaBD);
            }
        }

        public void llenarTabla(DataTable tablaBD)
        {

            tabla.DataSource = tablaBD;          
  
        }

        private void BTBuscar_Click(object sender, EventArgs e)
        {
            List<string> lista = new List<string>();


            if (TBTipoAscenso.TextLength != 0)
            {
                lista.Add(TBTipoAscenso.Text);
            }
            else
                lista.Add("null");

            if (TBCargo.TextLength != 0)
            {
                lista.Add(TBCargo.Text);
            }
            else
                lista.Add("null");

            if (conexion.AbrirConexion("isaac", "isaac") && TBCargo.TextLength == 0 && TBTipoAscenso.TextLength == 0)
            {
                DataTable tablaBD = conexion.procemiento("CT_Cargo");
                llenarTabla(tablaBD);
            }
            else
            {
                DataTable tablaBD = conexion.filtrar("FT_Cargo", Generico.generarParametroFiltrado(lista));
                llenarTabla(tablaBD);

            }   


           
          
        }


    }

}
