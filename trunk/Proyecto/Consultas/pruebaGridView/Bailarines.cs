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
    public partial class Bailarines : Form
    {
        DataTable tablaAux = new DataTable();
        public Bailarines()
        {
            InitializeComponent();
        }

        public void llenarTabla(OracleDataReader tablaBD)
        {

            tablaAux.Columns.Add("Primer_Nombre");
            tablaAux.Columns.Add("Segundo_Nombre");
            tablaAux.Columns.Add("Primer_Apellido");
            tablaAux.Columns.Add("Segundo_Apellido");
            tablaAux.Columns.Add("Bandera", typeof(Image));
            tablaAux.Columns.Add("Direccíon");
            tablaAux.Columns.Add("Teléfono");
            tablaAux.Columns.Add("Estudios");
            tablaAux.Columns.Add("Cargo");
            tablaAux.Columns.Add("Antigüedad");
            tablaAux.Columns.Add("Ballet anteriores");
            tablaAux.Columns.Add("Foto", typeof(Image));


            
           
        }

        private void BTBuscar_Click(object sender, EventArgs e)
        {
            List<string> lista = new List<string>();


            if (TBPrimerNombre.TextLength != 0)
            {
                lista.Add("Primer_Nombre='" + TBPrimerNombre.Text + "'");
            }

            if (TBSegundoNombre.TextLength != 0)
            {
                lista.Add("Segundo_Nombre='" + TBSegundoNombre.Text + "'");
            }

            if (TBPrimerApellido.TextLength != 0)
            {
                lista.Add("Primer_Apellido='" + TBPrimerApellido.Text + "'");
            }

            if (TBSegundoApellido.TextLength != 0)
            {
                lista.Add("Segundo_Apellido='" + TBSegundoApellido.Text + "'");
            }

            if (TBAntiguedad.TextLength != 0)
            {
                lista.Add("Antigüedad='" + TBAntiguedad.Text + "'");
            }
            if (TBIdentificador.TextLength != 0)
            {
                lista.Add("Identificador='" + TBIdentificador.Text + "'");
            }
            if (TBNacionalidad.TextLength != 0)
            {
                lista.Add("Nacionalidad='" + TBNacionalidad.Text + "'");
            }


            Generico.filtrar(tabla, tablaAux, Generico.generarParametroFiltrado(lista));

            if (lista.Count() == 0) //reinicia la tabla a como estaba original antes de filtrar
            {
                tabla.DataSource = tablaAux;
            }

        }

      




   }

     

     

    }
