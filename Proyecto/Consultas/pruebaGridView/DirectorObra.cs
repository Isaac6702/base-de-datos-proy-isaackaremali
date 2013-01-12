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
    public partial class DirectorObra : Form
    {
        DataTable tablaAux = new DataTable();

        public DirectorObra()
        {
            InitializeComponent();

            Conexion conexion = new Conexion();
             
            if (conexion.AbrirConexion("isaac", "isaac"))
            {
                OracleDataReader tablaBD = conexion.EjecutarSelect("select l.nombre pais, l.idlugar, nombres(d.NOMBRECOMPLETO) nombres, apellidos(d.NOMBRECOMPLETO) apellidos, n.nombre nacionalidad, consultar_direccion(d.FKLUGAR, d.DETALLEDIRECCION)direccion, consultar_telefonos(d.telefono) telefonos, antiguedad(tc.FECHAINICIO) antiguedad, consultar_obras_d(idDirector) obra, estudios_director(iddirector) estudios from DIRECTOR d, NACIONALIDAD_DIRECTOR nd, NACIONALIDAD n, trabajador_cargo tc, lugar l WHERE nd.PKDIRECTOR = d.IDDIRECTOR AND nd.PKNACIONALIDAD = n.IDNACIONALIDAD AND tc.FKDIRECTOR = d.IDDIRECTOR AND n.fkpais = l.idlugar AND d.invitado = 0");
                llenarTabla(tablaBD);
            }
        }

       
        public void llenarTabla(OracleDataReader tablaBD)
        {

            tablaAux.Columns.Add("Identificador");
            tablaAux.Columns.Add("Nombres");
            tablaAux.Columns.Add("Apellidos");
            tablaAux.Columns.Add("Direccion");
            tablaAux.Columns.Add("Teléfono");
            tablaAux.Columns.Add("Antigüedad");
            tablaAux.Columns.Add("Obras dirigidas");
            tablaAux.Columns.Add("foto", typeof(Image));

            while (tablaBD.Read())
            {
                try
                {
                    byte[] auxByte = (byte[])tablaBD["foto"];
                    Image imagen = Generico.llenarImagen(auxByte, tablaBD["ID"] + tablaBD["NOMBRES"].ToString());

                    tablaAux.Rows.Add(tablaBD["PASAPORTE"], tablaBD["NOMBRES"], tablaBD["APELLIDOS"], tablaBD["DIRECCION"], tablaBD["TELEFONOS"], tablaBD["antiguedad"], tablaBD["obras"], imagen);
                }
                catch
                {
                    tablaAux.Rows.Add(tablaBD["PASAPORTE"], tablaBD["NOMBRES"], tablaBD["APELLIDOS"], tablaBD["DIRECCION"], tablaBD["TELEFONOS"], tablaBD["antiguedad"], tablaBD["obras"], null);
               
                }
            
            }

            tabla.DataSource = tablaAux;                          
        }

        private void BTBuscar_Click(object sender, EventArgs e)
        {
            List<string> lista = new List<string>();
            


            if (TBNombres.TextLength != 0)
            {
                lista.Add("Nombres like '%" + TBNombres.Text + "%'");
            }

            if (TBApellidos.TextLength!= 0)
            {
                lista.Add("Apellidos like '%" + TBApellidos.Text + "%'");
            }
            if (TBIdentificador.TextLength != 0)
            {
                lista.Add("identificador like '%" + TBIdentificador.Text + "%'");
            }



            Generico.filtrar(tabla, tablaAux, Generico.generarParametroFiltrado(lista));

            if (lista.Count() == 0) //reinicia la tabla a como estaba original antes de filtrar
            {
                tabla.DataSource = tablaAux;
            }

        }

        private void TBIdentificador_KeyPress(object sender, KeyPressEventArgs e)
        {
            Generico.tbSoloNumero(e);
        }




   }

     
}
