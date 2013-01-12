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
    public partial class MusicoInvitado : Form
    {
        DataTable tablaAux = new DataTable();
        public MusicoInvitado()
        {
            InitializeComponent();
            Conexion conexion = new Conexion();

            if (conexion.AbrirConexion("isaac", "isaac"))
            {
                OracleDataReader tablaBD = conexion.EjecutarSelect("select m.pasaporte, l.nombre pais, l.idlugar, nombres(m.NOMBRECOMPLETO) nombres, apellidos(m.NOMBRECOMPLETO) apellidos, n.nombre nacionalidad, consultar_direccion(m.FKLUGAR, m.DETALLEDIRECCION)direccion, consultar_telefonos(m.telefono) telefonos, antiguedad(tc.FECHAINICIO) antiguedad, consultar_obras_m(idMusico) Posiconobra, estudios_musico(idMusico) estudios, musico_instrument(idMusico) instrumento, musico_orquest(idMusico) orquesta, consultar_obras_m(idMusico) obra, musico_instrumentP(idMusico) InstrumentoP from MUSICO m, NACIONALIDAD_MUSICO nm, NACIONALIDAD n, trabajador_cargo tc, lugar l WHERE nm.PKMUSICO = m.IDMUSICO AND nm.PKNACIONALIDAD = n.IDNACIONALIDAD AND tc.FKMUSICO = m.IDMUSICO AND n.fkpais = l.idlugar AND m.invitado = 1");
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
            tablaAux.Columns.Add("Instrumentos que ejecutan y tiempo de ejecución");
            tablaAux.Columns.Add("Instrumento principal y tiempo de ejecución");
            tablaAux.Columns.Add("Orquesta");
            tablaAux.Columns.Add("Obras");
            tablaAux.Columns.Add("Foto", typeof(Image));
            while (tablaBD.Read())
            {
                try
                {
                    //byte[] bandera = (byte[])tablaBD["bandera"];
                    //Image imagenBandera = Generico.llenarImagen(bandera, tablaBD["idlugar"] + tablaBD["pais"].ToString());

                    byte[] fotoBailarin = (byte[])tablaBD["FOTOBAILARIN"];
                    Image foto = Generico.llenarImagen(fotoBailarin, tablaBD["PASAPORTE"] + tablaBD["NOMBRES"].ToString());

                    tablaAux.Rows.Add(tablaBD["PASAPORTE"], tablaBD["NOMBRES"], tablaBD["APELLIDOS"], tablaBD["NACIONALIDAD"], null, tablaBD["DIRECCION"], tablaBD["TELEFONOS"], tablaBD["ESTUDIOS"], tablaBD["ANTIGUEDAD"], tablaBD["INSTRUMENTO"], tablaBD["INSTRUMENTOP"], tablaBD["ORQUESTA"], tablaBD["OBRA"], foto);

                }
                catch
                {
                    tablaAux.Rows.Add(tablaBD["PASAPORTE"], tablaBD["NOMBRES"], tablaBD["APELLIDOS"], tablaBD["NACIONALIDAD"], null, tablaBD["DIRECCION"], tablaBD["TELEFONOS"], tablaBD["ESTUDIOS"], tablaBD["ANTIGUEDAD"], tablaBD["INSTRUMENTO"], tablaBD["INSTRUMENTOP"], tablaBD["ORQUESTA"], tablaBD["OBRA"], null);


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
            if (TBOrquesta.TextLength != 0)
            {
                lista.Add("Orquesta like'%" + TBOrquesta.Text + "%'");
            }
            if (TBOrquesta.TextLength != 0)
            {
                lista.Add("Obras like'%" + TBObra.Text + "%'");
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

        private void MusicoInvitado_Load(object sender, EventArgs e)
        {

        }

        private void label3_Click(object sender, EventArgs e)
        {

        }

        private void TBNombres_TextChanged(object sender, EventArgs e)
        {

        }

        private void label4_Click(object sender, EventArgs e)
        {

        }

        private void TBApellidos_TextChanged(object sender, EventArgs e)
        {

        }

        private void tabla_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

      




   }

     

     

    }
