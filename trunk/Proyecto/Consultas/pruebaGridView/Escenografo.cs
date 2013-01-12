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
    public partial class Escenografo : Form
    {
        DataTable tablaAux = new DataTable();

        public Escenografo()
        {
            InitializeComponent();

            Conexion conexion = new Conexion();
             
            if (conexion.AbrirConexion("isaac", "isaac"))
            {
                OracleDataReader tablaBD = conexion.EjecutarSelect("select consultar_direccion(e.fklugar, e.detalleDireccion) direccion, IDESCENOGRAFO id, e.pasaporte pasaporte ,nombres(NOMBRECOMPLETO) nombres,  apellidos(NOMBRECOMPLETO) apellidos, consultar_telefonos(TELEFONO) telefonos, c.nombre cargo, Antiguedad(tc.FECHAINICIO) antiguedad , n.nombre nacionalidad from ESCENOGRAFO e, cargo c, trabajador_cargo tc, nacionalidad n, NACIONALIDAD_ESCENOGRAFO ne where tc.FKCARGO = c.IDCARGO AND e.IDESCENOGRAFO = tc.FKESCENOGRAFO AND tc.FECHAFIN is NULL AND invitado = 0 AND ne.PKNACIONALIDAD = n.idnacionalidad AND ne.PKESCENOGRAFO = e.idescenografo");
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
            tablaAux.Columns.Add("Nacionalidad");
            tablaAux.Columns.Add("foto", typeof(Image));

            while (tablaBD.Read())
            {
                try
                {
                    byte[] auxByte = (byte[])tablaBD["foto"];
                    Image imagen = Generico.llenarImagen(auxByte, tablaBD["ID"] + tablaBD["NOMBRES"].ToString());

                    tablaAux.Rows.Add(tablaBD["PASAPORTE"], tablaBD["NOMBRES"], tablaBD["APELLIDOS"], tablaBD["DIRECCION"], tablaBD["TELEFONOS"], tablaBD["antiguedad"], tablaBD["nacionalidad"], imagen);
                }
                catch
                {
                    tablaAux.Rows.Add(tablaBD["PASAPORTE"], tablaBD["NOMBRES"], tablaBD["APELLIDOS"], tablaBD["DIRECCION"], tablaBD["TELEFONOS"], tablaBD["antiguedad"], tablaBD["nacionalidad"], null);
               
                }
            
            }

            tabla.DataSource = tablaAux;                          
        }

        private void BTBuscar_Click(object sender, EventArgs e)
        {
            List<string> lista = new List<string>();

            if (TBNacionalidad.TextLength != 0)
            {
                lista.Add("Nacionalidad like '%" + TBNacionalidad.Text + "%'");
            }
            

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
                lista.Add("identificador='" + TBIdentificador.Text + "'");
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
