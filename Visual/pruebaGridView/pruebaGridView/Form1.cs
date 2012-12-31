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
    public partial class Form1 : Form
    {
        DataTable tablaAux = new DataTable();
        public Form1()
        {
            InitializeComponent();

            Conexion conexion = new Conexion();
             
            if (conexion.AbrirConexion("isaac", "isaac"))
            {
                OracleDataReader tablaBD = conexion.EjecutarSelect("select IDTRABAJADOR id, consulta_primer_nombre(IDTRABAJADOR) PrimerNombre, consulta_segundo_nombre(IDTRABAJADOR) SegundoNombre, consulta_primer_apellido(IDTRABAJADOR) PrimerApellido, consulta_segundo_apellido(IDTRABAJADOR) SegundoNombre, consulta_telefonos(IDTRABAJADOR) telefonos,c.nombre cargo, edades(tc.FECHAINICIO)antigüedad, t.foto from trabajador t, cargo c, trabajador_cargo tc where tc.FKCARGO = c.IDCARGO AND t.IDTRABAJADOR = tc.FKTRABAJADOR AND tc.FECHAFIN = NULL");
                llenarTabla(tablaBD);
            }
        }

        public Image llenarImagen(byte[] imagenBlob, String nombre)
        {
            Image imagen = null;
            int ancho = 75;
            int largo = 97;
            Bitmap b = new Bitmap(ancho, largo);
            Graphics g = Graphics.FromImage((Image)b);
            String rutaImagen = "C:/fotos/" + nombre + ".jpg";

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

            tablaAux.Columns.Add("Primer Nombre");
            tablaAux.Columns.Add("Segundo Nombre");
            tablaAux.Columns.Add("Primer Apellido");
            tablaAux.Columns.Add("Segundo Apelldio");
            tablaAux.Columns.Add("Teléfono");
            tablaAux.Columns.Add("Cargo");
            tablaAux.Columns.Add("Antigüedad");
            tablaAux.Columns.Add("foto", typeof(Image));

            while (tablaBD.Read())
            {
                try
                {
                    byte[] auxByte = (byte[])tablaBD["foto"];
                    Image imagen = llenarImagen(auxByte,tablaBD["ID"] + tablaBD["PRIMERNOMBRE"].ToString());

                    tablaAux.Rows.Add(tablaBD["PRIMERNOMBRE"], tablaBD["SEGUNDONOMBRE"], tablaBD["PRIMERAPELLIDO"], tablaBD["SEGUNDONOMBRE"], tablaBD["TELEFONOS"], tablaBD["CARGO"], tablaBD["antigüedad"], imagen);
                }
                catch
                {
                    tablaAux.Rows.Add(tablaBD["PRIMERNOMBRE"], tablaBD["SEGUNDONOMBRE"], tablaBD["PRIMERAPELLIDO"], tablaBD["SEGUNDONOMBRE"], tablaBD["TELEFONOS"], tablaBD["CARGO"], tablaBD["antigüedad"]);
               
                }
            
            }

            tabla.DataSource = tablaAux;                          
        }




   }

     

     

    }
