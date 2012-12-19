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

namespace WindowsFormsApplication1
{
    public partial class Form1 : Form
    {
        
        public Form1()
        {
            InitializeComponent();

            Conexion conexion = new Conexion();
            if (conexion.AbrirConexion("isaac", "isaac"))
                Console.WriteLine("se conecto");

            OracleDataReader tablaBD = conexion.EjecutarSelect("Select *from prueba");
            llenarTabla(tablaBD);

         
        }


        public Image llenarImagen(byte[] imagenBlob, String nombre)
        {
            Image imagen = null;
            int ancho = 108;
            int largo = 162;
            Bitmap b = new Bitmap(ancho, largo);
            Graphics g = Graphics.FromImage((Image)b);
            String rutaImagen = "C:/" + nombre + ".jpg"; 

            if (imagenBlob.Length != 0)
            {
                
                byte[] blob = imagenBlob;
                FileStream FS = new FileStream(rutaImagen, FileMode.Create);
                FS.Write(blob, 0, blob.Length);
                FS.Close();

                imagen = Image.FromFile(rutaImagen);
                //ajustar tamaño         
                g.InterpolationMode = InterpolationMode.HighQualityBicubic;
                    //Dibujamos la imagen con las nuevas dimensiones
                    g.DrawImage(imagen, 0, 0, ancho, largo);
                    g.Dispose();

            }
            return (Image)b;

        }


        public void llenarTabla(OracleDataReader tablaBD)
        {
            DataTable tabla = new DataTable();
            tabla.Columns.Add("id");
            tabla.Columns.Add("nombre");
            tabla.Columns.Add("foto",typeof(Image));
            
            while (tablaBD.Read())
            {
                try
                {                    
                    byte[] auxByte = (byte[])tablaBD["foto"];
                    Image imagen = llenarImagen(auxByte, tablaBD["nombre"].ToString());
                     
                    tabla.Rows.Add(tablaBD["ID"], tablaBD["nombre"],imagen);
                }
               catch
                {
                    tabla.Rows.Add(tablaBD["ID"], tablaBD["nombre"]);
                }
                

            }
            dataGridView1.DataSource = tabla;
            //dataGridView1.Columns[0].Width = 80; //ajustar tamaño de las columnnas
           
                     
        }
     

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }
    }
}
