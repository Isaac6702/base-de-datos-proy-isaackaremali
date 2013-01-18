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
    public partial class NroProgramas : Form
    {
        DataTable tablaAux = new DataTable();
        string usuario = "isaac";
        string password = "isaac";

        public NroProgramas()
        {
            InitializeComponent();
            llenarComboObras();
            tablaAux.Columns.Add("obra");
            tablaAux.Columns.Add("programas");
            llenarTabla();
        }

        public void llenarTabla()
        {

            Conexion conexion = new Conexion();
            if (conexion.AbrirConexion(usuario, password))
            {
                DataTable tablaDB = conexion.procemiento("numero_programas");
                if (tablaDB != null)
                {
                    tabla.DataSource = tablaDB;
                }
            }
        }

        // llena el combo con todas las obras
        public void llenarComboObras()
        {
            comboObra.Items.Add("todas");
            comboObra.SelectedIndex = 0;
            Conexion conexion = new Conexion();
            if (conexion.AbrirConexion(usuario, password))
            {
                DataTable obras = conexion.procemiento("obras");
               
                foreach (DataRow x in obras.Rows)
                {
                    comboObra.Items.Add(x[0].ToString());
                }
                
            }

        }

       private void comboObra_SelectedIndexChanged(object sender, EventArgs e)
        {
     /*       if (comboObra.SelectedIndex > 0)
            {
                string nombreObra = comboObra.SelectedItem.ToString();
                System.Console.WriteLine(nombreObra);
                Conexion conexion = new Conexion();
                if (conexion.AbrirConexion(usuario, password))
                {
                   
                    if (tablaDB != null)
                        tabla.DataSource = tablaDB;

                }
            }
        */}


   }

     

     

    }
