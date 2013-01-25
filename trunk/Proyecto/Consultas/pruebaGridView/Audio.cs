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
using System.Media;
using WMPLib;

namespace pruebaGridView
{
    
    public partial class Audio : Form
    {
        WindowsMediaPlayer wplayer = new WindowsMediaPlayer();
        public Audio()
        {
            DataTable tablaAux = new DataTable();
            InitializeComponent();
            Conexion conexion = new Conexion();

            if (conexion.AbrirConexion("isaac", "isaac"))
            {
                DataTable tablaBD = conexion.procemiento("CT_Audio_Sin");
                
                tablaAux.Columns.Add("obra");
                tablaAux.Columns.Add("directores");
                tablaAux.Columns.Add("fecha");
                tablaAux.Columns.Add("orquesta");
                tablaAux.Columns.Add("formato");
                //tablaAux.Columns.Add("audio", typeof(Button));
                

                llenarTabla(tablaBD);
            }
        }

        public void llenarTabla(DataTable tablaAux)
        {
           /* tablaAux.Columns.Add("AUDIO", typeof(DataGridViewButtonColumn));
            foreach (DataRow row in tablaAux.Rows)
            {
                DataGridViewButtonColumn b = new DataGridViewButtonColumn();
                b.HeaderText = "play";
                row[5] = b;
                b.UseColumnTextForButtonValue = true;
            }*/
            tablaAux.Columns.Add("AUDIO", typeof(WindowsMediaPlayer));
            foreach (DataRow row in tablaAux.Rows)
            {
               // WindowsMediaPlayer wplayer = new WindowsMediaPlayer();


              
             //   wplayer.openPlayer("C:\\BaseDeDatosII\\audios\\laboheme.mp3");
                 wplayer.URL = "C:\\BaseDeDatosII\\audios\\laboheme.mp3";
               // wplayer.controls.play();
               
                row[5] = wplayer;
                
            }
            

            tabla.DataSource = tablaAux;
           
        }


      
        private void tabla_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            wplayer.openPlayer("C:\\BaseDeDatosII\\audios\\laboheme.mp3");
            //wplayer.controls.play();
        }

    




   }

     

     

    }

     

     

    
