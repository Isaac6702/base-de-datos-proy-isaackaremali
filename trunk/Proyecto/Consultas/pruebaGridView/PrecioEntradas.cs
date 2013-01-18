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
    public partial class PrecioEntradas : Form
    {
        DataTable tablaAux = new DataTable();
        string usuario = "isaac";
        string password = "isaac";
        public PrecioEntradas()
        {
            InitializeComponent();
            tablaAux.Columns.Add("nombre");
            tablaAux.Columns.Add("presentacion");
            tablaAux.Columns.Add("ubicacion");
            tablaAux.Columns.Add("precio");
            llenarComboMonedas();
            llenarComboObras();
            llenarTabla();

        }
        // llena el combo con todas las monedas
        public void llenarComboMonedas()
        {
            comboMoneda.Items.Add("libra");
            comboMoneda.SelectedIndex = 0;
            Conexion conexion = new Conexion();
            if (conexion.AbrirConexion(usuario, password))
            {
                DataTable monedas = conexion.procemiento("monedas");
               
                foreach (DataRow x in monedas.Rows)
                {
                    comboMoneda.Items.Add(x[0].ToString());
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
                OracleDataReader obras = conexion.EjecutarSelect("select lower(o.nombre) nombre from obra o order by o.nombre");
                if (obras != null)
                {
                    while (obras.Read())
                    {
                        comboObra.Items.Add(obras["nombre"]);
                    }
                }
            }

        }

        // llena tabla completa sin filtros
        public void llenarTabla()
        {
            Conexion conexion = new Conexion();
            if (conexion.AbrirConexion(usuario, password))
            {
                DataTable tablaDB = conexion.procemiento("precio_entradas");
                if (tablaDB != null)
                {
                    tabla.DataSource = tablaDB;
                }
            }
        
        }
       
        // cuando cambio de fecha
        private void timeInicio_ValueChanged(object sender, EventArgs e)
        {
            String fecha = timeInicio.Text;
            if (timeInicio.ShowCheckBox == true)
                    System.Console.WriteLine(fecha);
        }

        


   }

     

     

    }
