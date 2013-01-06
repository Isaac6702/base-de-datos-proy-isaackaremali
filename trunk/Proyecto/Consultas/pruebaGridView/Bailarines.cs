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
    public partial class Bailarines : Form
    {
        DataTable tablaAux = new DataTable();
        public Bailarines()
        {
            InitializeComponent();
            Conexion conexion = new Conexion();

            if (conexion.AbrirConexion("isaac", "isaac"))
            {
                OracleDataReader tablaBD = conexion.EjecutarSelect("select l.nombre pais, l.idlugar, b.pasaporte pasaporte, primer_nombre(b.NOMBRECOMPLETO) primerNombre, segundo_nombre(b.NOMBRECOMPLETO) segundoNombre, primer_apellido(b.NOMBRECOMPLETO) primerApellido, segundo_apellido(b.NOMBRECOMPLETO) segundoApellido, n.nombre nacionalidad, consultar_direccion(b.FKLUGAR, b.DETALLEDIRECCION)direccion, telefonos_bailarines(b.telefono) telefonos, antiguedad(tc.FECHAINICIO) antiguedad , ballet_anteriores(b.idbailarin) balletAnteriores, estudios_bailarin(idBailarin) estudios, l.bandera bandera, b.foto fotobailarin from BAILARIN b, NACIONALIDAD_BAILARIN nb, NACIONALIDAD n, trabajador_cargo tc, lugar l WHERE nb.PKBAILARIN = b.IDBAILARIN AND nb.PKNACIONALIDAD = n.IDNACIONALIDAD AND tc.FKBAILARIN = b.IDBAILARIN AND n.fkpais = l.idlugar AND b.invitado = 0");
                llenarTabla(tablaBD);
            }
        }

        public void llenarTabla(OracleDataReader tablaBD)
        {
            tablaAux.Columns.Add("Identificardor");
            tablaAux.Columns.Add("Primer_Nombre");
            tablaAux.Columns.Add("Segundo_Nombre");
            tablaAux.Columns.Add("Primer_Apellido");
            tablaAux.Columns.Add("Segundo_Apellido");
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
                    Image foto = Generico.llenarImagen(fotoBailarin, tablaBD["PASAPORTE"] + tablaBD["PRIMERNOMBRE"].ToString());
                    tablaAux.Rows.Add(tablaBD["PASAPORTE"], tablaBD["PRIMERNOMBRE"], tablaBD["SEGUNDONOMBRE"], tablaBD["PRIMERAPELLIDO"], tablaBD["SEGUNDOAPELLIDO"], tablaBD["NACIONALIDAD"], null, tablaBD["DIRECCION"], tablaBD["TELEFONOS"], tablaBD["ESTUDIOS"], tablaBD["ANTIGUEDAD"], tablaBD["balletAnteriores"], foto);

                }
                catch {
                    tablaAux.Rows.Add(tablaBD["PASAPORTE"], tablaBD["PRIMERNOMBRE"], tablaBD["SEGUNDONOMBRE"], tablaBD["PRIMERAPELLIDO"], tablaBD["SEGUNDOAPELLIDO"], tablaBD["NACIONALIDAD"], null, tablaBD["DIRECCION"], tablaBD["TELEFONOS"], tablaBD["ESTUDIOS"], tablaBD["ANTIGUEDAD"], tablaBD["balletAnteriores"], null);

                
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

            if (TBSegundoApellido.TextLength != 0)
            {
                lista.Add("Segundo_Apellido='" + TBSegundoApellido.Text + "'");
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