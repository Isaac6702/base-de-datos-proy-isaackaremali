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
    public partial class Facturas: Form
    {
        DataTable tablaAux = new DataTable();
        List<Factura> listaFactura = new List<Factura>();


        public int buscarFactura(int b)
        {
            for (int i = 0; i < listaFactura.Count(); i++)
            {
                if(int.Parse(listaFactura[i].NroFactura) == b)
                {
                    return i;

                }
            }

            return -1;

        }
        
        public Facturas()
        {
            InitializeComponent();
            tabla.DefaultCellStyle.WrapMode = DataGridViewTriState.True;
            tablaAux.Columns.Add("Asiento");
            tablaAux.Columns.Add("Zona");
            tablaAux.Columns.Add("Status");
            tablaAux.Columns.Add("Costo");
            Conexion conexion = new Conexion();

            if (conexion.AbrirConexion("isaac", "isaac"))
            {
                OracleDataReader tablaBD = conexion.EjecutarSelect("select u.pasaporte,nombres(u.nombre) nombres, apellidos(u.nombre) apellidos, consultar_telefonos(u.telefono) telefonos, consultar_direccion(u.fklugar,u.detalleDireccion) direccion ,f.idfactura,to_char(f.fecha,'dd/mm/yyyy') fecha, a.nombre asiento, z.nombre zona, e.costo, e.pagada from factura f, usuario u, detalle_factura df, entrada e, ubicacion a, ubicacion z where f.fkusuario = u.idusuario AND df.fkfactura = f.idfactura AND df.fkentrada = e.identrada AND a.fkubicacion = z.idubicacion AND  a.tipo = 'asiento' AND e.fkubicacion = a.idubicacion");
                llenarObjeto(tablaBD);
               
            }
        }

        public void llenarPantalla(int i)
        {
            tablaAux.Clear();
            float contador = 0;
          
                LBFecha.Text = "Fecha: "+listaFactura[i].Fecha;
                LBNombres.Text = "Nombres y Apellidos: " + listaFactura[i].NombresApellidos;
                LBNroFactura.Text = "Nro Factura: " + listaFactura[i].NroFactura;
                LBNroId.Text = "Nro de Identificador: " + listaFactura[i].Id;
                LBTelefono.Text = "Telefonos: " + listaFactura[i].Telefono;
                LBDireccion.Text = "Direccion : "+listaFactura[i].Direccion;
               
                for (int j = 0; j < listaFactura[i].Df.Count(); j++)
                {

                    tablaAux.Rows.Add(listaFactura[i].Df[j].Asiento, listaFactura[i].Df[j].Zona, listaFactura[i].Df[j].Status, listaFactura[i].Df[j].Costo);
                    contador = contador + float.Parse(listaFactura[i].Df[j].Costo);
                }
                LBTotal.Text = "Total: "+contador.ToString();
                tabla.DataSource = tablaAux;
        }


        public void llenarObjeto(OracleDataReader tablaBD)
        {
            Factura aux = new Factura();
            aux.Df = new List<DetalleFactura>();

            while (tablaBD.Read())
            {
                if (aux.NroFactura == null)
                {
                    aux.NroFactura =  tablaBD["IDFACTURA"].ToString();
                    aux.Id = tablaBD["PASAPORTE"].ToString();
                    aux.NombresApellidos = tablaBD["NOMBRES"].ToString() + " " + tablaBD["APELLIDOS"].ToString();
                    aux.Telefono = tablaBD["TELEFONOS"].ToString();
                    aux.Direccion = tablaBD["DIRECCION"].ToString();
                    aux.Fecha = tablaBD["FECHA"].ToString();
                    aux.Df.Add( new DetalleFactura( tablaBD["ASIENTO"].ToString(), tablaBD["ZONA"].ToString(),tablaBD["COSTO"].ToString(),tablaBD["PAGADA"].ToString()));
                }
                else
                {
                    if(aux.NroFactura.Equals( tablaBD["IDFACTURA"].ToString()))
                    {
                        aux.Df.Add( new DetalleFactura( tablaBD["ASIENTO"].ToString(), tablaBD["ZONA"].ToString(),tablaBD["COSTO"].ToString(),tablaBD["PAGADA"].ToString()));
                    }
                    else{
                            listaFactura.Add(aux);
                            aux = new Factura();
                            aux.Df = new List<DetalleFactura>();
                            aux.NroFactura =  tablaBD["IDFACTURA"].ToString();
                            aux.Id = tablaBD["PASAPORTE"].ToString();
                            aux.NombresApellidos = tablaBD["NOMBRES"].ToString() + " " + tablaBD["APELLIDOS"].ToString();
                            aux.Telefono = tablaBD["TELEFONOS"].ToString();
                            aux.Direccion = tablaBD["DIRECCION"].ToString();
                            aux.Fecha = tablaBD["FECHA"].ToString();
                            aux.Df.Add(new DetalleFactura(tablaBD["ASIENTO"].ToString(), tablaBD["ZONA"].ToString(), tablaBD["COSTO"].ToString(), tablaBD["PAGADA"].ToString()));
       
                    }
                }
             }
            listaFactura.Add(aux);
            llenarPantalla(0);

        }



        private void tabla_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void LBFecha_Click(object sender, EventArgs e)
        {

        }

        private void textBox1_KeyPress(object sender, KeyPressEventArgs e)
        {
            Generico.tbSoloNumero(e);
        }

        private void BTBuscar_Click(object sender, EventArgs e)
        {
            int index =buscarFactura(int.Parse(TBBuscar.Text));
            if (index != -1)
            {
                llenarPantalla(index);

            }


        }




   }

     

     

    }
