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
        public Cargos()
        {
            InitializeComponent();
            Conexion conexion = new Conexion();

            if (conexion.AbrirConexion("isaac", "isaac"))
            {
                OracleDataReader tablaBD = conexion.EjecutarSelect("select c.NOMBRE cargo, d.NOMBRE departamento, d.TIEMPOASCENSO tiempo, c.TIPOASCENSO tipoAscenso from cargo c, departamento d where c.FKDEPARTAMENTO = d.IDDEPARTAMENTO");
                llenarTabla(tablaBD);
            }
        }

        public void llenarTabla(OracleDataReader tablaBD)
        {
            tablaAux.Columns.Add("Cargo");
            tablaAux.Columns.Add("Departamento");
            tablaAux.Columns.Add("Tiempo");
            tablaAux.Columns.Add("Tipo_de_ascenso");


            while (tablaBD.Read())
            {

                tablaAux.Rows.Add(tablaBD["CARGO"], tablaBD["DEPARTAMENTO"], tablaBD["TIEMPO"], tablaBD["TIPOASCENSO"]);
                           
            }

            tabla.DataSource = tablaAux;          

           
        }

        private void BTBuscar_Click(object sender, EventArgs e)
        {
            List<string> lista = new List<string>();


            if (TBTipoAscenso.TextLength != 0)
            {
                lista.Add("Tipo_de_ascenso='" + TBTipoAscenso.Text + "'");
            }

            if (TBCargo.TextLength != 0)
            {
                lista.Add("Cargo like '%" + TBCargo.Text + "%'");
            }

           
            Generico.filtrar(tabla, tablaAux, Generico.generarParametroFiltrado(lista));

            if (lista.Count() == 0) //reinicia la tabla a como estaba original antes de filtrar
            {
                tabla.DataSource = tablaAux;
            }

        }


    }

}
