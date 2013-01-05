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
    public partial class EntradasVendidas : Form
    {
        DataTable tablaAux = new DataTable();
        public EntradasVendidas()
        {
            InitializeComponent();
            Conexion conexion = new Conexion();

            if (conexion.AbrirConexion("isaac", "isaac"))
            {
                OracleDataReader tablaBD = conexion.EjecutarSelect("select  entradas_restantes(COUNT(a.idubicacion), Z.IDUBICACION, o.idobra) restantes, (COUNT(a.idubicacion) - entradas_restantes(COUNT(a.idubicacion), Z.IDUBICACION, o.idobra)) total, z.nombre Ubicacion , o.nombre opera from ubicacion z, ubicacion a, ubicacion p, obra o where z.fkubicacion = p.idubicacion AND a.fkubicacion = z.idubicacion GROUP BY z.idubicacion, z.nombre, o.nombre, o.idobra");
                llenarTabla(tablaBD);
            }
        }

        public void llenarTabla(OracleDataReader tablaBD)
        {
            tablaAux.Columns.Add("Opera");
            tablaAux.Columns.Add("Ubicacion");
            tablaAux.Columns.Add("Total");
            tablaAux.Columns.Add("Restantes");

            while (tablaBD.Read())
            {


                tablaAux.Rows.Add(tablaBD["OPERA"], tablaBD["UBICACION"], tablaBD["TOTAL"], tablaBD["restantes"]);
            }
            tabla.DataSource = tablaAux; 
            
           
        }

        private void BTBuscar_Click(object sender, EventArgs e)
        {
            List<string> lista = new List<string>();


            if (TBUbicacion.TextLength != 0)
            {
                lista.Add("Ubicacion like '%" + TBUbicacion.Text + "%'");
            }
            if (TBDesde.TextLength != 0)
            {
                lista.Add("Total>=  '" + TBDesde.Text + "'");
            }

            if (TBHasta.TextLength != 0)
            {
                lista.Add("Total<= '" + TBHasta.Text + "'");
            }
            Generico.filtrar(tabla, tablaAux, Generico.generarParametroFiltrado(lista));
          //  Generico.filtrar(tabla, tablaAux, );
            if (lista.Count() == 0) //reinicia la tabla a como estaba original antes de filtrar
            {
                tabla.DataSource = tablaAux;
            }
        }

        private void TBDesde_KeyPress(object sender, KeyPressEventArgs e)
        {
            Generico.tbSoloNumero(e);
        }

        private void TBHasta_KeyPress(object sender, KeyPressEventArgs e)
        {
            Generico.tbSoloNumero(e);
        }




   }

     

     

    }
