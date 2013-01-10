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
    public partial class Cantante1 : Form
    {
        DataTable tablaAux = new DataTable();
        public Cantante1()
        {
            InitializeComponent();
            Conexion conexion = new Conexion();

            if (conexion.AbrirConexion("", ""))
            {
                OracleDataReader tablaBD = conexion.EjecutarSelect("select l.nombre pais, l.idlugar, nombres(c.NOMBRECOMPLETO) nombres, apellidos(c.NOMBRECOMPLETO) apellidos, n.nombre nacionalidad, consultar_direccion(c.FKLUGAR, c.DETALLEDIRECCION)direccion, consultar_telefonos(c.telefono) telefonos, antiguedad(tc.FECHAINICIO) antiguedad from CANTANTE c, NACIONALIDAD_CANTANTE nc, NACIONALIDAD n, trabajador_cargo tc, lugar l WHERE nc.PKCANTANTE = c.IDCANTANTE AND nc.PKNACIONALIDAD = n.IDNACIONALIDAD AND tc.FKCANTANTE = c.IDCANTANTE AND n.fkpais = l.idlugar AND c.invitado = 0");
                llenarTabla(tablaBD);
            }
        }

        public void llenarTabla(OracleDataReader tablaBD)
        {
            tablaAux.Columns.Add("Identificardor");
            tablaAux.Columns.Add("Nombres");
            tablaAux.Columns.Add("Apellidos");
            tablaAux.Columns.Add("Nacionalidad");
            tablaAux.Columns.Add("Bandera", typeof(Image));
            tablaAux.Columns.Add("Direccíon");
            tablaAux.Columns.Add("Teléfono");
            tablaAux.Columns.Add("Estudios");
            tablaAux.Columns.Add("Antigüedad");
            tablaAux.Columns.Add("Ballet anteriores");
            tablaAux.Columns.Add("Foto", typeof(Image));
            while (tablaBD.Read())
            {
                try
                {
                    //byte[] bandera = (byte[])tablaBD["bandera"];
                    //Image imagenBandera = Generico.llenarImagen(bandera, tablaBD["idlugar"] + tablaBD["pais"].ToString());

                    byte[] fotoBailarin = (byte[])tablaBD["FOTOBAILARIN"];
                    Image foto = Generico.llenarImagen(fotoBailarin, tablaBD["PASAPORTE"] + tablaBD["NOMBRES"].ToString());
                    
                    tablaAux.Rows.Add(tablaBD["PASAPORTE"], tablaBD["NOMBRES"], tablaBD["APELLIDOS"], tablaBD["NACIONALIDAD"], null, tablaBD["DIRECCION"], tablaBD["TELEFONOS"], tablaBD["ESTUDIOS"], tablaBD["ANTIGUEDAD"], tablaBD["balletAnteriores"], foto);

                }
                catch
                {
                    tablaAux.Rows.Add(tablaBD["PASAPORTE"], tablaBD["NOMBRES"], tablaBD["APELLIDOS"], tablaBD["NACIONALIDAD"], null, tablaBD["DIRECCION"], tablaBD["TELEFONOS"], tablaBD["ESTUDIOS"], tablaBD["ANTIGUEDAD"], tablaBD["balletAnteriores"], null);


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

            if (TBApellidos.TextLength != 0)
            {
                lista.Add("Apellidos like '%" + TBApellidos.Text + "%'");
            }

            if (TBAntiguedad.TextLength != 0)
            {
                lista.Add("Antigüedad like '%" + TBAntiguedad.Text + "%'");
            }
            if (TBIdentificador.TextLength != 0)
            {
                lista.Add("Identificardor='" + TBIdentificador.Text + "'");
            }
            if (TBNacionalidad.TextLength != 0)
            {
                lista.Add("Nacionalidad like'%" + TBNacionalidad.Text + "%'");
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
