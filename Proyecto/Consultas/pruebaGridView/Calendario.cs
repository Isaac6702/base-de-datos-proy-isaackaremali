using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.OracleClient;
using pruebaViewGrid;
using System.Drawing.Drawing2D;
using System.IO;

namespace pruebaGridView
{
    public partial class Calendario : Form
    {
        DataTable tablaAux = new DataTable();
        OracleDataReader tablaBD;

        public Calendario()
        {
            InitializeComponent();
            tablaAux.Columns.Add("obra");
            tablaAux.Columns.Add("actores");
            tablaAux.Columns.Add("fecha");

            Conexion conexion = new Conexion();
            if (conexion.AbrirConexion("karem", "karem"))
            {
                OracleDataReader tablaFechas = conexion.EjecutarSelect("select to_char(fp.fecha, 'dd/mm/yyyy') as fecha from fecha_presentacion fp order by fp.fecha");
                splitFecha(tablaFechas);
            }

            consultarObrasDelDia();
        }

        private void splitFecha(OracleDataReader tablaFechas)
        {
            char[] delimiterChars = { '/', '-' };
            DateTime[] dateTimes = new System.DateTime[10000];

            int i = 0;
            while (tablaFechas.Read())
            {
                String[] dia_mes_ano = tablaFechas["fecha"].ToString().Split(delimiterChars);
                int dia = int.Parse(dia_mes_ano[0]);
                int mes = int.Parse(dia_mes_ano[1]);
                int ano = int.Parse(dia_mes_ano[2]);

                dateTimes[i] = new System.DateTime(ano, mes, dia);
                i = i + 1;


            }
            this.calendario1.BoldedDates = dateTimes;

        }
        private void consultarObrasDelDia()
        {
            Conexion conexion = new Conexion();
            if (conexion.AbrirConexion("karem", "karem"))
            {
                tablaBD = conexion.EjecutarSelect("select fp.fecha as fecha, o.nombre as obra from fecha_presentacion fp, obra o where to_date(fp.fecha, 'dd/mm/yyyy') = to_date(sysdate, 'dd/mm/yyyy') and fp.fkObra = o.idObra order by fp.fecha");

                llenarTabla(tablaBD);
            }
        }

        private void llenarTabla(OracleDataReader tablaBD)
        {
            if (tablaBD != null)
            {
                tablaAux.Clear();
                while (tablaBD.Read())
                {
                    tablaAux.Rows.Add(tablaBD["obra"], tablaBD["fecha"]);
                }

                tabla.DataSource = tablaAux;

            }
        }

        //para obtener la tabla con la fecha seleccionada
        private void calendario_DateSelected(object sender, DateRangeEventArgs e)
        {
            String fechaCalendario = calendario1.SelectionRange.Start.ToShortDateString();
            System.Console.WriteLine(fechaCalendario);
            Conexion conexion = new Conexion();

            if (conexion.AbrirConexion("karem", "karem"))
            {
                tablaBD = conexion.EjecutarSelect("select fp.fecha as fecha, o.nombre as obra from fecha_presentacion fp, obra o where fp.fecha = to_date('" + fechaCalendario + "', 'mm/dd/yyyy') and fp.fkObra = o.idObra order by fp.fecha");
                llenarTabla(tablaBD);
            }
        }

        private void nombreReporte_Click(object sender, EventArgs e)
        {

        }

    }
}
