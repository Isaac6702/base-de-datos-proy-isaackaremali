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
        Conexion conexion = new Conexion();
        public MusicoInvitado()
        {
            InitializeComponent();

            tabla.DefaultCellStyle.WrapMode = DataGridViewTriState.True;
            if (conexion.AbrirConexion("isaac", "isaac"))
            {
                DataTable tablaBD = conexion.procemiento("CT_Musico_invitado");
                tablaAux.Columns.Add("Identificardor");
                tablaAux.Columns.Add("Nombres");
                tablaAux.Columns.Add("Apellidos");
                tablaAux.Columns.Add("Nacionalidad");
                tablaAux.Columns.Add("Direccíon");
                tablaAux.Columns.Add("Teléfono");
                tablaAux.Columns.Add("Estudios");
                tablaAux.Columns.Add("Antigüedad");
                tablaAux.Columns.Add("Instrumentos que ejecutan y tiempo de ejecución");
                tablaAux.Columns.Add("Instrumento principal y tiempo de ejecución");
                tablaAux.Columns.Add("Orquesta");
                tablaAux.Columns.Add("Obras");
                tablaAux.Columns.Add("Foto", typeof(Image));
                llenarTabla(tablaBD);
            }
        }

        public void llenarTabla(DataTable tablaBD)
        {
            tablaAux.Clear();
            foreach (DataRow aux in tablaBD.Rows)
            {

                try
                {
                    byte[] fotoMusico = (byte[])aux[15];
                    Image foto = Generico.llenarImagen(fotoMusico, aux[0].ToString()+ aux[3].ToString());

                    tablaAux.Rows.Add(aux[0].ToString(), aux[3].ToString(), aux[4].ToString(), aux[5].ToString(),  aux[6].ToString(), aux[7].ToString(), aux[10].ToString(), aux[8].ToString(), aux[11].ToString(), aux[14].ToString(), aux[12].ToString(), aux[13].ToString(), foto);

                }
                catch
                {
                    tablaAux.Rows.Add(aux[0].ToString(), aux[3].ToString(), aux[4].ToString(), aux[5].ToString(), aux[6].ToString(), aux[7].ToString(), aux[10].ToString(), aux[8].ToString(), aux[11].ToString(), aux[14].ToString(), aux[12].ToString(), aux[13].ToString(), null);
                }

            }


            tabla.DataSource = tablaAux;
        }

        private void BTBuscar_Click(object sender, EventArgs e)
        {
            List<string> lista = new List<string>();


            if (TBNombres.TextLength != 0)
            {
                lista.Add(TBNombres.Text);
            }
            else
                lista.Add("null");

            if (TBApellidos.TextLength != 0)
            {
                lista.Add(TBApellidos.Text);
            }
            else
                lista.Add("null");

            if (TBAntiguedad.TextLength != 0)
            {
                lista.Add(TBAntiguedad.Text);
            }
            else
                lista.Add("null");

            if (TBIdentificador.TextLength != 0)
            {
                lista.Add(TBIdentificador.Text);
            }
            else
                lista.Add("null");

            if (TBNacionalidad.TextLength != 0)
            {
                lista.Add(TBNacionalidad.Text);
            }
            else
                lista.Add("null");

            if (TBOrquesta.TextLength != 0)
            {
                lista.Add(TBOrquesta.Text);
            }
            else
                lista.Add("null");

            if (TBObra.TextLength != 0)
            {
                lista.Add(TBObra.Text);
            }
            else
                lista.Add("null");

            if (conexion.AbrirConexion("isaac", "isaac") && TBOrquesta.TextLength == 0 && TBObra.TextLength == 0 && TBNacionalidad.TextLength == 0 && TBIdentificador.TextLength == 0 && TBNombres.TextLength == 0 && TBApellidos.TextLength == 0 && TBAntiguedad.TextLength == 0)
            {
                DataTable tablaBD = conexion.procemiento("CT_Musico_invitado");
                llenarTabla(tablaBD);
            }
            else
            {
                DataTable tablaBD = conexion.filtrar("FT_Musico_invitado", Generico.generarParametroFiltrado(lista));
                llenarTabla(tablaBD);

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
