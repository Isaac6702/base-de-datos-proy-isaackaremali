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
                OracleDataReader monedas = conexion.EjecutarSelect("select m.idMoneda id, lower(m.nombre) nombre from moneda m order by nombre");

                if (monedas != null)
                {
                    while (monedas.Read())
                    {
                        comboMoneda.Items.Add(monedas["nombre"]);
                    }
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
                OracleDataReader tablaDB = conexion.EjecutarSelect("select lower(o.nombre) nombre, to_char(fp.fecha, 'dd/mm/yyyy hh:mi:ssam') presentacion, u.nombre ubicacion, (u.porcentaje*fp.zonamascara) precio from obra o, fecha_presentacion fp, ubicacion u where fp.fkObra = o.idObra and u.tipo = 'zona' order by o.nombre, fp.fecha");
                if (tablaDB != null)
                {
                    while (tablaDB.Read())
                    {
                        tablaAux.Rows.Add(tablaDB["nombre"], tablaDB["presentacion"], tablaDB["ubicacion"], tablaDB["precio"]);
                    }
                    tabla.DataSource = tablaAux;
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
