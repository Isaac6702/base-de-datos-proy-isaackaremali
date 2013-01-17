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
             //   OracleDataReader tablaDB = conexion.EjecutarSelect("select lower(o.nombre) obra, ((2258 * a.nroPresentaciones) - count(fp.idfp)) programas from entrada e, obra o, fecha_presentacion fp, ( select o.idobra id, count(idFP) nroPresentaciones from fecha_presentacion fp, obra o where  fp.fkObra = o.idObra group by o.idobra) a where fp.fkObra = o.idObra and e.pagada = 0 and fp.idfp = e.fkpresentacion and a.id = o.idObra group by o.nombre, a.nroPresentaciones");
           
                                        
              
    
             /*   if (tablaDB != null)
                {
                    while (tablaDB.Read())
                    {
                        tablaAux.Rows.Add(tablaDB["obra"], tablaDB["programas"]);
                    }

                    tabla.DataSource = tablaAux;
                }*/
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


   }

     

     

    }
