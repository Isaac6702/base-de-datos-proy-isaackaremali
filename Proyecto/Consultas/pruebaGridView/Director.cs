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
    public partial class Director : Form
    {
        DataTable tablaAux = new DataTable();

        public Director()
        {
            InitializeComponent();

            Conexion conexion = new Conexion();
             
            if (conexion.AbrirConexion("ALI", "100191"))
            {
                OracleDataReader tablaBD = conexion.EjecutarSelect("select consultar_direccion(d.fklugar, d.detalleDireccion) direccion, IDDIRECTOR id, d.pasaporte pasaporte ,primer_nombre(NOMBRECOMPLETO) PrimerNombre, segundo_nombre(NOMBRECOMPLETO) SegundoNombre, primer_apellido(NOMBRECOMPLETO) PrimerApellido, segundo_apellido(NOMBRECOMPLETO) SegundoApellido, consultar_telefonos(TELEFONO) telefonos, c.nombre cargo, Antiguedad(tc.FECHAINICIO) antiguedad, estudios_director(idDirector) estudios,  d.foto foto, o.nombre obra from DIRECTOR d, cargo c, trabajador_cargo tc, obra o where tc.FKCARGO = c.IDCARGO AND e.IDDIRECTOR = tc.FKDIRECTOR AND tc.FECHAFIN is NULL AND invitado = 0 AND o.FKOBRA = o.IDOBRA");  
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
            tablaAux.Columns.Add("Estudios");
            tablaAux.Columns.Add("Obra");
            tablaAux.Columns.Add("foto", typeof(Image));

            while (tablaBD.Read())
            {
                try
                {
                    byte[] auxByte = (byte[])tablaBD["foto"];
                    Image imagen = Generico.llenarImagen(auxByte, tablaBD["ID"] + tablaBD["NOMBRES"].ToString());

                    tablaAux.Rows.Add(tablaBD["PASAPORTE"], tablaBD["NOMBRES"], tablaBD["APELLIDOS"], tablaBD["DIRECCION"], tablaBD["TELEFONOS"], tablaBD["ANTIGUEDAD"], tablaBD["OBRAS"], tablaBD["ESTUDIOS"], imagen);
                }
                catch
                {
                    tablaAux.Rows.Add(tablaBD["PASAPORTE"], tablaBD["NOMBRES"], tablaBD["APELLIDOS"], tablaBD["DIRECCION"], tablaBD["TELEFONOS"], tablaBD["ANTIGUEDAD"], tablaBD["OBRAS"], tablaBD["ESTUDIOS"], null);
               
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
