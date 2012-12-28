using pruebaViewGrid;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.OracleClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace pruebaGridView
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();

            Conexion conexion = new Conexion();
             
            if (conexion.AbrirConexion("karem", "karem"))
            {
                    OracleDataReader tablaBD = conexion.EjecutarSelect("select * from INSTRUMENTO");
                    llenarTabla(tablaBD);
            }
        }

        public void llenarTabla(OracleDataReader tablaBD)
        {

          

            tabla.ColumnCount = 2;
            tabla.Columns[0].Name = "id";
            tabla.Columns[1].Name = "nombre";

                
            while (tablaBD.Read())
                tabla.Rows.Add(tablaBD["idInstrumento"], tablaBD["nombre"]);
              
              
                 
        }




   }

     

     

    }
