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
    public partial class Coreografo : Form
    {
        DataTable tablaAux = new DataTable();
        Conexion conexion = new Conexion();

        public Coreografo()
        {
            InitializeComponent();

        
             
            if (conexion.AbrirConexion("isaac", "isaac"))
            {
                DataTable tablaBD = conexion.procemiento("CT_Coreografo");
                tablaAux.Columns.Add("Identificador");
                tablaAux.Columns.Add("Nombres");
                tablaAux.Columns.Add("Apellidos");
                tablaAux.Columns.Add("Direccion");
                tablaAux.Columns.Add("Teléfono");
                tablaAux.Columns.Add("Antigüedad");
                tablaAux.Columns.Add("Nacionalidad");
                tablaAux.Columns.Add("foto", typeof(Image));
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
                    byte[] auxByte = (byte[])aux[9];
                    Image imagen = Generico.llenarImagen(auxByte, aux[2].ToString() + aux[3].ToString());

                    tablaAux.Rows.Add(aux[2].ToString(), aux[3].ToString(), aux[4].ToString(), aux[0].ToString(), aux[5].ToString(), aux[7].ToString(), aux[8].ToString(), imagen);
                }
                catch
                {
                    tablaAux.Rows.Add(aux[2].ToString(), aux[3].ToString(), aux[4].ToString(), aux[0].ToString(), aux[5].ToString(), aux[7].ToString(), aux[8].ToString(), null);
               
                }
            
            }

            tabla.DataSource = tablaAux;                          
        }

        private void BTBuscar_Click(object sender, EventArgs e)
        {
            List<string> lista = new List<string>();
            

            if (TBNombes.TextLength != 0)
            {
                lista.Add(TBNombes.Text);
            }
            else
                lista.Add("null");

            if (TBApellidos.TextLength!= 0)
            {
                lista.Add(TBApellidos.Text);
            }
            else
                lista.Add("null");

            if (TBIdentificador.TextLength != 0)
            {
                lista.Add(TBIdentificador.Text);
            }
            else
                lista.Add("null");

            if (TBNacionalidad.TextLength!= 0)
            {
                lista.Add(TBNacionalidad.Text);
            }
            else
                lista.Add("null");


            if (conexion.AbrirConexion("isaac", "isaac") && TBNombes.TextLength==0 && TBNacionalidad.TextLength == 0 && TBIdentificador.TextLength == 0 &&  TBApellidos.TextLength == 0 )
            {
                DataTable tablaBD = conexion.procemiento("CT_Coreografo");
                llenarTabla(tablaBD);
            }
            else
            {
                DataTable tablaBD = conexion.filtrar("FT_Coreografo", Generico.generarParametroFiltrado(lista));
                llenarTabla(tablaBD);

            }   

        }

        private void TBIdentificador_KeyPress(object sender, KeyPressEventArgs e)
        {
            Generico.tbSoloNumero(e);
        }

        private void TBApellidos_TextChanged(object sender, EventArgs e)
        {

        }

        private void Coreografo_Load(object sender, EventArgs e)
        {

        }




   }

     
}
