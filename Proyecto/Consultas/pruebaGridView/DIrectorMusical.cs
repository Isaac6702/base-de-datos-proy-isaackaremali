﻿using pruebaViewGrid;
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
    public partial class DirectorMusical : Form
    {
        DataTable tablaAux = new DataTable();

        public DirectorMusical()
        {
            InitializeComponent();

            Conexion conexion = new Conexion();
             
            if (conexion.AbrirConexion("isaac", "isaac"))
            {
                OracleDataReader tablaBD = conexion.EjecutarSelect("select consultar_direccion(dm.fklugar, dm.detalleDireccion) direccion, IDDM id, dm.pasaporte pasaporte ,primer_nombre(NOMBRECOMPLETO) PrimerNombre, segundo_nombre(NOMBRECOMPLETO) SegundoNombre, primer_apellido(NOMBRECOMPLETO) PrimerApellido, segundo_apellido(NOMBRECOMPLETO) SegundoApellido, consultar_telefonos(TELEFONO) telefonos, c.nombre cargo, Antiguedad(tc.FECHAINICIO) antiguedad, consultar_obras_DM(dm.iddm) obras, dm.foto foto from director_musical dm, cargo c, trabajador_cargo tc where tc.FKCARGO = c.IDCARGO AND dm.IDDM = tc.FKDM AND tc.FECHAFIN is NULL AND invitado = 0  ");  
                llenarTabla(tablaBD);
            }
        }

       
        public void llenarTabla(OracleDataReader tablaBD)
        {

            tablaAux.Columns.Add("Identificador");
            tablaAux.Columns.Add("Primer_Nombre");
            tablaAux.Columns.Add("Segundo_Nombre");
            tablaAux.Columns.Add("Primer_Apellido");
            tablaAux.Columns.Add("Segundo_Apellido");
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
                    Image imagen = Generico.llenarImagen(auxByte,tablaBD["ID"] + tablaBD["PRIMERNOMBRE"].ToString());

                    tablaAux.Rows.Add(tablaBD["PASAPORTE"], tablaBD["PRIMERNOMBRE"], tablaBD["SEGUNDONOMBRE"], tablaBD["PRIMERAPELLIDO"], tablaBD["SEGUNDOAPELLIDO"], tablaBD["DIRECCION"], tablaBD["TELEFONOS"], tablaBD["antiguedad"], tablaBD["obras"], imagen);
                }
                catch
                {
                    tablaAux.Rows.Add(tablaBD["PASAPORTE"], tablaBD["PRIMERNOMBRE"], tablaBD["SEGUNDONOMBRE"], tablaBD["PRIMERAPELLIDO"], tablaBD["SEGUNDOAPELLIDO"], tablaBD["DIRECCION"], tablaBD["TELEFONOS"], tablaBD["antiguedad"], tablaBD["obras"], null);
               
                }
            
            }

            tabla.DataSource = tablaAux;                          
        }

        private void BTBuscar_Click(object sender, EventArgs e)
        {
            List<string> lista = new List<string>();
            

            if (TBPrimerNombre.TextLength != 0)
            {
                lista.Add("Primer_Nombre like '%" + TBPrimerNombre.Text + "%'");
            }

            if (TBSegundoNombre.TextLength != 0)
            {
                lista.Add("Segundo_Nombre like '%" + TBSegundoNombre.Text + "%'");
            }

            if (TBPrimerApellido.TextLength != 0)
            {
                lista.Add("Primer_Apellido like '%" + TBPrimerApellido.Text + "%'");
            }

            if (TBSegundoApelldio.TextLength!= 0)
            {
                lista.Add("Segundo_Apellido like '%" + TBSegundoApelldio.Text + "%'");
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