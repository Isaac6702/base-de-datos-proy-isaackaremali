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
    public partial class Stilo : Form
    {
        public Stilo()
        {
            InitializeComponent();
            Conexion conexion = new Conexion();

            if (conexion.AbrirConexion("isaac", "isaac"))
            {
                DataTable tablaBD = conexion.procemiento("prueba");
                llenarTabla(tablaBD);
            }
        }

        public void llenarTabla(DataTable tablaAux)
        {

            tabla.DataSource = tablaAux;
           
        }

        private void BTBuscar_Click(object sender, EventArgs e)
        {
            string prueba = null;
            Console.WriteLine(prueba);
        }




   }

     

     

    }
