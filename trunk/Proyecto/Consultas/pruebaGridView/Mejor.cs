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
    public partial class Mejor : Form
    {
        Conexion conexion = new Conexion();
        DataTable tablaAux = new DataTable();
        public Mejor()
        {
            InitializeComponent();
            
           if (conexion.AbrirConexion("isaac", "isaac"))
            {
                DataTable tablaBD = conexion.procemiento("CT_ObraMasVendida");
                DataTable tablaBallet = conexion.procemiento("CT_BalletMasVendido");
                DataTable tablaOrquesta = conexion.procemiento("CT_OrquestaMasVendida");
                DataTable tablaAutor = conexion.procemiento("CT_AutorMasVendido");
                DataTable tablaDirector = conexion.procemiento("CT_DirectorMasVendido");
                DataTable tablaMezzo = conexion.procemiento("CT_mezzoMasVendido");
                DataTable tablaTenor = conexion.procemiento("CT_tenorMasVendido");
                DataTable tablaBaritono = conexion.procemiento("CT_baritonoMasVendido");
                DataTable tablaBajo = conexion.procemiento("CT_bajoMasVendido");
                DataTable tablaContralto = conexion.procemiento("CT_contraltoMasVendido");
                DataTable tablaSoprano = conexion.procemiento("CT_sopranoMasVendido");
                llenarTabla(tablaBD, tablaBallet, tablaOrquesta,tablaAutor, tablaDirector, tablaMezzo, tablaTenor, tablaBaritono, tablaBajo, tablaContralto, tablaSoprano);
            }
        }

        public void llenarTabla(DataTable tablaAux, DataTable tablaB, DataTable tablaO, DataTable tablaA, DataTable tablaD, DataTable tablaM, DataTable tablaT, DataTable tablaBa, DataTable tablaBj, DataTable tablaC, DataTable tablaS)
        {

            tablaObra.DataSource = tablaAux;
            tablaBallet.DataSource = tablaB;
            tablaOrquesta.DataSource = tablaO;
            tablaAutor.DataSource = tablaA;
            tablaDirector.DataSource = tablaD;
            tablaMezzo.DataSource = tablaM;
            tablaTenor.DataSource = tablaT;
            tablaBaritono.DataSource = tablaBa;
            tablaBajo.DataSource = tablaBj;
            tablaContralto.DataSource = tablaC;
            tablaSoprano.DataSource = tablaS;
           
        }

        private void nombreReporte_Click(object sender, EventArgs e)
        {

        }

        private void label4_Click(object sender, EventArgs e)
        {

        }

      



   }

     

     

    }
