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
    public partial class DatosTrabajador : Form
    {
        DataTable tablaAux = new DataTable();
  
        public DatosTrabajador()
        {
            InitializeComponent();

            Conexion conexion = new Conexion();
             
            if (conexion.AbrirConexion("isaac", "isaac"))
            {
                OracleDataReader tablaBD = conexion.EjecutarSelect("select IDTRABAJADOR id, primer_nombre(NOMBRECOMPLETO) PrimerNombre, segundo_nombre(NOMBRECOMPLETO) SegundoNombre, primer_apellido(NOMBRECOMPLETO) PrimerApellido, segundo_apellido(NOMBRECOMPLETO) SegundoApellido, consultar_telefonos(TELEFONO) telefonos,c.nombre cargo, edades(tc.FECHAINICIO)antigüedad, t.foto from trabajador t, cargo c, trabajador_cargo tc where tc.FKCARGO = c.IDCARGO AND t.IDTRABAJADOR = tc.FKTRABAJADOR AND tc.FECHAFIN is NULL");
                llenarTabla(tablaBD);
            }
        }

       
        public void llenarTabla(OracleDataReader tablaBD)
        {

            tablaAux.Columns.Add("Primer_Nombre");
            tablaAux.Columns.Add("Segundo_Nombre");
            tablaAux.Columns.Add("Primer_Apellido");
            tablaAux.Columns.Add("Segundo_Apellido");
            tablaAux.Columns.Add("Teléfono");
            tablaAux.Columns.Add("Cargo");
            tablaAux.Columns.Add("Antigüedad");
            tablaAux.Columns.Add("foto", typeof(Image));

            while (tablaBD.Read())
            {
                try
                {
                    byte[] auxByte = (byte[])tablaBD["foto"];
                    Image imagen = Generico.llenarImagen(auxByte,tablaBD["ID"] + tablaBD["PRIMERNOMBRE"].ToString());

                    tablaAux.Rows.Add(tablaBD["PRIMERNOMBRE"], tablaBD["SEGUNDONOMBRE"], tablaBD["PRIMERAPELLIDO"], tablaBD["SEGUNDOAPELLIDO"], tablaBD["TELEFONOS"], tablaBD["CARGO"], tablaBD["antigüedad"], imagen);
                }
                catch
                {
                    tablaAux.Rows.Add(tablaBD["PRIMERNOMBRE"], tablaBD["SEGUNDONOMBRE"], tablaBD["PRIMERAPELLIDO"], tablaBD["SEGUNDOAPELLIDO"], tablaBD["TELEFONOS"], tablaBD["CARGO"], tablaBD["antigüedad"]);
               
                }
            
            }

            tabla.DataSource = tablaAux;                          
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

            if (TBSegundoApelldio.TextLength!= 0)
            {
                lista.Add("Segundo_Apellido='" + TBSegundoApelldio.Text + "'");
            }


            Generico.filtrar(tabla, tablaAux, Generico.generarParametroFiltrado(lista));

            if (lista.Count() == 0) //reinicia la tabla a como estaba original antes de filtrar
            {
                tabla.DataSource = tablaAux;
            }

        }




   }

     
}
