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
    
    public partial class Video : Form
    {
        WindowsMediaPlayer wplayer = new WindowsMediaPlayer();
        Conexion conexion = new Conexion();
        public Video()
        {
            DataTable tablaAux = new DataTable();
            
            InitializeComponent();
            DTFecha.CustomFormat = "dd/MM/yyyy";
            tabla.DefaultCellStyle.WrapMode = DataGridViewTriState.True;
            if (conexion.AbrirConexion("isaac", "isaac"))
            {
                DataTable tablaBD = conexion.procemiento("CT_Video");
                
                
                llenarTabla(tablaBD);
            }
        }

        public void llenarTabla(DataTable tablaAux)
        {
            tabla.DataSource = tablaAux;
        }


      
        private void tabla_CellClick(object sender, DataGridViewCellEventArgs e)
        {

            
                Conexion conexion = new Conexion();
                tabla.DefaultCellStyle.WrapMode = DataGridViewTriState.True;
                if (conexion.AbrirConexion("isaac", "isaac"))
                {
                    wplayer.close();
                    DataTable tablaAudio = conexion.filtrar("CT_Contenido_Video", tabla.Rows[e.RowIndex].Cells[0].Value.ToString());
                    if (tablaAudio != null)
                    {
                        byte[] bytes = (byte[])tablaAudio.Rows[0][0];
                        
                        try
                        {
                            wplayer.openPlayer(Generico.llenarAudio(bytes, "video" + tabla.Rows[e.RowIndex].Cells[0].Value.ToString()));
                        }
                        catch
                        {
                        }
                        
                    }
                }
            
           
        }

        private void label1_Click(object sender, EventArgs e)
        {





        }

        private void BTbuscar_Click(object sender, EventArgs e)
        {
            List<string> lista = new List<string>();


            if (TBAutor.TextLength != 0)
            {
                lista.Add(TBAutor.Text);
            }
            else
                lista.Add("null");

            if (TBObra.TextLength != 0)
            {
                lista.Add(TBObra.Text);
            }
            else
                lista.Add("null");

            if (DTFecha.Checked)
            {
                lista.Add(DTFecha.Text);

            }
            else
                lista.Add("null");


            if (conexion.AbrirConexion("isaac", "isaac"))
            {

                DataTable tablaBD = conexion.filtrar("FT_Video", Generico.generarParametroFiltrado(lista));
                llenarTabla(tablaBD);
            }
        }

    




   }

     

     

    }

     

     

    
