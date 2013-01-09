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
    public partial class Reservas : Form
    {
        DataTable tablaAux = new DataTable();
        public Reservas()
        {
            InitializeComponent();
            Conexion conexion = new Conexion();

            if (conexion.AbrirConexion("isaac", "isaac"))
            {
                OracleDataReader tablaBD = conexion.EjecutarSelect("select u.pasaporte pasaporte, nombres(u.NOMBRE) nombre, apellidos(u.NOMBRE) apellido, r.fecha fechaReserva, dr.status, e.costo, fp.fecha fechaPresentacion, o.nombre obra, ub.nombre ubicacion, r.idreserva from reserva r, usuario u, detalle_reserva dr, entrada e, fecha_presentacion fp, obra o, ubicacion ub where r.fkusuario = u.idusuario AND dr.pkreserva = r.idReserva AND dr.status = 'a' AND dr.pkEntrada = e.idEntrada AND e.fkPresentacion = fp.idfp AND fp.fkObra = o.idObra AND e.fkUbicacion = ub.idUbicacion");
                llenarTabla(tablaBD);
            }
        }

        public void llenarTabla(OracleDataReader tablaBD)
        {
            tablaAux.Columns.Add("Id_Reserva");
            tablaAux.Columns.Add("Id_Usuario");
            tablaAux.Columns.Add("Nombres");
            tablaAux.Columns.Add("Apellidos");
            tablaAux.Columns.Add("Opera");
            tablaAux.Columns.Add("Fecha_Reserva");
            tablaAux.Columns.Add("Fecha_Opera");
            tablaAux.Columns.Add("Ubicación");
            tablaAux.Columns.Add("Costo");
            tablaAux.Columns.Add("Status");

            while (tablaBD.Read())
            {


                tablaAux.Rows.Add(tablaBD["IDRESERVA"], tablaBD["PASAPORTE"], tablaBD["NOMBRE"], tablaBD["APELLIDO"], tablaBD["OBRA"], tablaBD["FECHARESERVA"], tablaBD["FECHAPRESENTACION"], tablaBD["UBICACION"], tablaBD["COSTO"], tablaBD["STATUS"]);

            }
            tabla.DataSource = tablaAux; 
           
        }

        private void BTBuscar_Click(object sender, EventArgs e)
        {
            
            List<string> lista = new List<string>();
            

            if (TBApellido.TextLength != 0)
            {
                lista.Add("Apellidos like '%" + TBApellido.Text + "%'");
            }

            if (TBFechaReserva.TextLength != 0)
            {
                lista.Add("Fecha_Reserva ='" + TBFechaReserva.Text + "'");
            }

            if (TBFechaOpera.TextLength != 0)
            {
               
                lista.Add("Fecha_Opera like '%" + TBFechaOpera.Text + "%'");
            }

            if ( TBIdReserva.TextLength != 0)
            {
                lista.Add("Id_Reserva='" + TBIdReserva.Text + "'");
            }
            if (TBIdUsuario.TextLength != 0)
            {
                lista.Add("Id_Usuario='" + TBIdUsuario.Text + "'");
            }
            if (TBNombre.TextLength != 0)
            {
                lista.Add("Nombres like '%" + TBNombre.Text + "%'");
            }
            if (TBOpera.TextLength != 0)
            {
                lista.Add("Opera like '%" + TBOpera.Text + "%'");
            }



            Generico.filtrar(tabla, tablaAux, Generico.generarParametroFiltrado(lista));

            if (lista.Count() == 0) //reinicia la tabla a como estaba original antes de filtrar
            {
                tabla.DataSource = tablaAux;
            }

        }

        private void TBIdReserva_KeyPress(object sender, KeyPressEventArgs e)
        {
            Generico.tbSoloNumero(e);
        }

        private void TBIdUsuario_KeyPress(object sender, KeyPressEventArgs e)
        {

            Generico.tbSoloNumero(e);

        }

      

       
        }

        



   }


