using pruebaViewGrid;
using System;
using System.Collections;
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
    public partial class VentaEntradas : Form
    {
        DataTable tablaAux = new DataTable();
        List<Usuario> listaUsurio = new List<Usuario>();
        int insertDB;
        public VentaEntradas()
        {
            InitializeComponent();

        }

        public bool validarCantidadPuestos()
        {
            Conexion conexion = new Conexion();

            if (conexion.AbrirConexion("isaac", "isaac"))
            {
                OracleDataReader tablaBD = conexion.EjecutarSelect("select COUNT (e.identrada) total from entrada e, ubicacion a, ubicacion z, fecha_presentacion fp, obra o where e.FKUBICACION = a.idubicacion AND a.fkubicacion = z.idubicacion AND a.tipo = 'asiento' and e.pagada = 0 and e.FKPRESENTACION = fp.idfp and fp.FKOBRA = o.idobra and fp.fecha = to_date('"+listaUsurio[0].FechaPresentacion+"','dd/mm/yy') and z.idubicacion ="+listaUsurio[0].IdZona[0].ToString()+" and o.nombre = '"+listaUsurio[0].Obra.Trim()+"'");

                try
                {
                    while (tablaBD.Read())
                    {
                        Console.WriteLine("pruebaaa... " + listaUsurio[0].Obra + " ... " + listaUsurio[0].IdZona[0]+ " ... " + listaUsurio[0].FechaPresentacion + " ... " + tablaBD["TOTAL"].ToString() + " < " + listaUsurio[0].Nro_entradas);
                        if (int.Parse(tablaBD["TOTAL"].ToString()) < listaUsurio[0].Nro_entradas)
                        {

                            MessageBox.Show("ERROR no hay suficientes entradas disponibles " );
                            return false;
                        }

                    }
                }
                catch
                {
                    MessageBox.Show("ERROR en los datos ");
                }
            }
            return true;
        }

        public  bool validarArchivo(ArrayList lista)
        {
            String[] linea;
            char[] delimiterChars = { ':'};

            Usuario u = new Usuario();
            u.Telefono = new List<int>();
            u.IdZona = new List<int>();
            int i =0;
            bool result;
            foreach (string sOutput in lista)
            {
               
                linea = sOutput.ToString().Split(delimiterChars);
             
                switch (linea[0])
                {
                    case "FIN":
                        listaUsurio.Add(u);
                        u = new Usuario();
                        break;

                    case "id":
                        try
                        {
                            u.Identificador = int.Parse(linea[1]);

                        }
                        catch (Exception)
                        {
                            MessageBox.Show("ERROR de formato en el id "+ linea[1]);
                            return false;
                        }

                        break;

                    case "telefono":
                       result = int.TryParse(linea[1], out i);
                       if (!result)
                       {

                           MessageBox.Show("ERROR de formato en el telefono " + linea[1]);
                           return false;
                       }
                       else {
                          
                           u.Telefono.Add(i);
                       }
       
                        break;


                    case "ciudad":
                        try
                        {
                            u.FkDireccion = int.Parse(linea[1]); 
                        }
                        catch (Exception)
                        {
                            MessageBox.Show("ERROR de formato en ciudad");
                            return false;
                        }
                        
                        break;

                    case "obra":
                        u.Obra = linea[1];

                        break;

                    case "fecha_prensetacion":
                        u.FechaPresentacion = linea[1];
                        break;

                    case "nro_entradas":
                        try
                        {
                            u.Nro_entradas = int.Parse(linea[1]);
                        }
                        catch (Exception)
                        {
                            MessageBox.Show("ERROR de formato en numero de entrada tiene que ser un numero");
                            return false;
                        }
                        break;

                    case "idZona":
                      
                       result = int.TryParse(linea[1], out i);
                       if (!result)
                       {

                           MessageBox.Show("ERROR de formato idZona tiene que ser un numero " + linea[1]);
                           return false;
                       }
                       else {
                           u.IdZona.Add(i);
                       }
                        break;

                    case "nombre":

                        u.Nombre=linea[1];
                        break;

                    default:
                        MessageBox.Show("ERROR de formato " + linea[1]);
                        return false;
                        break;

                }

            }
            return true;
        }

        public void insertEntradas()
        {
             Conexion conexion = new Conexion();

             if (conexion.AbrirConexion("isaac", "isaac"))
             {
                 OracleDataReader idFactura = conexion.EjecutarSelect("Select SEQFACTURA.nextval from dual");
                 while (idFactura.Read())
                 {
                    
                     insertDB = conexion.EjecutarInsert("insert into factura (IDFACTURA,FECHA,FKUSUARIO) values(" + idFactura["NEXTVAL"].ToString() + ",to_date('" + listaUsurio[0].FechaPresentacion + "','dd/mm/yyyy'),1)");
                    
                     if (insertDB == 1)
                     {
                         OracleDataReader tabla1 = conexion.EjecutarSelect("select z.nombre zona, a.nombre asiento, e.identrada, e.costo from entrada e, ubicacion a, ubicacion z, fecha_presentacion fp, obra o where e.FKUBICACION = a.idubicacion AND a.fkubicacion = z.idubicacion AND a.tipo = 'asiento' and e.pagada = 0 and e.FKPRESENTACION = fp.idfp and fp.FKOBRA = o.idobra and fp.fecha = to_date('" + listaUsurio[0].FechaPresentacion + "','dd/mm/yy') and z.idubicacion =" + listaUsurio[0].IdZona[0].ToString() + " and o.nombre = '" + listaUsurio[0].Obra.Trim()+ "' and rownum < "+listaUsurio[0].Nro_entradas);
                         while (tabla1.Read())
                         {
                             insertDB = conexion.EjecutarInsert("insert into DETALLE_FACTURA (IDDF, MONTO, FKFACTURA, FKENTRADA) values(SEQDF.nextval, " + tabla1["COSTO"] + ", " + idFactura["NEXTVAL"] + ", " + tabla1["IDENTRADA"]+")");
                           
                             if (insertDB != 1)
                             {
                                 MessageBox.Show("ERROR el detalle de la factura");
                             }
                             else
                             {
                                 llenarTabla(tabla1, idFactura["NEXTVAL"].ToString());
                             }


                         }

                     }

                     else
                     {
                         MessageBox.Show("ERROR al insertar el usuario");
                     }

                 }
                   
             }

        }
        public void archivo(string ruta)
        {
            StreamReader objReader = new StreamReader(ruta);
            string sLine = "";
            ArrayList arrText = new ArrayList();

            while (sLine != null)
            {
                sLine = objReader.ReadLine();
                if (sLine != null)
                {
                    arrText.Add(sLine);
                }
            }
            objReader.Close();
            bool b1= validarArchivo(arrText);
            bool b2 = validarCantidadPuestos();
            if (b1 && b2)
            {
                Console.WriteLine("entrooo en validar");
                insertEntradas();
            }


        }

        
        public void llenarTabla(OracleDataReader tablaBD, string factura)
        {
            tablaAux.Columns.Add("Nro_Factura");
            tablaAux.Columns.Add("Asiento");
            tablaAux.Columns.Add("Zona");
            tablaAux.Columns.Add("Costo");
            float total = 0;
            while (tablaBD.Read())
            {
                tablaAux.Rows.Add(factura, tablaBD["ASIENTO"], tablaBD["ZONA"], tablaBD["COSTO"]);
                total = total + float.Parse(tablaBD["COSTO"].ToString());
                 
            }

            LBApagar.Text = "Total a pagar: "+total.ToString();
            tabla.DataSource = tablaAux;
            
           
        }

        private void nombreReporte_Click(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            openFileDialog1.ShowDialog();
 
        }

        private void openFileDialog1_FileOk(object sender, CancelEventArgs e)
        {
            tbRutaArchivo.Text = openFileDialog1.FileName;
            archivo(tbRutaArchivo.Text);
        }




   }

     

     

    }
