using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace pruebaGridView
{
    static class Generico    
    {
        public static void tbSoloNumero(KeyPressEventArgs e)
        {

            if (Char.IsDigit(e.KeyChar))
            {
                e.Handled = false;
            }
            else if (Char.IsControl(e.KeyChar))
            {
                e.Handled = false;
            }
            else if (Char.IsSeparator(e.KeyChar))
            {
                e.Handled = false;
            }
            else
            {
                e.Handled = true;
            }
        }
        public static string generarParametroFiltrado(List<string> lista)
        {
            string parametro = "";
            for (int i = 0; i < lista.Count(); i++)
            {
                if (i == lista.Count() - 1)
                    parametro = parametro + lista[i];
                else
                    parametro = parametro + lista[i] + ",";

            }
            return parametro;
        }

        public static void filtrar(DataGridView gridView, DataTable tablaReporte, String parametroFiltrado)
        {
            BindingSource filtro = new BindingSource();
            filtro.DataSource = tablaReporte.Copy();
            if (parametroFiltrado.Length != 0)
            {
                filtro.Filter = parametroFiltrado;

                gridView.DataSource = filtro;
            }
            
        }
     


        public static Image llenarImagen(byte[] imagenBlob, String nombre)
        {
            Image imagen = null;
            int ancho = 75;
            int largo = 97;
            Bitmap b = new Bitmap(ancho, largo);
            Graphics g = Graphics.FromImage((Image)b);
            String rutaImagen = "C:/fotos/" + nombre + ".jpg";

            Console.WriteLine(" holaaaaaa =");
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

        public static String llenarPDF(byte[] pdfBlob, String nombre)
        {
            
            String rutaPDF = "C:/pdf/" + nombre + ".pdf";


            if (pdfBlob.Length != 0)
            {

                byte[] blob = pdfBlob;
                FileStream FS = new FileStream(rutaPDF, FileMode.Create);
                FS.Write(blob, 0, blob.Length);
                FS.Close();

                return rutaPDF;

            }
            return null;

        }
        public static String llenarAudio(byte[] audioBlob, String nombre)
        {
            String rutaAudio = "C:/audio/" + nombre + ".mp3";

            if (audioBlob.Length != 0)
            {
                try
                {
                    byte[] blob = audioBlob;
                    FileStream FS = new FileStream(rutaAudio, FileMode.Create);
                    FS.Write(blob, 0, blob.Length);
                    FS.Close();
                    return rutaAudio;
                }
                catch
                {
                    return null;
                }
            }
            return null;

        }

    }
}
